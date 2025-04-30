import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/constants/strings.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/presentation/controllers/auth_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.fromProfile});
  final bool? fromProfile;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  Future<void> _onTapProfile() async {
    final isUpdated = await Get.toNamed(RoutesName.updateProfile);
    if (isUpdated == true) {
      Get.forceAppUpdate();
    }
  }

  void _onTapLogoutButton() {
    Get.defaultDialog(
      title: AppStrings.logout,
      content: const Text(AppStrings.logoutMessage),
      confirm: TextButton(
        onPressed: _onLogout,
        child: const Text(AppStrings.logout),
      ),
      cancel: TextButton(
        onPressed: Get.back,
        child: const Text(AppStrings.cancel),
      ),
    );
  }

  Future<void> _onLogout() async {
    await AuthController.clearUserData();
    Get.offAllNamed(RoutesName.login);
  }

  bool _shouldShowImage(String? photo) {
    return photo != null && photo.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      iconTheme: IconThemeData(color: AppColor.whiteColor),
      title: GestureDetector(
        onTap: () {
          if (fromProfile ?? false) return;
          _onTapProfile();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage: _shouldShowImage(AuthController.profilePhoto)
                  ? MemoryImage(base64Decode(AuthController.profilePhoto ?? ''))
                  : null,
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userModel?.fullName ?? 'Unknown Person',
                  style: textTheme.bodyLarge?.copyWith(
                      color: AppColor.whiteColor, fontWeight: FontWeight.w600),
                ),
                Text(
                  AuthController.userModel?.email ?? 'Unknown',
                  style: textTheme.bodyMedium?.copyWith(color: AppColor.whiteColor),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: _onTapLogoutButton,
          icon: Icon(Icons.logout_outlined, color: AppColor.whiteColor),
        ),
      ],
    );
  }
}
