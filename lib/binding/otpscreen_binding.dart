import 'package:get/get.dart';
import 'package:untitled5/controller/otpscreen_controller.dart';

class OtpScreenBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<OtpScreenController>(() => OtpScreenController());
    // TODO: implement dependencies
  }


}