
import 'package:get/get.dart';

import '../controller/customerController.dart';
import '../controller/shopController.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Bind my controllers
    Get.put(CustomerController());
    Get.put(ShopController());
  }
}
