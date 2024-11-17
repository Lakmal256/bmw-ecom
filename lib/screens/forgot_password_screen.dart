import 'package:e_commerce/components/components.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  final ForgotPasswordFormController controller = ForgotPasswordFormController();

  handlePasswordResetLinkSend() async {
    if (await controller.validate()) {
      try {
        locate<ProgressIndicatorController>().show();

        await AuthController().sendPasswordResetEmail(email: controller.value.uName!);

        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Password Reset Link Sent",
            subtitle: "Please Check Your Emails",
            color: Colors.green,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 5),
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pop();
        });
      } on UserNotFoundException catch (e) {
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: e.message,
            subtitle: e.message.length <= 20 ? "Please Try again" : '',
            color: Colors.red,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 5),
        );
      } catch (err) {
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Something went wrong",
            subtitle: "Sorry, something went wrong here",
            color: Colors.red,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 5),
        );
      } finally {
        locate<ProgressIndicatorController>().hide();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.surface,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/bmw_xm.jpg'), // Use AssetImage for local assets
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      'BMW Store',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Reset User Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.26,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ForgotPasswordForm(controller: controller),
                    CustomGradientButton(
                        onPressed: () => handlePasswordResetLinkSend(),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        text: 'Reset Password'),
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 10,
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => Navigator.of(context).pop()),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                'assets/bmw_sport_icon.png',
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulFormWidget<ForgotPasswordFormValue> {
  const ForgotPasswordForm({
    super.key,
    required ForgotPasswordFormController super.controller,
  });

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> with FormMixin {
  TextEditingController uNameTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (context, formValue, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border:
                      Border.all(color: Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0, bottom: 2.0),
                  child: TextField(
                    controller: uNameTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    style: GoogleFonts.lato(color: const Color(0xFF000000)),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Email",
                      hintStyle: GoogleFonts.lato(color: const Color(0xFF616161)),
                      errorText: formValue.getError("uName"),
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    onChanged: (value) => widget.controller.setValue(
                      widget.controller.value..uName = value,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ForgotPasswordFormValue extends FormValue {
  String? uName;

  ForgotPasswordFormValue({this.uName});
}

class ForgotPasswordFormController extends FormController<ForgotPasswordFormValue> {
  ForgotPasswordFormController() : super(initialValue: ForgotPasswordFormValue(uName: ""));

  @override
  Future<bool> validate() async {
    value.errors.clear();

    String? uName = value.uName;
    if (FormValidators.isEmpty(uName)) {
      value.errors.addAll({"uName": "Email is required"});
    } else {
      try {
        FormValidators.email(uName!);
      } on ArgumentError catch (err) {
        value.errors.addAll({"uName": err.message});
      }
    }

    setValue(value);
    return value.errors.isEmpty;
  }
}
