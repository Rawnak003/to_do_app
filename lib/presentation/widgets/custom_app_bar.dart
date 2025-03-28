import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';
import 'package:to_do_application/core/routes/routes_name.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key, this.fromProfile,
  });

  final bool? fromProfile;

  void _onTapProfile(BuildContext context) {
    Navigator.pushNamed(
      context,
      RoutesName.updateProfile,
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      iconTheme: IconThemeData(color: AppColor.whiteColor),
      title: InkWell(
        onTap: () {
          if(fromProfile ?? false) {
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
                Text("S. M. Rawnak Muntasir", style: textTheme.bodyLarge?.copyWith(color: AppColor.whiteColor, fontWeight: FontWeight.w600),),
                Text("shmrawnak@gmail.com", style: textTheme.bodyMedium?.copyWith(color: AppColor.whiteColor,),),
              ],
            )
          ],
        ),
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.logout_outlined, color: AppColor.whiteColor,)),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}