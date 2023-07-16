import 'package:assigment_3/controller/customerController.dart';
import 'package:assigment_3/controller/shopController.dart';
import 'package:assigment_3/screens/shopDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomerDashBoard extends StatefulWidget {
  const CustomerDashBoard({super.key});

  @override
  State<CustomerDashBoard> createState() => _CustomerDashBoardState();
}

class _CustomerDashBoardState extends State<CustomerDashBoard> {
  var cusController = Get.find<CustomerController>();
  var shopController = Get.find<ShopController>();
  bool isLoading = true;

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    loadShop();
  }

  void loadShop() async {
    await shopController.getAllShop();
    setState(() {
      isLoading = false;
    });
  }

  void shopView(index) async {
    String? id = shopController.shopLis[index].id;
    var output = await shopController.getUserByID(id!);

    if (output != null) {
      Get.to(() => const ShopDetails());
    } else {
      Get.snackbar("Error!", "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          title: Obx(() => Text(
                "Good Morning ${cusController.customerM.value.name}",
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
                        itemCount: shopController.shopLis.length,
                        itemBuilder: (context, int index) {
                          return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                title: TextButton(
                                  onPressed: () {
                                    shopView(index);
                                  },
                                  child: Text(
                                      "${shopController.shopLis[index].shopName}",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 25)),
                                ),
                              ));
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
