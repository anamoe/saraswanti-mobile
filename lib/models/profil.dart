import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/models/driverModel.dart';

class profilModel {
  static const String url = DriverModel.url + "/users?per_page=15";
  Future<List<dynamic>> getProfil() async {
    var result = await http.get(url);
    return json.decode(result.body)['data'];
  }
}
