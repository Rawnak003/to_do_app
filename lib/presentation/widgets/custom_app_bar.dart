import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/routes/routes_name.dart';
import 'package:to_do_application/presentation/controllers/auth_controller.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key, this.fromProfile,
  });

  final bool? fromProfile;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  Future<void> _onTapProfile(BuildContext context) async {
    final isUpdated = await Navigator.pushNamed(
      context,
      RoutesName.updateProfile,
    );
    if (isUpdated == true) {
      setState(() {});
    }
  }

  Future<void> _onTapLogoutButton(BuildContext context) async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
      context,
      RoutesName.login,
      (pre) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      iconTheme: IconThemeData(color: AppColor.whiteColor),
      title: GestureDetector(
        onTap: () {
          if(widget.fromProfile ?? false) {
            return;
          }
          _onTapProfile(context);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AuthController.userModel?.fullName ?? 'Unknown Person', style: textTheme.bodyLarge?.copyWith(color: AppColor.whiteColor, fontWeight: FontWeight.w600),),
                Text(AuthController.userModel?.email ?? 'Unknown', style: textTheme.bodyMedium?.copyWith(color: AppColor.whiteColor,),),
              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            _onTapLogoutButton(context);
          },
          icon: Icon(Icons.logout_outlined, color: AppColor.whiteColor,),
        ),
      ],
    );
  }
}