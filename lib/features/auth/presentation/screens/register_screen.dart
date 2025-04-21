// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/data/models/zhk.dart';
import 'package:zhks/core/presentation/providers/zhk_providers.dart';
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/features/auth/data/models/resident.dart';
import 'package:zhks/features/auth/presentation/providers/auth_provider.dart';
import 'package:zhks/features/auth/presentation/providers/roommates_provider.dart';
import 'package:zhks/features/auth/presentation/widgets/page_indicator.dart';
import 'package:zhks/features/auth/presentation/widgets/personal_info_form.dart';
import 'package:zhks/features/auth/presentation/widgets/property_form.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  int _currentPage = 0;

  final PageController _controller = PageController();

  // контроллеры и значения для ЖК формы
  final TextEditingController _entranceController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _flatNumberController = TextEditingController();
  String? _selectedRC;
  String? _selectedQueue;

  // это для персонал инфо
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedGender = '';

  final List<String> _queueOptions = ['1', '2', '3'];

  bool get _isPropertyFormValid =>
      _selectedRC != null &&
      _selectedQueue != null &&
      _entranceController.text.trim().isNotEmpty &&
      _floorController.text.trim().isNotEmpty &&
      _flatNumberController.text.trim().isNotEmpty;

  bool get _isEmailValid =>
      _emailController.text.trim().isNotEmpty &&
      RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(_emailController.text);

  bool get _isPersonalInfoValid =>
      _selectedGender.isNotEmpty &&
      _isEmailValid &&
      _firstNameController.text.trim().isNotEmpty &&
      _lastNameController.text.trim().isNotEmpty &&
      _phoneController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_pageListener);

    // Add listeners to update state when text fields change
    _entranceController.addListener(() => setState(() {}));
    _floorController.addListener(() => setState(() {}));
    _flatNumberController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _firstNameController.addListener(() => setState(() {}));
    _lastNameController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.removeListener(_pageListener);
    _controller.dispose();
    _entranceController.dispose();
    _floorController.dispose();
    _flatNumberController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _pageListener() {
    if (_controller.page?.round() != _currentPage) {
      setState(() => _currentPage = _controller.page!.round());
    }
  }

  void _validateAndSubmit() {
    // Find the selected ZHK id
    final zhkListAsyncValue = ref.read(zhkListProvider);
    int? zhkId;

    zhkListAsyncValue.whenData((zhkList) {
      final selectedZhk = zhkList.firstWhere(
        (zhk) => zhk.name == _selectedRC,
        orElse: () => Zhk(id: -1, name: ''),
      );
      zhkId = selectedZhk.id;
    });

    if (zhkId == null || zhkId == -1) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Ошибка: ЖК не выбран')));
      return;
    }

    final resident = Resident(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      gender: _selectedGender,
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      zhkId: zhkId!,
      queue: _selectedQueue!,
      entranceNumber: _entranceController.text.trim(),
      floor: _floorController.text.trim(),
      apartmentNumber: _flatNumberController.text.trim(),
    );

    ref.read(authStateProvider.notifier).register(resident);
    ref.read(roommatesProvider.notifier).addRoommate(resident);

    // Navigate to thanks screen
    context.go('/thanks');
  }

  void onRCChanged(String? rc) {
    setState(() => _selectedRC = rc);
  }

  void onQueueChanged(String? queue) {
    setState(() => _selectedQueue = queue);
  }

  void onGenderChanged(String gender) {
    setState(() => _selectedGender = gender);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final zhkListAsyncValue = ref.watch(zhkListProvider);

    // Show error if any
    if (authState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(authState.error!)));
        // Clear error
        ref.read(authStateProvider.notifier).clearError();
      });
    }

    return Scaffold(
      appBar: CustomAppBar(
        label: 'Регистрация',
        showBackButton: true,
        location: '/login',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            PageIndicator(currentPage: _currentPage, pageCount: 2),
            const SizedBox(height: 24),
            Expanded(
              child: zhkListAsyncValue.when(
                data: (zhkList) {
                  final rcOptions = zhkList.map((zhk) => zhk.name).toList();

                  return PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged:
                        (index) => setState(() => _currentPage = index),
                    children: [
                      PropertyForm(
                        rcOptions: rcOptions,
                        queueOptions: _queueOptions,
                        selectedRC: _selectedRC,
                        selectedQueue: _selectedQueue,
                        entranceController: _entranceController,
                        floorController: _floorController,
                        flatNumberController: _flatNumberController,
                        isFormValid: _isPropertyFormValid,
                        onRCChanged: onRCChanged,
                        onQueueChanged: onQueueChanged,
                        onContinue: () {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                      PersonalInfoForm(
                        gender: _selectedGender,
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        phoneNumber: _phoneController.text,
                        emailController: _emailController,
                        firstNameController: _firstNameController,
                        lastNameController: _lastNameController,
                        phoneController: _phoneController,
                        isFormValid: _isPersonalInfoValid,
                        onGenderChanged: onGenderChanged,
                        onSubmit: _validateAndSubmit,
                        onBack: () {
                          _controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (error, stack) => Center(
                      child: Text(
                        'Ошибка загрузки данных: ${error.toString()}',
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
