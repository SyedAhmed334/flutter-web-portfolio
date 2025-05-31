// lib/controllers/scroll_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomScrollController extends GetxController {
  final ScrollController scrollController = ScrollController();
  RxDouble scrollPosition = 0.0.obs;
  RxInt currentSection = 0.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_updateScrollPosition);
  }

  void _updateScrollPosition() {
    scrollPosition.value = scrollController.offset;

    // Update current section based on scroll position
    // This will be implemented based on the actual layout
  }

  void scrollToSection(int index) {
    double position = 0;
    switch (index) {
      case 0: // Home
        position = 0;
        break;
      case 1: // Skills
        position = 500;
        break;
      case 2: // Experience
        position = 900;
        break;
      case 3: // Projects
        position = 1400;
        break;
      case 4: // Education
        position = 2000;
        break;
      case 5: // Contact
        position = 2400;
        break;
    }
    scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
    currentSection.value = index;
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
