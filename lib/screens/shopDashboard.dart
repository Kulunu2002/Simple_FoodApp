import 'package:assigment_3/controller/shopController.dart';
import 'package:assigment_3/screens/addFoodScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopDashboard extends StatefulWidget {
  const ShopDashboard({Key? key});

  @override
  State<ShopDashboard> createState() => _ShopDashboardState();
}

class _ShopDashboardState extends State<ShopDashboard> {
  // var shopController = Get.find<ShopController>();
  ShopController shopController = Get.find<ShopController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadFoods();
  }

  void loadFoods() async {
    String? id = shopController.shopM.value.id;
    await shopController.getAllFoods(id: id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Obx(
          () => AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            title: Text(
              "Good Morning ${shopController.shopM.value.shopName}",
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.star),
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: shopController.foodLis.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: Container(
                                width: 60,
                                height: 100,
                                child: Image.network(
                                    "${shopController.foodLis[index].imgURL}",
                                    fit: BoxFit.fill),
                              ),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      " ${shopController.foodLis[index].foodName}"),
                                  Text(
                                      "${shopController.foodLis[index].price}"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: IconButton(
                      onPressed: () {
                        Get.to(() => const AddFoodScreen());
                      },
                      icon: const Icon(Icons.add_circle,
                          size: 50, color: Colors.amber),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
