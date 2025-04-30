import 'package:get/get.dart';

class FabVisibilityController extends GetxController {
  final RxBool showFAB = true.obs;

  void hideFAB() {
    if (showFAB.value) {
      showFAB.value = false;
    }
  }

  void showFABIfHidden() {
    if (!showFAB.value) {
      showFAB.value = true;
    }
  }
}
