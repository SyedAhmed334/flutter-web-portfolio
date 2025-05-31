// lib/views/widgets/header_widget.dart

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';
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
      ..setAttribute('download', fileName.endsWith('.pdf') ? fileName : '$fileName.pdf')
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
      mobile: _buildMobileHeader(context),
      tablet: _buildTabletHeader(context),
      desktop: _buildDesktopHeader(context),
    );
  }

  Widget _buildMobileHeader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundColor,
            Color(0xFF0A2E1A), // Dark Green
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
          const CircleAvatar(
                  radius: 270,backgroundImage: AssetImage("assets/images/profile.jpeg", ),
                ),
            const SizedBox(height: 30),
            _buildHeaderInfo(context, isMobile: true),
            const SizedBox(height: 20),
            _buildSocialLinks(context),
            const SizedBox(height: 40),
            _buildScrollDownIndicator(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletHeader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundColor,
            Color(0xFF0A2E1A), // Dark Green
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: _buildHeaderInfo(context, isMobile: false),
                ),
                const Expanded(
                  flex: 5,
                  child: CircleAvatar(
                  radius: 270,backgroundImage: AssetImage("assets/images/profile.jpeg", ),
                ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSocialLinks(context),
            const SizedBox(height: 40),
            _buildScrollDownIndicator(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopHeader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.backgroundColor,
            Color(0xFF0A2E1A), // Dark Green
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderInfo(context, isMobile: false),
                  const SizedBox(height: 30),
                  _buildSocialLinks(context),
                ],
              ),
            ),
          
              const Expanded(
                flex: 6,
                child: CircleAvatar(
                  radius: 270,backgroundImage: AssetImage("assets/images/profile.jpeg", ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderInfo(BuildContext context, {required bool isMobile}) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: const AlwaysStoppedAnimation(1.0),
          child: Text(
            "Hello, I'm",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 10),
        FadeTransition(
          opacity: const AlwaysStoppedAnimation(1.0),
          child: Text(
            AppConstants.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: isMobile ? 30 : 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment:
              isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Text(
              "I'm a ",
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 18 : 24,
              ),
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Flutter Developer',
                  textStyle: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: isMobile ? 18 : 24,
                    fontWeight: FontWeight.bold,
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
        const SizedBox(height: 20),
        SizedBox(
          width: isMobile ? double.infinity : 450,
          child: Text(
            AppConstants.aboutMe,
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
            style: const TextStyle(
              color: AppColors.textColorSecondary,
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 25),
        ElevatedButton(
          onPressed: () {
            // assets/files/Resume.pdf
            downloadPDFWithName("Syed's resume");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "Download CV",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      mainAxisAlignment: ResponsiveWidget.isMobile(context)
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        _socialIcon(Icons.email, AppConstants.email),
        _socialIcon(Icons.phone, AppConstants.phone),
        _socialIcon(Icons.code, AppConstants.github),
        _socialIcon(Icons.link, AppConstants.linkedin),
      ],
    );
  }

  Widget _socialIcon(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget 
  _buildScrollDownIndicator(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Scroll Down",
          style: TextStyle(
            color: AppColors.textColorSecondary,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 30,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(0.5),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Container(
              width: 5,
              height: 10,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
