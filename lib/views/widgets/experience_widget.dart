// lib/views/widgets/experience_widget.dart
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../models/experience_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:timelines/timelines.dart';

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

  Widget _buildTabletExperience(BuildContext context) {
    return _buildExperienceSection(context, isMobile: false);
  }

  Widget _buildDesktopExperience(BuildContext context) {
    return _buildExperienceSection(context, isMobile: false);
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
      child: Timeline.tileBuilder(
        theme: TimelineThemeData(
          direction: Axis.vertical,
          connectorTheme: const ConnectorThemeData(
            thickness: 2.0,
            color: AppColors.primaryColor,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemCount: experiences.length,
          contentsBuilder: (_, index) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, bottom: 40.0, top: 10.0),
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
                  Row(
                    children: [
                      Text(
                        experiences[index].role,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
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
                  ...experiences[index].responsibilities.map((responsibility) {
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
            );
          },
          indicatorBuilder: (_, index) {
            return const DotIndicator(
              size: 16,
              color: AppColors.primaryColor,
              child: Icon(
                Icons.work,
                color: Colors.white,
                size: 12,
              ),
            );
          },
          connectorBuilder: (_, index, connectorType) {
            return const SolidLineConnector(
              thickness: 2,
              color: AppColors.primaryColor,
            );
          },
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      Container(
                        width: 2,
                        height: index == experiences.length - 1 ? 120 : 300,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            experiences[index].role,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 15),
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
    );
  }
}
