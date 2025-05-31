// lib/views/widgets/projects_widget.dart
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import '../../utils/app_colors.dart';
import '../../models/project_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'responsive_widget.dart';

class ProjectsWidget extends StatelessWidget {
  ProjectsWidget({super.key});

  final List<Project> projects = Project.getProjects();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: _buildMobileProjects(context),
      tablet: _buildTabletProjects(context),
      desktop: _buildDesktopProjects(context),
    );
  }

  Widget _buildMobileProjects(BuildContext context) {
    return _buildProjectsSection(context, isMobile: true);
  }

  Widget _buildTabletProjects(BuildContext context) {
    return _buildProjectsSection(context, isMobile: false, isTablet: true);
  }

  Widget _buildDesktopProjects(BuildContext context) {
    return _buildProjectsSection(context, isMobile: false, isTablet: false);
  }

  Widget _buildProjectsSection(BuildContext context,
      {required bool isMobile, bool isTablet = false}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
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
                    "Projects",
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
                    "Some of my recent works",
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
          Animate(
            effects: [
              FadeEffect(duration: 1000.ms, delay: 300.ms),
              SlideEffect(
                begin: const Offset(0, 30),
                end: const Offset(0, 0),
                duration: 800.ms,
                delay: 300.ms,
              ),
            ],
            child: Wrap(
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.center,
              children: List.generate(
                projects.length,
                (index) => _buildProjectCard(
                  context,
                  projects[index],
                  isMobile: isMobile,
                  isTablet: isTablet,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project,
      {required bool isMobile, bool isTablet = false}) {
    double cardWidth = isMobile
        ? MediaQuery.of(context).size.width - 40
        : isTablet
            ? (MediaQuery.of(context).size.width - 180) / 2
            : (MediaQuery.of(context).size.width - 230) / 3;

    return Container(
      width: cardWidth,
      constraints: const BoxConstraints(minHeight: 400),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        project.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Row(
                      children: [
                        if (project.playStoreLink != null)
                          IconButton(
                            onPressed: () => _launchURL(project.playStoreLink!),
                            icon: SvgPicture.asset("assets/images/playstore.svg", width: 30, height: 30,),
                            tooltip: "Play Store",
                          ),
                        if (project.githubLink != null)
                          IconButton(
                            onPressed: () => _launchURL(project.githubLink!),
                            icon: const Icon(Icons.code,
                                color: AppColors.primaryColor),
                            tooltip: "GitHub",
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                ...project.description.map((desc) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primaryColor,
                          size: 16,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            desc,
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
                const SizedBox(height: 20),
               Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                         project.playStoreLink != null ? _launchURL(project.playStoreLink!): _launchURL(project.githubLink!);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.primaryColor),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "View Details",
                          style: TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
