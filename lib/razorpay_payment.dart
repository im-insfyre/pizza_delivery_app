import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayment extends StatefulWidget {
  const RazorPayment({Key? key, required this.price}) : super(key: key);
  final double price;

  @override
  State<RazorPayment> createState() => _RazorPaymentState();
}

class _RazorPaymentState extends State<RazorPayment> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Payment success logic
      showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Payment Successful'),
        content: Text('Payment ID: ${response.paymentId}'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Payment error logic
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Payment Error'),
        content: Text(
            'Error Code: ${response.code}\nError Message: ${response.message}'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // External wallet logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _startPayment();
          },
          child: Text('Pay ${widget.price}'),
        ),
      ),
    );
  }

  void _startPayment() {
    var options = {
      'key': 'rzp_test_YIhFZtRpUdv7O0',
      'amount': widget.price * 100, // Amount is in paise
      'name': 'Pizza App',
      'description': 'Payment for pizzas',
      'prefill': {'contact': '1234567890', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error: $e');
    }
  }
}
