import 'package:get/get.dart';
import 'package:untitled5/controller/addfirstore_controller.dart';

class AddFirestoreBinding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut<AddFireStoreController>(() => AddFireStoreController());
    // TODO: implement dependencies
  }


}