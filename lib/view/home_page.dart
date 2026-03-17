import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/provider/products_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProductsProvider>(context, listen: false).getAllproducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shopy",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.search),
                  labelText: "Search",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.yellow.shade400,
        actions: [],
        toolbarHeight: 100,
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Consumer<ProductsProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    flex: 0,
                    child: SizedBox(
                      height: 70,
                      child: ListView.builder(
                        itemCount: value.categorymap.keys.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final categories = value.categorymap.keys
                              .toSet()
                              .toList();
                          return Container(
                            height: 100,
                            width: 100,
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                categories[index],
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Container(height: 200, color: Colors.green),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('For you'),
                      Row(
                        children: [Icon(Icons.grid_view, color: Colors.grey)],
                      ),
                    ],
                  ),
                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: value.catergorizedList.length,
                  //     itemBuilder: (context, index) {
                  //       final product = value.catergorizedList[index];
                  //
                  //       return Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: Container(
                  //           height: 70,
                  //           decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(14),
                  //           ),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [Text(product.title ?? 'N/A')],
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // )
                  Expanded(
                    child: SizedBox(
                      height: 200,
                      child: GridView.builder(
                        itemCount: value.catergorizedList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final products=value.catergorizedList[index];
                          return  Stack(
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(child: Image.network(products.thumbnail??''),),
                                    Text(products.title??"N/A"),
                                    Text(products.price.toString()??'N/A')
                                  ],
                                ),
                              ),
                              Positioned(
                                  top: 10,
                                  
                                  child: Container(
                                    decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(12)),
                                    child:Center(child: Text("${products.discountPercentage.toString()}%",style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.bold),),),))
                            ],
                          );  
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {}),
    );
  }
}
