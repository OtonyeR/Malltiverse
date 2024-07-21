import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:malltiverse/providers/history_provider.dart';
import 'package:malltiverse/screens/nav_screen.dart';

import 'models/order_item.dart';
import 'models/product.dart';
import 'services/hive_services.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(OrderItemAdapter());
  await openBoxes();
  OrderHistoryBox().clearHistory();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> openBoxes() async {
  await Hive.openBox<Product>('dataBox');
  await Hive.openBox<OrderItem>('historyBox');
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
      home: MainScreen(
        index: 0,
      ),
    );
  }
}
