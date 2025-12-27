// lib/views/widgets/experience_widget.dart
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../models/experience_model.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'responsive_widget.dart';

class ExperienceWidget extends StatelessWidget {
  ExperienceWidget({super.key});

  final List<Experience> experiences = Experience.getExperiences();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: _buildMobileExperience(context),
      tablet: _buildTabletExperience(context),
      desktop: _buildDesktopExperience(context),
    );
  }

  Widget _buildMobileExperience(BuildContext context) {
    return _buildExperienceSection(context, isMobile: true);
  }

  Widget _buildDesktopExperience(BuildContext context) {
    return _buildExperienceSection(context, isMobile: false);
  }

  Widget _buildTabletExperience(BuildContext context) {
    // Using mobile layout (single column) for tablet to ensure better spacing
    // as the desktop split view might be too cramped for tablet width.
    return _buildExperienceSection(context, isMobile: true);
  }

  Widget _buildExperienceSection(BuildContext context,
      {required bool isMobile}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surfaceColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Animate(
              effects: [
                FadeEffect(duration: 800.ms),
                SlideEffect(
                  begin: const Offset(0, 50),
                  end: const Offset(0, 0),
                  duration: 800.ms,
                ),
              ],
              child: Column(
                children: [
                  const Text(
                    "Experience",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 50,
                    height: 3,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "My work experience",
                    style: TextStyle(
                      color: AppColors.textColorSecondary,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),
          isMobile
              ? _buildMobileTimeline(context)
              : _buildDesktopTimeline(context),
        ],
      ),
    );
  }

  Widget _buildMobileTimeline(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: 1000.ms, delay: 300.ms),
        SlideEffect(
          begin: const Offset(0, 30),
          end: const Offset(0, 0),
          duration: 800.ms,
          delay: 300.ms,
        ),
      ],
      child: Column(
        children: List.generate(
          experiences.length,
          (index) => IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Timeline Line Column
                SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: const Icon(
                          Icons.work,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // Content Column
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          experiences[index].company,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 10,
                          runSpacing: 5,
                          children: [
                            Text(
                              experiences[index].role,
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                experiences[index].skills,
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          experiences[index].duration,
                          style: const TextStyle(
                            color: AppColors.textColorSecondary,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ...experiences[index]
                            .responsibilities
                            .map((responsibility) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.arrow_right,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    responsibility,
                                    style: const TextStyle(
                                      color: AppColors.textColorSecondary,
                                      fontSize: 14,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopTimeline(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(duration: 1000.ms, delay: 300.ms),
        SlideEffect(
          begin: const Offset(0, 30),
          end: const Offset(0, 0),
          duration: 800.ms,
          delay: 300.ms,
        ),
      ],
      child: Column(
        children: List.generate(
          experiences.length,
          (index) => Container(
            margin: const EdgeInsets.only(bottom: 40),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          experiences[index].company,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          experiences[index].duration,
                          style: const TextStyle(
                            color: AppColors.textColorSecondary,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Column(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                          child: const Icon(
                            Icons.work,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 2,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 15,
                          runSpacing: 5,
                          children: [
                            Text(
                              experiences[index].role,
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                experiences[index].skills,
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ...experiences[index]
                            .responsibilities
                            .map((responsibility) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.arrow_right,
                                  color: AppColors.primaryColor,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    responsibility,
                                    style: const TextStyle(
                                      color: AppColors.textColorSecondary,
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
