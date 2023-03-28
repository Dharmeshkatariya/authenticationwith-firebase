import 'package:get/get.dart';
import 'package:untitled5/controller/signuopscreen_controller.dart';

class SignUpScreenBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SignUpScreenController());
  }

}