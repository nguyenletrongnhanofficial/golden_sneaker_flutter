import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '/models/hives/cart.dart';
import '/models/hives/shoe.dart';
import '/providers/cart_provider.dart';
import '/providers/shoe_provider.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ShoeAdapter());
  await Hive.openBox<Shoe>('shoeBox');
  Hive.registerAdapter(CartAdapter());
  await Hive.openBox<Cart>('cartBox');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: ShoeProvider()),
      ChangeNotifierProvider.value(value: CartProvider())
    ],
    child: const MaterialApp(
      title: 'GOLDEN SNEAKER',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}
