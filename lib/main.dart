import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopy/provider/products_provider.dart';
import 'package:shopy/view/home_page.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsProvider>(create: (context) => ProductsProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
textTheme:GoogleFonts.interTextTheme(Theme.of(context).textTheme)
        ),
        home: HomePage()
      ),
    );
  }
}
