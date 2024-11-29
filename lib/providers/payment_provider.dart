import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import '../services/services.dart';
import '../utils/utils.dart';
import 'providers.dart';

class PaymentProvider extends ChangeNotifier {
  StripeService service = StripeService();

  Future<void> getPayment(String totalAmount, BuildContext context) async {
    try {
      // Request a PaymentIntent from your backend or Stripe API
      dynamic intent = await service.requestPaymentIntent(totalAmount);

      if (intent != null) {
        // Initialize the payment sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: intent['client_secret'],
            style: ThemeMode.system,
            merchantDisplayName: "Stripe Payment",
          ),
        );

        // Present the payment sheet
        await Stripe.instance.presentPaymentSheet();

        // Handle payment success
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Payment Successful!",
            subtitle: "Payment of \$$totalAmount successfully completed",
            color: Colors.green,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 3),
        );

        // Save order details
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<CartProvider>(context, listen: false).saveOrderDetails(context);
          Provider.of<CartProvider>(context, listen: false).clearCart();
        });
      }
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        // Handle the case where the user cancels the payment
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Payment Canceled",
            subtitle: "You canceled the payment process.",
            color: Colors.orange,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 3),
        );
      } else {
        // Handle other Stripe-related errors
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Payment Failed",
            subtitle: "An error occurred: ${e.error.localizedMessage}",
            color: Colors.red,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle any other unexpected errors
      locate<PopupController>().addItemFor(
        DismissiblePopup(
          title: "Payment Error",
          subtitle: "An unexpected error occurred. Please try again.",
          color: Colors.red,
          onDismiss: (self) => locate<PopupController>().removeItem(self),
        ),
        const Duration(seconds: 3),
      );
    }
  }
}
