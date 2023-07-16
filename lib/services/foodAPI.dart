import 'package:http/http.dart' as http;
import '../config/apiConfig.dart';

class FoodAPI {
  Future getTodoByID(int id) async {
    var url = Uri.https(BaseAPI, food + id.toString());
    var response = await http.get(url);
    print("response: ${response.statusCode}");
    print("response body: ${response.body}");
  }
}
