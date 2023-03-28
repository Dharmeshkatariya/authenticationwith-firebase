import 'package:get/get.dart';
import 'package:untitled5/controller/addpost_controller.dart';

class AddPostBinding extends Bindings{

  @override
  void dependencies(){
    Get.lazyPut<AddPostController>(() => AddPostController());
    // TODO: implement dependencies
  }

}