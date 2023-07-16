import 'package:assigment_3/screens/loginScreen.dart';
import 'package:assigment_3/screens/shopDashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/firebaseAppCtrl/authController.dart';
import '../controller/shopController.dart';
import '../widgets/customButton.dart';
import '../widgets/myTextField.dart';

class ShopRegister extends StatefulWidget {
  const ShopRegister({super.key});

  @override
  State<ShopRegister> createState() => _ShopRegisterState();
}

class _ShopRegisterState extends State<ShopRegister> {
  final shopNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final countryController = TextEditingController();

  void signUpUser() async {
    AuthController authController = AuthController();

    var output = await authController.signUpUser(
        emailController.text, passwordController.text);

    if (output!["isError"]) {
      String shopID = output["msg"] as String;
      var result = await ShopController().registerShop(
          id: shopID,
          email: emailController.text,
          country: countryController.text,
          shopName: shopNameController.text);
      if (result) {
        Get.off(() => const LoginScreen());
      }
    } else {
      Get.snackbar("Something went wrong", output["msg"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      "Shop Register",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
          
                  const SizedBox(height: 65),
          
                  //User Name Input
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            "Shop Name",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )),
                      MyTextField(
                        controller: shopNameController,
                        hintText: "Shop Name",
                        obscureText: false,
                      )
                    ],
                  ),
          
                  const SizedBox(height: 15),
          
                  //Email Input
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            "Email",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )),
                      MyTextField(
                        controller: emailController,
                        hintText: "example@gmail.com",
                        obscureText: false,
                      )
                    ],
                  ),
          
                  const SizedBox(height: 15),
          
                  //User Name Input
          
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            "Password",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )),
                      MyTextField(
                        controller: passwordController,
                        hintText: "",
                        obscureText: true,
                      )
                    ],
                  ),
          
                  const SizedBox(height: 15),
          
                  //Country Name Input
          
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            "Country",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )),
                      MyTextField(
                        controller: countryController,
                        hintText: "",
                        obscureText: false,
                      )
                    ],
                  ),
          
                  const SizedBox(height: 30),
          
                  //Button
                  CustomButton(
                    onPressed: () {
                      signUpUser();
                    },
                    buttonText: const Text(
                      "Create an account",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
          
                  const SizedBox(height: 100),
          
                  TextButton(
                      onPressed: () {
                        Get.to(() => const LoginScreen());
                      },
                      child: Text(
                        "I already have an account",
                        style: TextStyle(
                            color: Colors.purple[800],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
          
                  // Container(
                  //   height: 100,
                  //   child: Obx(() => ListView.builder(
                  //       itemCount: UserController.userList.value.length,
                  //       itemBuilder: (context, index) {
                  //         UserModel userModel =
                  //             UserController.userList.value[index];
                  //         return Column(
                  //           children: [
                  //             Text(userModel.email!),
                  //             Text(userModel.password!),
                  //             Text(userModel.name!)
                  //           ],
                  //         );
                  //       })),
                  // )
                ],
              )
            ],
                  ),
                ),
          )),
    );
  }
}
