import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/provider/products_provider.dart';
import 'package:shopy/view/product_details/product_details.dart';

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
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,

              colors: [Colors.yellow, Colors.white],
            ),
          ),
        ),
        actions: [],
        toolbarHeight: 100,
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Consumer<ProductsProvider>(
          builder: (context, value, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.yellow.shade300, Colors.white],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
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
                            return Padding(
                              padding: const EdgeInsets.all(13),
                              child: GestureDetector(
                                onTap: () {
                                  value.changeCategory(categories[index]);
                                },
                                child: categoryContainer(
                                  value,
                                  categories[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Container(height: 200, color: Colors.white),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'For you',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            value.toggleLayout();
                          },
                          icon: Icon(
                            value.isloayourChange
                                ? Icons.list
                                : Icons.grid_view,
                          ),
                        ),
                      ],
                    ),
                    value.isloayourChange
                        ? Expanded(
                      flex: 1,
                            child:listviewLayoutCard(value)
                          )
                        : Expanded(
                            child: SizedBox(
                              height: 200,
                              child: gridviewLayoutCard(value),
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {}),
    );
  }

  Widget categoryContainer(ProductsProvider value, String categoryTitle) {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: value.selectedytype == categoryTitle
            ? Colors.yellow
            : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            offset: Offset(-6.0, -6.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          categoryTitle,
          style: TextStyle(
            fontSize: 12,
            color: value.selectedytype == categoryTitle
                ? Colors.white
                : Colors.black,
          ),
        ),
      ),
    );
  }
  Widget gridviewLayoutCard(ProductsProvider value){
    return GridView.builder(
      itemCount: value.catergorizedList.length,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final products =
        value.catergorizedList[index];
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(products: products,),)),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: Image.network(
                        products.thumbnail ?? '',
                      ),
                    ),
                    Text(
                      products.title ?? "N/A",
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.black,

                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "${products.price} \$" ?? 'N/A',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.green,size: 14,),
                        Text('${products.rating}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 6,

              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                child: Center(
                  child: Text(
                    "${products.discountPercentage.toString()}%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  Widget listviewLayoutCard(ProductsProvider value){
    return ListView.builder(
      itemCount: value.catergorizedList.length,
      itemBuilder: (context, index) {
        final product = value.catergorizedList[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: Image.network(
                      product.thumbnail!,
                    ),
                  ),
                  Positioned(

                      child: Container(
height: 20,
                    decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(12)),child: Center(child: Text("${product.discountPercentage}\%",style: TextStyle(color: Colors.white,fontSize: 10),),),))
                ],),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(product.title ?? 'N/A',style: TextStyle( color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,),),
                    Text("${product.price}\$",style: TextStyle(  fontWeight: FontWeight.bold,
                        fontSize: 13),),
                    Row(
                      children: [
                        Icon(Icons.star,color: Colors.green,size: 14,),
                        Text('${product.rating}'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
