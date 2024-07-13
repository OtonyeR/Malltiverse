import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:malltiverse/navigation_menu.dart';
import 'package:malltiverse/screens/product_screen.dart';

import 'models/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Cart cart = Cart();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: ProductPage(cart: cart),
    );
  }
}
