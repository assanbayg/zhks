// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/widgets/custom_app_bar.dart';
import 'package:zhks/features/auth/presentation/widgets/page_indicator.dart';
import 'package:zhks/features/auth/presentation/widgets/personal_info_form.dart';
import 'package:zhks/features/auth/presentation/widgets/property_form.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
  String _selectedGender = 'male';

  // TODO: take a RC list from API. hardcoding is temp
  final List<String> _rcOptions = ['Легенда', 'Манхэттен', 'Опера'];
  // TODO: уточнить что это
  final List<String> _queueOptions = ['Очередь 1', 'Очередь 2', 'Очередь 3'];

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
    // TODO: add verification logic with backend
    context.go('/thanks');
  }

  void _onRCChanged(String? rc) {
    setState(() => _selectedRC = rc);
  }

  void _onQueueChanged(String? queue) {
    setState(() => _selectedQueue = queue);
  }

  void _onGenderChanged(String gender) {
    setState(() => _selectedGender = gender);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(label: 'Регистрация'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            PageIndicator(currentPage: _currentPage, pageCount: 2),
            const SizedBox(height: 24),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  PropertyForm(
                    rcOptions: _rcOptions,
                    queueOptions: _queueOptions,
                    selectedRC: _selectedRC,
                    selectedQueue: _selectedQueue,
                    entranceController: _entranceController,
                    floorController: _floorController,
                    flatNumberController: _flatNumberController,
                    isFormValid: _isPropertyFormValid,
                    onRCChanged: _onRCChanged,
                    onQueueChanged: _onQueueChanged,
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
                    onGenderChanged: _onGenderChanged,
                    onSubmit: _validateAndSubmit,
                    onBack: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
