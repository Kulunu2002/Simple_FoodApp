import 'package:assigment_3/controller/customerController.dart';
import 'package:assigment_3/controller/firebaseAppCtrl/authController.dart';
import 'package:assigment_3/controller/shopController.dart';
import 'package:assigment_3/screens/customerDashboard.dart';
import 'package:assigment_3/screens/customerRegister.dart';
import 'package:assigment_3/screens/shopDashboard.dart';
import 'package:assigment_3/screens/shopRegister.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/customButton.dart';
import '../widgets/myTextField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CustomerController cusController = Get.find<CustomerController>();
  ShopController shopController = Get.find<ShopController>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void clickLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Invalid Input!', "Invalid Email Or Password");
      setState(() {
        isLoading = false;
      });
    }
    AuthController authController = AuthController();

    var output = await authController.signInUser(
        emailController.text, passwordController.text);

    if (!output["isError"]) {
      String id = output["msg"] as String;

      var isCus = await cusController.getUserByID(id);
      var isShop = await shopController.getUserByID(id);

      if (isCus) {
        Get.offAll(() => const CustomerDashBoard());
      } else if (isShop) {
        Get.offAll(() => const ShopDashboard());
      } else {
        Get.snackbar("Error! User document not found", output["msg"]);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Text("Login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w500)),
                        )
                      ],
                    ),
                    const SizedBox(height: 65),

                    //Email Input
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                        MyTextField(
                          controller: emailController,
                          hintText: "email@gmail.com",
                          obscureText: false,
                        )
                      ],
                    ),

                    const SizedBox(height: 15),

                    //Password Input
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
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
                    )
                  ]),

              const SizedBox(height: 80),

              //Button
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        clickLogin();
                      },
                      buttonText: const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),

              const SizedBox(height: 200),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Get.to(() => const CustomerRegister());
                      },
                      child: Text(
                        "Register as a customer",
                        style: TextStyle(
                            color: Colors.purple[800],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const ShopRegister());
                      },
                      child: Text(
                        "Register as a shop",
                        style: TextStyle(
                            color: Colors.purple[800],
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
