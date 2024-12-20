import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sushi_shop/components/alert_button.dart';
import 'package:sushi_shop/components/primaty_button.dart';

import 'package:sushi_shop/models/food.dart';
import 'package:sushi_shop/models/shop.dart';
import 'package:sushi_shop/theme/colors.dart';

class FoodDetailsPage extends StatefulWidget {
  final Food food;
  const FoodDetailsPage({super.key, required this.food});

  @override
  State<FoodDetailsPage> createState() => _FoodDetailsPageState();
}

class _FoodDetailsPageState extends State<FoodDetailsPage> {
  //quantity
  int quantityCount = 0;

  // decrement quantity
  void decrementQuantity() {
    if (quantityCount > 0) {
      setState(() {
        quantityCount--;
      });
    }
  }

  // increment quantity
  void incrementQuantity() {
    if (quantityCount < 100) {
      setState(() {
        quantityCount++;
      });
    }
  }

  void addToCard() {
    // only add to cart if there is something in the cart
    if (quantityCount > 0) {
      // get access to shop
      final shop = context.read<Shop>();
      // add to cart
      shop.addToCart(widget.food, quantityCount);
      // let the user know it was successfull
      showDialog(
        context: context,
        barrierDismissible:
            false, // cant do click anywhere to leave from dialog box
        builder: (context) => AlertDialog(
          backgroundColor: primaryColor,
          content: const Text(
            "Succesfully added to cart!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: MyAlertButton(
                  text: "Submit",
                  onTap: () {
                    // pop once to remove dialog box
                    Navigator.pop(context);
                    // pop again to go previous screen
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroungColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: const Text("Details"),
      ),
      body: Column(
        children: [
          // listview of food details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                children: [
                  // image
                  Image.asset(
                    widget.food.image,
                    height: 200,
                  ),

                  const SizedBox(
                    height: 25,
                  ),
                  // rating
                  Row(
                    children: [
                      //star icon
                      Icon(
                        Icons.star,
                        color: Colors.yellow[800],
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      // rating number
                      Text(
                        widget.food.rating,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // food name
                  Text(
                    widget.food.name,
                    style: GoogleFonts.dmSerifDisplay(fontSize: 28),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // description
                  Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Tender slices of fresh salmon, thinly sliced and arranged on fragrant rice seasoned with rice vinegar. This classic Japanese dish combines richness of flavor and health benefits. Salmon, known for its Omega-3 fatty acids, will give you not only gastronomic pleasure but also health benefits. Served with soy sauce, wasabi and pickled ginger, perfectly emphasizing its freshness. Discover the art of Japanese cuisine with every bite!",
                    style: TextStyle(color: Colors.grey[600], height: 2),
                  ),
                ],
              ),
            ),
          ),

          // price + quantity + add cart button
          Container(
            color: primaryColor,
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                // price + quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // price
                    Text(
                      "\$" + widget.food.price,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    // quantity
                    Row(
                      children: [
                        // minus button
                        Container(
                          decoration: BoxDecoration(
                              color: secondryColor, shape: BoxShape.circle),
                          child: IconButton(
                              onPressed: decrementQuantity,
                              icon: const Icon(
                                Icons.remove,
                                color: Colors.white,
                              )),
                        ),

                        // quantity count
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              quantityCount.toString(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),

                        // plus button
                        Container(
                          decoration: BoxDecoration(
                              color: secondryColor, shape: BoxShape.circle),
                          child: IconButton(
                            onPressed: incrementQuantity,
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),

                // add to cart button
                MyPrimaryButton(text: "Add to Cart", onTap: addToCard)
              ],
            ),
          )
        ],
      ),
    );
  }
}
