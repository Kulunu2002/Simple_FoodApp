import 'package:assigment_3/models/customer.dart';
import 'package:assigment_3/models/shop.dart';
import 'package:get/get.dart';
import '../services/customerService.dart';

class CustomerController extends GetxController {
  var customerM = CustomerModel().obs;
  var cusList = <CustomerModel>[].obs;

  //register customer
  Future<bool> registerCustomer({
    String? id,
    String? name,
    String? email,
    String? country,
  }) async {
    CustomerModel customerModel = CustomerModel(
      id: id ?? "",
      name: name ?? "",
      email: email ?? "",
      country: country ?? "",
    );
    String? output = await CustomerService().registerCustomer(customerModel);
    if (output == null) {
      return false;
    }
    customerM.value = customerModel;
    return true;
  }

  //Get customer data
  Future<bool> getUserByID(String id) async {
    CustomerModel? customerModel = await CustomerService().getUserByID(id);
    if (customerModel == null || customerModel.name == null) {
      return false;
    }
    customerM.value = customerModel;
    return true;
  }

//get all customer
  Future<bool> getAllCustomer() async {
    List<CustomerModel>? result = await CustomerService().getAllCustomer();
    if (result == null) {
      return false;
    }
    for (CustomerModel customerModel in result) {
      cusList.add(customerModel);
    }
    return true;
  }
}
