import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:saraswantiland/models/driverModel.dart';

class berandaModel {
  static const String url = DriverModel.url + "/getberanda";
  String fotoAp;

  Future getDataAp() async {
    var responseData = await http.get(url);
    var data = json.decode(responseData.body);
    this.fotoAp = data['ap']['foto'];
  }
}
