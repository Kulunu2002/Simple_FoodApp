import 'package:assigment_3/models/food.dart';
import 'package:assigment_3/services/shopService.dart';
import 'package:get/get.dart';
import '../models/shop.dart';
import 'customerController.dart';

class ShopController extends GetxController {
  var shopM = ShopModel().obs;
  var shopLis = <ShopModel>[].obs;
  var foodLis = <Food>[].obs;
  var cusController = Get.find<CustomerController>();

  //register shop
  Future<bool> registerShop({
    String? id,
    String? shopName,
    String? email,
    String? country,
  }) async {
    ShopModel shopModel = ShopModel(
      email: email ?? "",
      shopName: shopName ?? "",
      country: country ?? "",
      id: id ?? "",
    );
    String? output = await ShopService().registerShop(shopModel);
    if (output == null) {
      return false;
    }
    shopM.value = shopModel;
    return true;
  }

//Get a user shop info
  Future<bool> getUserByID(String id) async {
    ShopModel? shopModel = await ShopService().getUserByID(id);
    if (shopModel == null || shopModel.shopName == null) {
      return false;
    }
    shopM.value = shopModel;
    return true;
  }

  //Get All shop details
  Future<bool> getAllShop() async {
    List<ShopModel>? shopModel = await ShopService().getAllShop();
    if (shopModel == null || shopModel.isEmpty) {
      return false;
    }
    shopLis.assignAll(shopModel);
    print(shopLis[1].shopName);
    return true;
  }

  //write data controller
  Future<bool> foodAdd({
    String? id,
    String? foodName,
    String? price,
    String? imgURL,
  }) async {
    Food food = Food(
        id: id ?? "",
        foodName: foodName ?? "",
        price: price ?? "",
        imgURL: imgURL ?? "");

    String? output = await ShopService().foodAdd(food);
    if (output == null) {
      return false;
    }
    foodLis.add(food);
    return true;
  }

  Future<bool> getAllFoods({String? cusID , String? id}) async {
  List<Food>? result = await ShopService().getAllFoods();
  if (result == null) {
    return false;
  }
  for (Food food in result) {
    if (id == food.id && cusID == cusController.customerM.value.id) {
      foodLis.add(food);
    }
  }
  return true;
}

}
