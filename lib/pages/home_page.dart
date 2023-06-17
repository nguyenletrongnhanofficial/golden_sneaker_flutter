import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/values/app_color.dart';
import '/models/hives/cart.dart';
import '/providers/cart_provider.dart';
import '/providers/shoe_provider.dart';
import '/widgets/custom_pain.dart';
import '/widgets/list_item_cart.dart';
import '/widgets/list_item_shop.dart';
import '/widgets/draw_clip.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  totalCart(List<Cart> list) {
    double total = 0;
    for (int i = 0; i < list.length; i++) {
      total = total + (list[i].price! * list[i].number!);
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: const Duration(seconds: 10),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<ShoeProvider>(context, listen: false)
          .getAllProductsServerandSaveLocal();
      Provider.of<ShoeProvider>(context, listen: false).getAllShoesLocal();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: DrawClip(_controller.value),
                  child: Container(
                    height: size.height * 0.5,
                    decoration: const BoxDecoration(
                      color: AppColor.colorYellow,
                    ),
                  ),
                ),
              );
            },
          ),
          SingleChildScrollView(
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                if (viewportConstraints.maxWidth < 800) {
                  // Vertical layout
                  return Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: Column(
                        children: [
                          buildProductsContainer(),
                          const SizedBox(height: 40),
                          buildCartContainer(),
                        ],
                      ),
                    ),
                  );
                } else {
                  // Horizontal layout
                  return Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildProductsContainer(),
                        const SizedBox(width: 40),
                        buildCartContainer(),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductsContainer() {
    final Size size = MediaQuery.of(context).size;
    return Consumer<ShoeProvider>(
      builder: (context, shoeData, child) => Container(
        height: 600,
        width: 360,
        decoration: BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColor.colorGray.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
            ]),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CustomPaint(
                size: Size(size.width, size.height),
                painter: RPSCustomPainterTop(),
              ),
            ),
            Positioned(
                top: 7,
                left: 20,
                child: Image.asset(
                  "assets/images/nike.png",
                  width: 50,
                  height: 40,
                )),
            const Positioned(
              left: 20,
              top: 60,
              child: Text(
                "Our Products",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Rubik-Bold",
                    color: AppColor.colorBlack),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<ShoeProvider>(
                  builder: (context, shoeData, child) => SizedBox(
                        height: 490,
                        width: 310,
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context)
                              .copyWith(scrollbars: false),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: shoeData.shoes.length,
                            itemBuilder: (context, index) {
                              return ListItemShop(
                                  shoe: shoeData.shoes[index],
                                  onClicked: () {});
                            },
                          ),
                        ),
                      )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartContainer() {
    final Size size = MediaQuery.of(context).size;
    return Consumer<CartProvider>(
      builder: (context, cartData, child) => Container(
        height: 600,
        width: 360,
        decoration: BoxDecoration(
            color: AppColor.colorWhite,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: AppColor.colorGray.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
            ]),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CustomPaint(
                size: Size(size.width, size.height),
                painter: RPSCustomPainterTop(),
              ),
            ),
            Positioned(
                top: 7,
                left: 20,
                child: Image.asset(
                  "assets/images/nike.png",
                  width: 50,
                  height: 50,
                )),
            const Positioned(
              left: 20,
              top: 60,
              child: Text(
                "Your Cart",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Rubik-Bold",
                    color: AppColor.colorBlack),
              ),
            ),
            Positioned(
              right: 20,
              top: 60,
              child: Text(
                "\$${(totalCart(cartData.carts)).toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 25, fontFamily: "Rubik-Bold"),
              ),
            ),
            cartData.carts.isEmpty
                ? const Positioned(
                    left: 20, top: 100, child: Text('Your cart is empty.'))
                : Positioned(
                    left: 20,
                    bottom: 0,
                    child: SizedBox(
                      height: 490,
                      width: 310,
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cartData.carts.length,
                            itemBuilder: (context, index) {
                              return ListItemCart(
                                cart: cartData.carts[index],
                                index: index,
                              );
                            }),
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
