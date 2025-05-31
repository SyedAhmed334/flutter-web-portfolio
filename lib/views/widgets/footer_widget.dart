// lib/views/widgets/footer_widget.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../controllers/scroll_controller.dart' as app_controller;
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'responsive_widget.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: _buildMobileFooter(context),
      tablet: _buildTabletFooter(context),
      desktop: _buildDesktopFooter(context),
    );
  }

  Widget _buildMobileFooter(BuildContext context) {
    return _buildFooterContent(context, isMobile: true);
  }

  Widget _buildTabletFooter(BuildContext context) {
    return _buildFooterContent(context, isMobile: false);
  }

  Widget _buildDesktopFooter(BuildContext context) {
    return _buildFooterContent(context, isMobile: false);
  }

  Widget _buildFooterContent(BuildContext context, {required bool isMobile}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 60,
      ),
      color: AppColors.backgroundColor,
      child: Column(
        children: [
          Animate(
            effects: [
              FadeEffect(duration: 800.ms),
              SlideEffect(
                begin: const Offset(0, 30),
                end: const Offset(0, 0),
                duration: 800.ms,
              ),
            ],
            child: Column(
              children: [
                Text(
                  "Get In Touch",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 28 : 32,
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
                SizedBox(
                  width: isMobile ? double.infinity : 600,
                  child: const Text(
                    "Have a project in mind or want to discuss a potential collaboration? Feel free to reach out to me through any of the following channels.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textColorSecondary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Animate(
            effects: [
              FadeEffect(duration: 800.ms, delay: 200.ms),
              SlideEffect(
                begin: const Offset(0, 30),
                end: const Offset(0, 0),
                duration: 800.ms,
                delay: 200.ms,
              ),
            ],
            child: Wrap(
              spacing: isMobile ? 20 : 40,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildContactItem(
                  FontAwesomeIcons.envelope,
                  "Email",
                  AppConstants.email,
                  "mailto:${AppConstants.email}",
                ),
                _buildContactItem(
                  FontAwesomeIcons.phone,
                  "Phone",
                  AppConstants.phone,
                  "tel:${AppConstants.phone}",
                ),
                _buildContactItem(
                  FontAwesomeIcons.github,
                  "GitHub",
                  "github.com/SyedAhmed334",
                  "https://github.com/SyedAhmed334/",
                ),
                _buildContactItem(
                  FontAwesomeIcons.linkedin,
                  "LinkedIn",
                  "View Profile",
                  "https://www.linkedin.com/in/syed--ahmed--shah/",
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          Animate(
            effects: [
              FadeEffect(duration: 800.ms, delay: 400.ms),
            ],
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
              child: const Column(
                children: [
                  Text(
                    AppConstants.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Flutter Developer",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "© 2025 All Rights Reserved",
                    style: TextStyle(
                      color: AppColors.textColorSecondary,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Made with ",
                        style: TextStyle(
                          color: AppColors.textColorSecondary,
                          fontSize: 14,
                        ),
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 16,
                      ),
                      Text(
                        " using ",
                        style: TextStyle(
                          color: AppColors.textColorSecondary,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Flutter",
                        style: TextStyle(
                          color: Color(0xFF54C5F8), // Flutter blue color
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Animate(
            effects: [
              FadeEffect(duration: 800.ms, delay: 600.ms),
            ],
            child: TextButton(
              onPressed: () {
                _scrollToTop(context);
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_upward,
                    color: AppColors.primaryColor,
                    size: 18,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Back to Top",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(
      IconData icon, String title, String value, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Container(
        width: 200,
        height: MediaQuery.of(Get.context!).size.width < 600 ? 150 : 180,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(10),
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
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textColorSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _scrollToTop(BuildContext context) {
    final app_controller.CustomScrollController scrollController =
        Get.put(app_controller.CustomScrollController());
    scrollController.scrollToSection(0);
  }
}
