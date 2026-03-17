
import 'package:flutter/cupertino.dart';
import 'package:shopy/service/Product_services.dart';

import '../model/product_model.dart';

class ProductsProvider extends ChangeNotifier{
  List<Products>_products=[];
  List<Products>get products=>_products;

  List<Products>_catergorizedList=[];
  List<Products>get catergorizedList=>_catergorizedList;

  final Map<String,List<Products>>_categorymap={};
  Map<String,List<Products>>get categorymap=>_categorymap;

 String selectedytype='All';

  Future<void>getAllproducts()async{
    try{
   final product=   await ProductServices().getProducts();
  _products=product.products??[];
  filteredList();
      notifyListeners();

    }catch(e){
      throw Exception(e.toString());
    }

  }

  Future<void>filteredList()async{
    for(Products  product in _products){
if(!_categorymap.containsKey(product.category)){
  _categorymap[product.category!]=[];

}else{
  _categorymap[product.category]!.add(product);
}

if(!_categorymap.containsKey(selectedytype)){
  selectedytype=selectedytype;
}
_catergorizedList=_categorymap[selectedytype]??_products;


    }
  }

}

