import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../model/product_model.dart';

class ProductDetails extends StatefulWidget {
  Products? products;

  ProductDetails({super.key, this.products});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  child: CarouselSlider(
                    items: widget.products?.images
                        ?.map(
                          (e) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(19),
                            ),
                            width: double.infinity,

                            child: Image.network(e),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      height: 450,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedindex = index;
                        });
                      },
                    ),
                  ),
                ),
                Positioned(
                  bottom: 1,
                  left: 0,
                  right: 5,

                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.products!.images!.asMap().entries.map((
                      item,
                    ) {
                      int index = item.key;
                      String imagepath = item.value;
                      return Container(
                        height: selectedindex == index ? 55 : 45,
                        width: selectedindex == index ? 55 : 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedindex == index
                                ? Colors.yellow
                                : Colors.transparent,
                            width: selectedindex == index ? 2 : 0.8,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.network(imagepath),
                      );
                    }).toList(),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.products?.availabilityStatus ?? '',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.products?.title ?? '',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Row(
                    spacing: 7,
                    children: [
                      Text(
                        "${widget.products!.discountPercentage}%",
                        style: TextStyle(color: Colors.red),
                      ),

                      Text(
                        "${widget.products?.price}\$" ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${widget.products?.description}" ?? '',
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  SizedBox(height: 17),
                  Text(
                    'Top reviews',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10,),


        Column(children: widget.products!.reviews!.map((review)=>revieWidget(review)).toList(),)

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget revieWidget(Reviews review){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 5,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.person_outline_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  review.reviewerName.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(children: List.generate(5, (index) {
              return Icon(Icons.star,color: Colors.orangeAccent,size: 15,);
            },),),

            Text('Great',style: TextStyle(fontSize: 14,color: Colors.black,fontWeight: FontWeight.bold),),
            Text(review.comment!)
          ],
        ),
      ),
    );
  }
}
