import 'dart:math';
import 'package:flutter/material.dart';
import 'package:golden_sneaker_flutter/pages/home_page.dart';
import 'package:provider/provider.dart';
import '/values/app_color.dart';
import '/models/hives/cart.dart';
import '/providers/cart_provider.dart';

class ListItemCart extends StatefulWidget {
  final Cart cart;
  final int index;
  const ListItemCart({
    Key? key,
    required this.cart,
    required this.index,
  }) : super(key: key);

  @override
  State<ListItemCart> createState() => _ListItemCartState();
}

class _ListItemCartState extends State<ListItemCart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final colorShoe = widget.cart.color?.substring(1);
    final formattedPrice = widget.cart.price!.toStringAsFixed(2);
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _controller.value,
            child: Transform.scale(
              scale: _controller.value,
              child: child,
            ),
          );
        },
        child: Stack(
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
                widget.cart.image!,
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
                    widget.cart.name!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Rubik-Bold',
                      color: AppColor.colorBlack,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$$formattedPrice',
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Rubik-Bold',
                      color: AppColor.colorBlack,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MinusButton(
                        onTap: () =>
                            handleMinusButtonTap(context, cartProvider),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        '${widget.cart.number}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Rubik-Light',
                          color: AppColor.colorBlack,
                        ),
                      ),
                      const SizedBox(width: 15),
                      PlusButton(
                        onTap: () => handlePlusButtonTap(context, cartProvider),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: RemoveButton(
                            onTap: () =>
                                handleRemoveButtonTap(context, cartProvider),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void handleMinusButtonTap(BuildContext context, CartProvider cartProvider) {
    if (widget.cart.number == 1) {
      _controller.reverse().then((_) {
        cartProvider.removeShoeInCart(widget.index).whenComplete(() {
          cartProvider.getAllShoeInCart();
        });
      });
    } else {
      cartProvider
          .updateShoeInCart(
            Cart(
              id: widget.cart.id,
              image: widget.cart.image,
              name: widget.cart.name,
              number: widget.cart.number! - 1,
              color: widget.cart.color,
              price: widget.cart.price,
            ),
            widget.index,
          )
          .whenComplete(() => cartProvider.getAllShoeInCart());
    }
  }

  void handlePlusButtonTap(BuildContext context, CartProvider cartProvider) {
    cartProvider
        .updateShoeInCart(
          Cart(
            id: widget.cart.id,
            image: widget.cart.image,
            name: widget.cart.name,
            number: widget.cart.number! + 1,
            color: widget.cart.color,
            price: widget.cart.price,
          ),
          widget.index,
        )
        .whenComplete(() => cartProvider.getAllShoeInCart());
  }

  void handleRemoveButtonTap(BuildContext context, CartProvider cartProvider) {
    _controller.reverse().then((_) {
      cartProvider.removeShoeInCart(widget.index).whenComplete(() {
        cartProvider.getAllShoeInCart();
      });
    });
  }
}

class MinusButton extends StatelessWidget {
  final VoidCallback onTap;
  const MinusButton({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
    );
  }
}

class PlusButton extends StatelessWidget {
  final VoidCallback onTap;
  const PlusButton({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
    );
  }
}

class RemoveButton extends StatelessWidget {
  final VoidCallback onTap;
  const RemoveButton({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
    );
  }
}
