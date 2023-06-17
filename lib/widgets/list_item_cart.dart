import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/values/app_color.dart';
import '/models/hives/cart.dart';
import '/providers/cart_provider.dart';

class ListItemCart extends StatelessWidget {
  final Cart cart;
  final int index;

  const ListItemCart({
    Key? key,
    required this.cart,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final colorShoe = cart.color?.substring(1);
    final formattedPrice = cart.price!.toStringAsFixed(2);

    return Stack(
      children: [
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Color(int.parse('0xFF$colorShoe')),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 19,
                  offset: const Offset(17, 15),
                ),
              ],
            ),
          ),
        ),
        Transform.rotate(
          angle: -pi / 7,
          origin: const Offset(-90, 45),
          child: Image.network(
            cart.image!,
            height: 150,
            width: 150,
          ),
        ),
        Positioned(
          left: 130,
          right: 0,
          top: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cart.name!,
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Rubik-Bold',
                    color: AppColor.colorBlack),
              ),
              const SizedBox(height: 10),
              Text(
                '\$$formattedPrice',
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Rubik-Bold',
                    color: AppColor.colorBlack),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      if (cart.number == 1) {
                        cartProvider.removeShoeInCart(index).whenComplete(() {
                          cartProvider.getAllShoeInCart();
                        });
                      } else {
                        cartProvider
                            .updateShoeInCart(
                              Cart(
                                id: cart.id,
                                image: cart.image,
                                name: cart.name,
                                number: cart.number! - 1,
                                color: cart.color,
                                price: cart.price,
                              ),
                              index,
                            )
                            .whenComplete(
                                () => cartProvider.getAllShoeInCart());
                      }
                    },
                    child: Container(
                      width: 27,
                      height: 27,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFeeeeee),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Image.asset(
                          'assets/images/minus.png',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: Text(
                      '${cart.number}',
                      style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Rubik-Light',
                          color: AppColor.colorBlack),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      cartProvider
                          .updateShoeInCart(
                            Cart(
                              id: cart.id,
                              image: cart.image,
                              name: cart.name,
                              number: cart.number! + 1,
                              color: cart.color,
                              price: cart.price,
                            ),
                            index,
                          )
                          .whenComplete(() => cartProvider.getAllShoeInCart());
                    },
                    child: Container(
                      width: 27,
                      height: 27,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFeeeeee),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Image.asset(
                          'assets/images/plus.png',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          cartProvider.removeShoeInCart(index).whenComplete(() {
                            cartProvider.getAllShoeInCart();
                          });
                        },
                        child: Container(
                          width: 27,
                          height: 27,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.colorYellow,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.asset(
                              'assets/images/trash.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
