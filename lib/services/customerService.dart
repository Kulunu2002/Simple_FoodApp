import 'package:assigment_3/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CustomerService {
  CollectionReference customer =
      FirebaseFirestore.instance.collection("Customer");
  var cusList = <CustomerModel>[].obs;

  Future<String?> registerCustomer(CustomerModel customerModel) async {
    try {
      if (customerModel.id != null) {
        await customer.doc(customerModel.id!).set(customerModel.toJson());
        return "Added";
      } else {
        print("Error: The customerModel.id is null.");
        return null;
      }
    } catch (e) {
      print("!!!-------RegisterCustomer error: " + e.toString());
      return null;
    }
  }

  Future<CustomerModel?> getUserByID(String id) async {
    try {
      DocumentSnapshot? snapshot = await customer.doc(id).get();
      if (snapshot.data() == null) {
        return null;
      }
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      CustomerModel customerModel = CustomerModel.fromJson(data);
      return customerModel;
    } catch (e) {
      print("!!!------- error: $e");
      return null;
    }
  }

  Future<List<CustomerModel>> getAllCustomer() async {
    try {
      QuerySnapshot snapshot = await customer.get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        CustomerModel customerModel = CustomerModel.fromJson(data);
        cusList.add(customerModel);
      }

      return cusList;
    } catch (e) {
      print("!!!------- error: $e");
      return [];
    }
  }
}
