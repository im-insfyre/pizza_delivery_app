import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizza_app/components/macro.dart';
import 'package:pizza_repository/pizza_repository.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class DetailsScreen extends StatefulWidget {
  final Pizza pizza;
  const DetailsScreen(this.pizza, {super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
  // Do something when payment succeeds
}

  void _handlePaymentError(PaymentFailureResponse response) {
  // Do something when payment fails
}

  void _handleExternalWallet(ExternalWalletResponse response) {
  // Do something when an external wallet is selected
}
  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - (40),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(3, 3),
                      blurRadius: 5,
                    )
                  ],
                  image: DecorationImage(image: NetworkImage(widget.pizza.picture))),
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(3, 3),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.pizza.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "₹${(widget.pizza.price) - widget.pizza.price * widget.pizza.discount / 100}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Text(
                                  "₹${widget.pizza.price}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        MyMacroWidget(
                          title: "Kcal",
                          value: widget.pizza.macros.calories,
                          icon: FontAwesomeIcons.fire,
                        ),
                        const SizedBox(width: 10),
                        MyMacroWidget(
                            title: "Protein",
                            value: widget.pizza.macros.proteins,
                            icon: FontAwesomeIcons.dumbbell),
                        const SizedBox(width: 10),
                        MyMacroWidget(
                            title: "Fats",
                            value: widget.pizza.macros.fat,
                            icon: FontAwesomeIcons.droplet),
                        const SizedBox(width: 10),
                        MyMacroWidget(
                            title: "Carbs",
                            value: widget.pizza.macros.carbs,
                            icon: FontAwesomeIcons.breadSlice),
                      ],
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextButton(
                        onPressed: () {
                          var options = {
                            'key' : 'rzp_test_t2PZX08i8FysY8',
                            'amount' : '100',
                            'name' : 'Naman Gatpalli',
                            'description' : 'Pizzeria',
                            'timeout' : 240,
                            'external': {
      'wallets': ['paytm', 'upi'] // Add UPI as a supported wallet
    }
                          };
                          _razorpay.open(options);
                        },
                        style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: const Text(
                          "Buy Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
