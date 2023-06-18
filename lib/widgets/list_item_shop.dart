import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/values/app_color.dart';
import '/models/hives/cart.dart';
import '/models/hives/shoe.dart';
import '/providers/cart_provider.dart';
import '/providers/shoe_provider.dart';

class ListItemShop extends StatefulWidget {
  final Shoe shoe;
  final VoidCallback? onClicked;
  const ListItemShop({Key? key, required this.shoe, required this.onClicked})
      : super(key: key);

  @override
  State<ListItemShop> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemShop> {
  bool isAdd = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<CartProvider>(context, listen: false)
          .checkProduct(widget.shoe.id!);
      // ignore: use_build_context_synchronously
      if (Provider.of<CartProvider>(context, listen: false).isExist) {
        setState(() {
          isAdd = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    String colorShoe = widget.shoe.color!.substring(1);
    String formattedPrice = widget.shoe.price!.toStringAsFixed(2);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          height: 370,
          decoration: BoxDecoration(
            color: Color(int.parse('0xFF$colorShoe')),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Transform.rotate(
            angle: -pi / 7,
            origin: const Offset(0, 50),
            child: Center(child: Image.network("${widget.shoe.image}")),
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.shoe.name!,
            style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Rubik-Bold',
                color: AppColor.colorBlack),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          widget.shoe.description!,
          style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Rubik-Light',
              height: 2,
              color: AppColor.colorBlack),
        ),
        const SizedBox(height: 20),
        Consumer<ShoeProvider>(
          builder: (context, value, child) => Row(
            children: [
              Expanded(
                child: Text(
                  "\$$formattedPrice",
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Rubik-Bold',
                      color: AppColor.colorBlack),
                ),
              ),
              if (!isAdd)
                ElevatedButton(
                  onPressed: () async {
                    await cartProvider
                        .addShoeInCart(
                          Cart(
                            id: widget.shoe.id,
                            image: widget.shoe.image,
                            name: widget.shoe.name,
                            number: 1,
                            color: widget.shoe.color,
                            price: widget.shoe.price,
                          ),
                        )
                        .whenComplete(() => cartProvider.getAllShoeInCart());
                    setState(() {
                      isAdd = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.colorYellow,
                    elevation: 0,
                    minimumSize: const Size(80, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'ADD TO CART',
                    style: TextStyle(
                      fontFamily: 'Rubik-SemiBold',
                      color: AppColor.colorBlack,
                    ),
                  ),
                )
              else
                Container(
                  height: 45,
                  width: 45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.colorYellow,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/check.png',
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}
