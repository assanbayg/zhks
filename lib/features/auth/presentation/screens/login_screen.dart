// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:zhks/core/themes/theme_extensions.dart';
import 'package:zhks/features/auth/presentation/providers/auth_provider.dart';
import 'package:zhks/features/auth/presentation/widgets/email_form.dart';
import 'package:zhks/features/auth/presentation/widgets/login_verification_form.dart';
import 'package:zhks/features/auth/presentation/widgets/page_indicator.dart';

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

  // Necessary controllers for email and verification pin
  final PageController _controller = PageController();
  final TextEditingController _emailController = TextEditingController();
  final List<TextEditingController> _codeControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  // Methods for validation
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
    // Listen to changes
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

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        void requestLoginCode() async {
          if (!_isEmailValid) return;

          await _controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );

          ref
              .read(authStateProvider.notifier)
              .requestLoginCode(_emailController.text.trim());
        }

        void validateAndSubmitCode() {
          final code = _codeControllers.map((c) => c.text).join();

          if (code.length != 4) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Пожалуйста, введите 4-значный код'),
              ),
            );
            return;
          }

          // Use auth provider to verify code
          ref
              .read(authStateProvider.notifier)
              .verifyLoginCode(_emailController.text.trim(), code);
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,

            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                await _controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
            title: Text('Вход', style: context.texts.titleSmall),
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                PageIndicator(currentPage: _currentPage, pageCount: 2),
                const SizedBox(height: 24),
                Expanded(
                  child: PageView(
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged:
                        (index) => setState(() => _currentPage = index),
                    children: [
                      EmailForm(
                        emailController: _emailController,
                        isEmailValid: _isEmailValid,
                        onContinue: requestLoginCode,
                        onSecondaryAction: () {
                          context.go('/register');
                        },
                      ),
                      LoginVerificationForm(
                        email:
                            _emailController.text.isEmpty
                                ? ""
                                : _emailController.text,
                        codeControllers: _codeControllers,
                        isCodeComplete: _isCodeComplete,
                        remainingSeconds: _remainingSeconds,
                        onSubmit: validateAndSubmitCode,
                        onResend:
                            _remainingSeconds <= 0 ? _startResendTimer : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
