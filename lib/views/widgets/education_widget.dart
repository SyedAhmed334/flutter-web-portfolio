// lib/views/widgets/education_widget.dart
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'responsive_widget.dart';

class EducationWidget extends StatelessWidget {
  const EducationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: _buildMobileEducation(context),
      tablet: _buildTabletEducation(context),
      desktop: _buildDesktopEducation(context),
    );
  }

  Widget _buildMobileEducation(BuildContext context) {
    return _buildEducationSection(context, isMobile: true);
  }

  Widget _buildTabletEducation(BuildContext context) {
    return _buildEducationSection(context, isMobile: false);
  }

  Widget _buildDesktopEducation(BuildContext context) {
    return _buildEducationSection(context, isMobile: false);
  }

  Widget _buildEducationSection(BuildContext context, {required bool isMobile}) {
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
                    "Education",
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
                    "My academic background",
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
            child: Center(
              child: Container(
                width: isMobile ? double.infinity : 800,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(20),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.school,
                              color: AppColors.primaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Mehran University Of Engineering And Technology Jamshoro (MUET)",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text(
                                    "B.E. in Software Engineering",
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () => _launchURL("https://sw.muet.edu.pk/syllabus.php"),
                                    child: const Text(
                                      "Link to all courses",
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "November 2023",
                                style: TextStyle(
                                  color: AppColors.textColorSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Divider(color: AppColors.primaryColor.withOpacity(0.3)),
                    const SizedBox(height: 20),
                    const Text(
                      "Relevant Courses:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildCourseChip("Mobile Application Development (Flutter)"),
                        _buildCourseChip("OOP"),
                        _buildCourseChip("Database Systems"),
                        _buildCourseChip("Data Structures And Algorithms"),
                        _buildCourseChip("Software Project Management"),
                        _buildCourseChip("Programming Fundamentals"),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      children: [
                        Icon(
                          Icons.stars,
                          color: AppColors.primaryColor,
                          size: 22,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Achievements:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildAchievementItem(
                      "Consistently maintained a strong GPA throughout the academic program",
                    ),
                    _buildAchievementItem(
                      "Participated in university-wide software development competitions",
                    ),
                    _buildAchievementItem(
                      "Led a team project that received recognition from faculty",
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      children: [
                        Icon(
                          Icons.workspace_premium,
                          color: AppColors.primaryColor,
                          size: 22,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Certifications:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    _buildCertificationItem(
                      "Flutter Development Bootcamp",
                      "Udemy",
                      "2022",
                    ),
                    _buildCertificationItem(
                      "Mobile App Development Masterclass",
                      "Coursera",
                      "2023",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseChip(String courseName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        courseName,
        style: const TextStyle(
          color: AppColors.textColor,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildAchievementItem(String achievement) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.primaryColor,
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              achievement,
              style: const TextStyle(
                color: AppColors.textColorSecondary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationItem(String name, String issuer, String year) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.card_membership,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Issued by: $issuer",
                      style: const TextStyle(
                        color: AppColors.textColorSecondary,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      year,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}