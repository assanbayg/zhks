// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/features/auth/presentation/widgets/page_indicator.dart';
import 'package:zhks/features/request/presentation/widgets/service_request_form_page.dart';
import 'package:zhks/features/request/presentation/widgets/service_selection_page.dart';

class RequestScreen extends ConsumerStatefulWidget {
  const RequestScreen({super.key});

  @override
  ConsumerState<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends ConsumerState<RequestScreen> {
  int _currentPage = 0;
  String _chosenService = '';

  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_pageListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_pageListener);
    _controller.dispose();
    super.dispose();
  }

  void _pageListener() {
    if (_controller.page?.round() != _currentPage) {
      setState(() {
        _currentPage = _controller.page!.round();
      });
    }
  }

  void navigateToNextPage(String selectedServiceName) {
    setState(() {
      _chosenService = selectedServiceName;
    });

    _controller.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void navigateToPreviousPage() {
    _controller.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        label: _currentPage == 0 ? 'Подать заявку' : _chosenService,
        showBackButton: true,
        location: '/',
      ),
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
                  ServiceSelectionPage(
                    onServiceSelected:
                        // callback to change the app bar label
                        (serviceName) => navigateToNextPage(serviceName),
                  ),

                  ServiceRequestFormPage(onBackPressed: navigateToPreviousPage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
