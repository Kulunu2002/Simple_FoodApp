import 'package:assigment_3/models/shop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../controller/shopController.dart';
import '../models/food.dart';

class ShopService {
  CollectionReference shop = FirebaseFirestore.instance.collection("Shop");
  CollectionReference foods = FirebaseFirestore.instance.collection("Foods");
  var shopController = Get.find<ShopController>();
  var foodLis = <Food>[].obs;
  var shopLis = <ShopModel>[].obs;

//Register shop as a document
  Future<String?> registerShop(ShopModel shopModel) async {
    try {
      await shop.doc(shopModel.id).set(shopModel.toJson());
      return "Added";
    } catch (e) {
      print("!!!-------RegisterCustomer error :" + e.toString());
      return null;
    }
  }

  Future<ShopModel?> getUserByID(String id) async {
    try {
      DocumentSnapshot? snapshot = await shop.doc(id).get();
      if (snapshot.data() == null) {
        return null;
      }
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      ShopModel shopModel = ShopModel.fromJson(data);
      return shopModel;
    } catch (e) {
      print("!!!------- error: $e");
      return null;
    }
  }

//get all shop 
  Future<List<ShopModel>> getAllShop() async {
  try {
    QuerySnapshot snapshot = await shop.get();


    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      ShopModel shopModel = ShopModel.fromJson(data);
      shopLis.add(shopModel);
    }

    return shopLis;
  } catch (e) {
    print("!!!------- error: $e");
    return [];
  }
}

// add foods

  Future<String?> foodAdd(Food food) async {
    try {
      await foods.doc().set(food.toJson());
      return "Added";
    } catch (e) {
      print("!!!-------ShopModel Add error: $e");
      return null;
    }
  }

  Future<List<Food>> getAllFoods() async {
    try {
      QuerySnapshot? snapshot =
          await FirebaseFirestore.instance.collection("Foods").get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Food food = Food.fromJson(data);
        foodLis.add(food);
      }
      return foodLis;
    } catch (e) {
      print("!!!------- error: $e");
      return [];
    }
  }
}
