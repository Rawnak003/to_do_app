import 'package:flutter/material.dart';
import 'package:to_do_application/core/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: AppColor.primaryColor,
      title: Row(
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
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.logout_outlined, color: AppColor.whiteColor,)),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}