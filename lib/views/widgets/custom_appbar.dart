// lib/views/custom_appbar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/scroll_controller.dart' as app_controller;
import '../../utils/app_colors.dart';
import '../../utils/app_constants.dart';
import 'responsive_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isScrolled;
  final app_controller.CustomScrollController scrollController =
      Get.find<app_controller.CustomScrollController>();

  CustomAppBar({super.key, required this.isScrolled});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: isScrolled ? 4 : 0,
      backgroundColor: isScrolled
          ? AppColors.backgroundColor.withOpacity(0.95)
          : Colors.transparent,
      title: Row(
        children: [
          const Text(
            AppConstants.name,
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              AppConstants.role,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
      actions: [
        if (!ResponsiveWidget.isMobile(context))
          Row(
            children: List.generate(
              AppConstants.navItems.length,
              (index) => Obx(() => NavItem(
                    title: AppConstants.navItems[index],
                    isSelected: scrollController.currentSection.value == index,
                    onTap: () => scrollController.scrollToSection(index),
                  )),
            ),
          ),
        const SizedBox(width: 20),
        if (ResponsiveWidget.isMobile(context))
          IconButton(
            icon: const Icon(Icons.menu, color: AppColors.primaryColor),
            onPressed: () {
              _showDrawer(context);
            },
          ),
      ],
    );
  }

  void _showDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundColor.withOpacity(0.95),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: List.generate(
              AppConstants.navItems.length,
              (index) => Obx(() => ListTile(
                    title: Text(
                      AppConstants.navItems[index],
                      style: TextStyle(
                        color: scrollController.currentSection.value == index
                            ? AppColors.primaryColor
                            : Colors.white,
                        fontWeight:
                            scrollController.currentSection.value == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      scrollController.scrollToSection(index);
                    },
                  )),
            ),
          ),
        );
      },
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.primaryColor : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 3),
            if (isSelected)
              Container(
                height: 2,
                width: 20,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
