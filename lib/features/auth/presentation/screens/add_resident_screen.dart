// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/features/auth/data/models/resident.dart';
import 'package:zhks/features/auth/presentation/providers/auth_provider.dart';
import 'package:zhks/features/auth/presentation/widgets/personal_info_form.dart';

class AddResidentScreen extends ConsumerStatefulWidget {
  const AddResidentScreen({super.key});

  @override
  ConsumerState<AddResidentScreen> createState() => _AddRoommateScreenState();
}

class _AddRoommateScreenState extends ConsumerState<AddResidentScreen> {
  // контроллеры
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedGender = 'male';

  bool get _isEmailValid =>
      _emailController.text.trim().isNotEmpty &&
      RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(_emailController.text);

  bool get _isFormValid =>
      _selectedGender.isNotEmpty &&
      _isEmailValid &&
      _firstNameController.text.trim().isNotEmpty &&
      _lastNameController.text.trim().isNotEmpty &&
      _phoneController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() => setState(() {}));
    _firstNameController.addListener(() => setState(() {}));
    _lastNameController.addListener(() => setState(() {}));
    _phoneController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onGenderChanged(String gender) {
    setState(() => _selectedGender = gender);
  }

  void _addRoommate() {
    final resident = Resident(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      gender: _selectedGender,
      email: _emailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      zhkId: 1, // or take from context if needed
      queue: '1',
      entranceNumber: '2',
      floor: '3',
      apartmentNumber: '45',
    );

    ref.read(authStateProvider.notifier).addResident(resident);
    context.goNamed('residents');
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

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
        label: 'Новый сожитель',
        showBackButton: true,
        location: '/thanks',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: PersonalInfoForm(
                gender: _selectedGender,
                firstName: _firstNameController.text,
                lastName: _lastNameController.text,
                phoneNumber: _phoneController.text,
                emailController: _emailController,
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                phoneController: _phoneController,
                isFormValid: _isFormValid,
                onGenderChanged: _onGenderChanged,
                onSubmit: _addRoommate,
                onBack: () => context.pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
