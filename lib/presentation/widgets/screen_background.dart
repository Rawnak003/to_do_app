import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_application/core/utils/assets_path.dart';


class ScreenBackground extends StatelessWidget {
  const ScreenBackground({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.splashBackgroundSvg,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.fill,),
        child,
      ],
    );
  }
}