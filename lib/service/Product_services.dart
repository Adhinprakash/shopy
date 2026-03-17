import 'dart:convert';

import 'package:shopy/consts/app_consts.dart';
import 'package:shopy/model/product_model.dart';
import 'package:http/http.dart'as http;
class ProductServices {
  Future<Productsmodel>getProducts()async {
    final response = await http.get(Uri.parse(AppConsts.apiurl));
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // print(data);

      return Productsmodel.fromJson(data);
    }
    return Productsmodel.fromJson(data);
  }

}