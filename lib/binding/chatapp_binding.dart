import 'package:get/get.dart';
import 'package:untitled5/controller/chatapp_controller.dart';

class ChatAppBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<ChatAppController>(() => ChatAppController());
    // TODO: implement dependencies
  }

}