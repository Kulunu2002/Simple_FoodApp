import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/shopController.dart';
import '../widgets/customButton.dart';
import '../widgets/myTextField.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final foodNameController = TextEditingController();
  final priceController = TextEditingController();
  var shopController = Get.find<ShopController>();

  @override
  void initState() {
    super.initState();
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;

    try {
      final storageRef = storage
          .ref("/food_upload") //Folder Structure
          .child(AutofillHints.photo); //File name
      final taskSnapshot = await storageRef.putFile(
        _photo!,
      );
      String url = await taskSnapshot.ref.getDownloadURL();
      String? id = shopController.shopM.value.id;

      var result = await ShopController().foodAdd(
          id: id,
          imgURL: url,
          foodName: foodNameController.text,
          price: priceController.text);

      setState(() {
        isLoading = false;
      });

      if (result) {
        Get.snackbar("Food Added", "");
      }
    } catch (e) {
      print('error occured');
    }
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
          title: const Text(
            "Add Food",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
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
                    const SizedBox(height: 65),

                    //Food name Input
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextField(
                          controller: foodNameController,
                          hintText: "Food Name",
                          obscureText: false,
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTextField(
                          controller: priceController,
                          hintText: "Price (RS)",
                          obscureText: false,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                GestureDetector(
                  onTap: () {
                    imgFromGallery();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 300,
                    color: Colors.grey[300],
                    child: _photo != null
                        ? Image.file(_photo!, fit: BoxFit.cover)
                        : const Text("Please select an image"),
                  ),
                ),

                const SizedBox(height: 100),

                //Button
                CustomButton(
                  onPressed: () {
                    uploadFile();
                  },
                  buttonText: const Text(
                    "Add",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
