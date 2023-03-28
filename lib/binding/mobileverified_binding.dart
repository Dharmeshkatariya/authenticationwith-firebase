import 'package:get/get.dart';
import 'package:untitled5/controller/mobileverification_controller.dart';

class MobileVerifiedBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<MobileScreenController>(() => MobileScreenController());
    // TODO: implement dependencies
  }

}