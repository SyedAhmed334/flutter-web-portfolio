// lib/views/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/scroll_controller.dart' as app_controller;
import '../utils/app_colors.dart';
import 'widgets/animated_widget.dart';
import 'widgets/animated_widget.dart' as animated_widget;
import 'widgets/custom_appbar.dart';
import 'widgets/education_widget.dart';
import 'widgets/experience_widget.dart';
import 'widgets/footer_widget.dart';
import 'widgets/header_widget.dart';
import 'widgets/projects_widget.dart';
import 'widgets/skill_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final app_controller.CustomScrollController scrollController =
      Get.put(app_controller.CustomScrollController());
  bool isScrolled = false;
  final headerKey = GlobalKey();
  final skillsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final projectsKey = GlobalKey();
  final educationKey = GlobalKey();
  final footerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    scrollController.scrollController.addListener(_updateScrollStatus);
  }

  void _updateScrollStatus() {
    setState(() {
      isScrolled = scrollController.scrollController.offset > 100;
    });

    _detectVisibleSection();
  }

  void _detectVisibleSection() {
    final sectionOffsets = {
      0: headerKey,
      1: skillsKey,
      2: experienceKey,
      3: projectsKey,
      4: educationKey,
      5: footerKey,
    };

    double minOffset = double.infinity;
    int visibleIndex = 0;

    sectionOffsets.forEach((index, key) {
      final context = key.currentContext;
      if (context != null) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy;

        if (position.abs() < minOffset) {
          minOffset = position.abs();
          visibleIndex = index;
        }
      }
    });

    if (scrollController.currentSection.value != visibleIndex) {
      scrollController.currentSection.value = visibleIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(isScrolled: isScrolled),
      body: SingleChildScrollView(
        controller: scrollController.scrollController,
        child: Column(
          children: [
            AnimatedSectionWidget(
              key: headerKey,
              sectionKey: 'header',
              animationStyle: animated_widget.AnimationStyle.fadeIn,
              child: const HeaderWidget(),
            ),
            AnimatedSectionWidget(
              key: skillsKey,
              sectionKey: 'skills',
              animationStyle: animated_widget.AnimationStyle.slideLeft,
              child: const SkillsWidget(),
            ),
            AnimatedSectionWidget(
              key: experienceKey,
              sectionKey: 'experience',
              animationStyle: animated_widget.AnimationStyle.slideUp,
              child: ExperienceWidget(),
            ),
            AnimatedSectionWidget(
              key: projectsKey,
              sectionKey: 'projects',
              animationStyle: animated_widget.AnimationStyle.scaleUp,
              child: ProjectsWidget(),
            ),
            AnimatedSectionWidget(
              key: educationKey,
              sectionKey: 'education',
              animationStyle: animated_widget.AnimationStyle.slideRight,
              child: const EducationWidget(),
            ),
            AnimatedSectionWidget(
              key: footerKey,
              sectionKey: 'footer',
              animationStyle: animated_widget.AnimationStyle.fadeIn,
              child: const FooterWidget(),
            ),
          ],
        ),
      ),
      floatingActionButton:
          Obx(() => scrollController.scrollPosition.value > 300
              ? FloatingActionButton(
                  backgroundColor: AppColors.primaryColor,
                  child: const Icon(Icons.arrow_upward),
                  onPressed: () => scrollController.scrollToSection(0),
                )
              : const SizedBox.shrink()),
    );
  }

  @override
  void dispose() {
    scrollController.scrollController.removeListener(_updateScrollStatus);
    scrollController.scrollController.dispose();
    super.dispose();
  }
}
