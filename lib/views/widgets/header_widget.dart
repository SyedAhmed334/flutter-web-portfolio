// lib/views/widgets/header_widget.dart

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'dart:ui'; // For Sigma (Blur)
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import 'responsive_widget.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  Future<bool> downloadPDFWithName(String fileName) async {
    const String filePath = 'assets/files/Syed_Ahmed_Shah_Flutter.pdf';

    try {
      final ByteData data = await rootBundle.load(filePath);
      final Uint8List bytes = data.buffer.asUint8List();

      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      html.AnchorElement(href: url)
        ..setAttribute(
            'download', fileName.endsWith('.pdf') ? fileName : '$fileName.pdf')
        ..click();

      html.Url.revokeObjectUrl(url);
      return true;
    } catch (e) {
      print('Download error: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: _buildHeaderContent(context, isMobile: true),
      tablet: _buildHeaderContent(context, isMobile: false, isTablet: true),
      desktop: _buildHeaderContent(context, isMobile: false),
    );
  }

  Widget _buildHeaderContent(BuildContext context,
      {required bool isMobile, bool isTablet = false}) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        image: DecorationImage(
          image: AssetImage("assets/images/bg_pattern.png"), // Optional pattern
          fit: BoxFit.cover,
          opacity: 0.05,
        ),
      ),
      child: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor.withOpacity(0.15),
              ),
            )
                .animate(
                    onPlay: (controller) => controller.repeat(reverse: true))
                .scale(
                    duration: 4.seconds,
                    begin: const Offset(1, 1),
                    end: const Offset(1.2, 1.2)),
          ),

          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentColor.withOpacity(0.1),
              ),
            )
                .animate(
                    onPlay: (controller) => controller.repeat(reverse: true))
                .scale(
                    duration: 5.seconds,
                    begin: const Offset(1, 1),
                    end: const Offset(1.3, 1.3)),
          ),

          // Glass Content
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: isMobile ? screenWidth * 0.9 : screenWidth * 0.85,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 60,
                    vertical: isMobile ? 40 : 60,
                  ),
                  constraints: BoxConstraints(
                    maxHeight: screenHeight * 0.85,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: isMobile
                      ? SingleChildScrollView(
                          child: Column(
                            // Mobile Layout
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildAvatar(),
                              const SizedBox(height: 30),
                              _buildTextContent(context, isMobile: true),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Row(
                            // Desktop/Tablet Layout
                            children: [
                              Expanded(
                                flex: 6,
                                child:
                                    _buildTextContent(context, isMobile: false),
                              ),
                              const SizedBox(width: 40),
                              Expanded(
                                flex: 5,
                                child: Center(child: _buildAvatar()),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),

         
        ],
      ),
    );
  }


  Widget _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.5), width: 4),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const CircleAvatar(
        radius: 140, // Responsive size could be added here
        backgroundImage: AssetImage("assets/images/profile.jpeg"),
      ),
    )
        .animate()
        .fadeIn(duration: 800.ms)
        .scale(duration: 800.ms, curve: Curves.easeOutBack);
  }

  Widget _buildTextContent(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Hello, I'm",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
        ).animate().fadeIn(delay: 200.ms).moveX(begin: -30, end: 0),
        const SizedBox(height: 10),
        Text(
          AppConstants.name,
          style: isMobile
              ? Theme.of(context).textTheme.displayMedium
              : Theme.of(context).textTheme.displayLarge,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ).animate().fadeIn(delay: 400.ms).moveX(begin: -30, end: 0),
        const SizedBox(height: 10),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            Text(
              "I'm a ",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    // mapped to headlineSmall
                    color: Colors.white70,
                    fontSize: isMobile ? 20 : 28,
                  ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Flutter Developer',
                  textStyle: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: isMobile ? 20 : 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
                TypewriterAnimatedText(
                  'Mobile Engineer',
                  textStyle: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: isMobile ? 20 : 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
          ],
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: isMobile ? double.infinity : 500,
          child: Text(
            AppConstants.aboutMe,
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ).animate().fadeIn(delay: 600.ms),
        const SizedBox(height: 35),
        Wrap(
          // Use Wrap to handle button layout nicely on smaller screens
          spacing: 20,
          runSpacing: 20,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                downloadPDFWithName("Syed's resume");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 10,
                shadowColor: AppColors.primaryColor.withOpacity(0.4),
              ),
              child: const Text(
                "Download CV",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildSocialLinks(context),
          ],
        ).animate().fadeIn(delay: 800.ms).moveY(begin: 30, end: 0),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // shrink to fit
      children: [
        _socialIcon(Icons.email, AppConstants.email),
        _socialIcon(Icons.phone, AppConstants.phone),
        _socialIcon(Icons.code, AppConstants.github),
        _socialIcon(Icons.link, AppConstants.linkedin),
      ],
    );
  }

  Widget _socialIcon(IconData icon, String tooltip) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: IconButton(
        onPressed: () {}, // TODO: Add link launching
        icon: Icon(icon, color: Colors.white, size: 22),
        tooltip: tooltip,
        padding: EdgeInsets.zero,
      ),
    );
  }


}
