import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../utils/utils.dart';

class StripeService {
  Future<Map<String, dynamic>?> requestPaymentIntent(String totalAmount) async {
    locate<ProgressIndicatorController>().show();
    try {
      Response response = await post(Uri.parse("https://api.stripe.com/v1/payment_intents"), headers: {
        "Authorization": "Bearer ${dotenv.env["SECRET_KEY"]}",
        "Content-Type": "application/x-www-form-urlencoded"
      }, body: {
        "amount": (int.parse(totalAmount) * 100).toString(),
        "currency": "USD"
      });
      Logger().e(response.body);
      locate<ProgressIndicatorController>().hide();
      return jsonDecode(response.body);
    } catch (e) {
      locate<ProgressIndicatorController>().hide();
      return null;
    }
  }
}
