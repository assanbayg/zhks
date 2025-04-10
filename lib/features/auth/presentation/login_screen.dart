// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/widgets/custom_app_bar.dart';
import 'package:zhks/features/auth/presentation/widgets/email_form.dart';
import 'package:zhks/features/auth/presentation/widgets/page_indicator.dart';
import 'package:zhks/features/auth/presentation/widgets/verification_form.dart';

// Handles timer logic and validations
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _currentPage = 0;
  int _remainingSeconds = 59;
  Timer? _timer;

  final PageController _controller = PageController();
  final TextEditingController _emailController = TextEditingController();
  final List<TextEditingController> _codeControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  bool get _isEmailValid =>
      _emailController.text.trim().isNotEmpty &&
      RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      ).hasMatch(_emailController.text);

  bool get _isCodeComplete =>
      _codeControllers.every((controller) => controller.text.isNotEmpty);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_pageListener);

    for (var controller in _codeControllers) {
      controller.addListener(() {
        setState(() {});
      });
    }

    _emailController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_pageListener);
    _controller.dispose();
    _timer?.cancel();
    _emailController.dispose();
    for (TextEditingController controller in _codeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _pageListener() {
    if (_controller.page?.round() != _currentPage) {
      setState(() {
        _currentPage = _controller.page!.round();
      });

      if (_currentPage == 1) {
        _startResendTimer();
      }
    }
  }

  void _startResendTimer() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = 59;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _validateAndSubmitCode() {
    final code = _codeControllers.map((c) => c.text).join();

    if (code.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, введите 4-значный код')),
      );
      return;
    }

    // TODO: add verification logic with backend
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(label: 'Вход'),
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
                  EmailForm(
                    emailController: _emailController,
                    isEmailValid: _isEmailValid,
                    onContinue: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                  VerificationForm(
                    email:
                        _emailController.text.isEmpty
                            ? ""
                            : _emailController.text,
                    codeControllers: _codeControllers,
                    isCodeComplete: _isCodeComplete,
                    remainingSeconds: _remainingSeconds,
                    onSubmit: _validateAndSubmitCode,
                    onResend: _remainingSeconds <= 0 ? _startResendTimer : null,
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
