import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/shopController.dart';
import '../controller/customerController.dart';

class ShopDetails extends StatefulWidget {
  const ShopDetails({Key? key});

  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  final cusController = Get.find<CustomerController>();
  final shopController = Get.find<ShopController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFoods();
  }

  void loadFoods() async {
    String? cusID = cusController.customerM.value.id;
    String? id = shopController.shopM.value.id;
    await shopController.getAllFoods(cusID: cusID, id: id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              shopController.foodLis.clear();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_outlined),
            color: Colors.black,
          ),
          title: Obx(() => Text(
                "${shopController.shopM.value.shopName}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              )),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: shopController.foodLis.length,
                        itemBuilder: (context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                child: Image.network(
                                  "${shopController.foodLis[index].imgURL}",
                                ),
                              ),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Obx(
                                    () => Text(
                                      "${shopController.foodLis[index].foodName}",
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      "${shopController.foodLis[index].price}",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
