// lib/views/widgets/skills_widget.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utils/app_colors.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'responsive_widget.dart';

class SkillsWidget extends StatefulWidget {
  const SkillsWidget({super.key});

  @override
  State<SkillsWidget> createState() => _SkillsWidgetState();
}

class _SkillsWidgetState extends State<SkillsWidget> {
  bool _isHeaderVisible = false;
  List<bool> _isSkillVisible = [];

  // List of skill data
  final List<Map<String, String>> _skills = [
    {"name": "Flutter", "icon": "flutter_dash"},
    {"name": "Dart", "icon": "code"},
    {"name": "Firebase", "icon": "local_fire_department"},
    {"name": "MySQL", "icon": "storage"},
    {"name": "MVC", "icon": "architecture"},
    {"name": "Localization", "icon": "language"},
    {"name": "REST API", "icon": "api"},
    {"name": "JSON", "icon": "data_array"},
    {"name": "Google Maps", "icon": "map"},
    {"name": "Push Notifications", "icon": "notifications"},
    {"name": "Responsive Design", "icon": "devices"},
    {"name": "Testing", "icon": "bug_report"},
    {"name": "Git & GitHub", "icon": "commit"},
    {"name": "Web Sockets", "icon": "sync"},
    {"name": "State Management", "icon": "shuffle"},
    {"name": "Agile", "icon": "swap_calls"},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize visibility state for each skill
    _isSkillVisible = List.generate(_skills.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: _buildMobileSkills(context),
      tablet: _buildTabletSkills(context),
      desktop: _buildDesktopSkills(context),
    );
  }

  Widget _buildMobileSkills(BuildContext context) {
    return _buildSkillsSection(context, isMobile: true);
  }

  Widget _buildTabletSkills(BuildContext context) {
    return _buildSkillsSection(context, isMobile: false);
  }

  Widget _buildDesktopSkills(BuildContext context) {
    return _buildSkillsSection(context, isMobile: false);
  }

  Widget _buildSkillsSection(BuildContext context, {required bool isMobile}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 80,
      ),
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with animations using VisibilityDetector
          VisibilityDetector(
            key: const Key('skills-header'),
            onVisibilityChanged: (visibilityInfo) {
              if (visibilityInfo.visibleFraction > 0.1 && !_isHeaderVisible) {
                setState(() {
                  _isHeaderVisible = true;
                });
              }
            },
            child: Center(
              child: Column(
                children: [
                  // Title with slide and fade animation
                  AnimatedSlide(
                    offset:
                        _isHeaderVisible ? Offset.zero : const Offset(0, 0.5),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutQuart,
                    child: AnimatedOpacity(
                      opacity: _isHeaderVisible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      child: const Text(
                        "My Skills",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Divider with scale animation
                  AnimatedScale(
                    scale: _isHeaderVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutBack,
                    child: Container(
                      width: 50,
                      height: 3,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Subtitle with fade animation
                  AnimatedOpacity(
                    opacity: _isHeaderVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOut,
                    child: const Text(
                      "Technologies I've been working with",
                      style: TextStyle(
                        color: AppColors.textColorSecondary,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),

          // Skills grid with staggered animation
          _buildSkillsGrid(context, isMobile),
        ],
      ),
    );
  }

  Widget _buildSkillsGrid(BuildContext context, bool isMobile) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      alignment: WrapAlignment.center,
      children: List.generate(
        _skills.length,
        (index) {
          final skill = _skills[index];
          return VisibilityDetector(
            key: Key('skill-$index'),
            onVisibilityChanged: (visibilityInfo) {
              if (visibilityInfo.visibleFraction > 0.1 &&
                  !_isSkillVisible[index]) {
                // Add slight delay based on index for staggered effect
                Future.delayed(Duration(milliseconds: 100 * index), () {
                  if (mounted) {
                    setState(() {
                      _isSkillVisible[index] = true;
                    });
                  }
                });
              }
            },
            child: AnimatedOpacity(
              opacity: _isSkillVisible[index] ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              child: AnimatedScale(
                scale: _isSkillVisible[index] ? 1.0 : 0.8,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutBack,
                child: _buildSkillCard(skill["name"]!, skill["icon"]!, context),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkillCard(String title, String iconName, BuildContext context) {
    final bool isMobile = ResponsiveWidget.isMobile(context);
    final bool isTablet = ResponsiveWidget.isTablet(context);

    final double cardWidth = isMobile
        ? MediaQuery.of(context).size.width / 2 - 30
        : isTablet
            ? MediaQuery.of(context).size.width / 3 - 30
            : MediaQuery.of(context).size.width / 6 - 30;

    return Container(
      width: cardWidth,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                _getIconForSkill(title),
                color: AppColors.primaryColor,
                size: 25,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getIconForSkill(String skill) {
    switch (skill) {
      case "Flutter":
        return FontAwesomeIcons.flutter;
      case "Dart":
        return FontAwesomeIcons.dartLang;
      case "Firebase":
        return Icons.local_fire_department;
      case "MySQL":
        return Icons.storage;
      case "MVC":
        return Icons.architecture;
      case "Localization":
        return Icons.language;
      case "REST API":
        return Icons.api;
      case "JSON":
        return Icons.data_array;
      case "Google Maps":
        return Icons.map;
      case "Push Notifications":
        return Icons.notifications;
      case "Responsive Design":
        return Icons.devices;
      case "Testing":
        return Icons.bug_report;
      case "Git & GitHub":
        return Icons.commit;
      case "Web Sockets":
        return Icons.sync;
      case "State Management":
        return Icons.shuffle;
      case "Agile":
        return Icons.swap_calls;
      default:
        return Icons.code;
    }
  }
}
