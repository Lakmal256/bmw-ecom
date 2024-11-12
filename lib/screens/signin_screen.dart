import 'package:e_commerce/components/components.dart';
import 'package:e_commerce/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/controllers.dart';
import '../utils/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  final SignInFormController controller = SignInFormController();

  handleSignInEmail() async {
    if (await controller.validate()) {
      try {
        locate<ProgressIndicatorController>().show();
        await AuthController().signInWithEmail(email: controller.value.uName!, password: controller.value.pwd!);
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Logged In",
            subtitle: "User Logged In Successfully",
            color: Colors.green,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 5),
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomNavigator().goTo(
            context,
            const Dashboard(),
          );
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
      } on WrongPasswordException catch (e) {
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: e.message,
            subtitle: e.message.length <= 20 ? "Please Try again" : '',
            color: Colors.red,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 5),
        );
      } on InvalidCredentialException catch (e) {
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

  handleSignInWithGoogle() async {
      try {
        locate<ProgressIndicatorController>().show();
        await AuthController().signInWithGoogle();
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Logged In",
            subtitle: "User Logged In Successfully",
            color: Colors.green,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 5),
        );
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CustomNavigator().goTo(
            context,
            const Dashboard(),
          );
        });
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
                      'Sign In To Your Account',
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
                    SignInForm(controller: controller),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ForgotPasswordScreen(),
                                  ),
                                );
                                emailTextEditingController.clear();
                                passwordTextEditingController.clear();
                              },
                              child: Text(
                                'Forgot Password?',
                                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                      color: const Color(0xFF002366),
                                      fontWeight: FontWeight.bold,
                                      shadows: Theme.of(context).brightness == Brightness.light
                                          ? []
                                          : [
                                              const Shadow(offset: Offset(-1.5, -1.5), color: Colors.grey),
                                              const Shadow(offset: Offset(1.5, -1.5), color: Colors.grey),
                                              const Shadow(offset: Offset(1.5, 1.5), color: Colors.grey),
                                              const Shadow(offset: Offset(-1.5, 1.5), color: Colors.grey),
                                            ],
                                    ),
                              ))),
                    ),
                    CustomGradientButton(
                        onPressed: () => handleSignInEmail(),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        text: 'Sign In'),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 20,
                            endIndent: 10,
                          ),
                        ),
                        Text(
                          'Or continue with',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.black54),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 10,
                            endIndent: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomSocialSignInButton(
                      onPressed: () => handleSignInWithGoogle(),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      text: 'Sign In with Google',
                      imagePath: 'assets/google_icon.webp',
                      iconSize: 30,
                    ),
                    CustomSocialSignInButton(
                      onPressed: () {},
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      text: 'Sign In with Apple',
                      imagePath: 'assets/apple_icon.png',
                      iconSize: 22,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                            );
                            emailTextEditingController.clear();
                            passwordTextEditingController.clear();
                          },
                          child: Text(
                            'Sign Up',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  color: const Color(0xFF002366),
                                  fontWeight: FontWeight.bold,
                                  shadows: Theme.of(context).brightness == Brightness.light
                                      ? []
                                      : [
                                          const Shadow(offset: Offset(-1.5, -1.5), color: Colors.grey),
                                          const Shadow(offset: Offset(1.5, -1.5), color: Colors.grey),
                                          const Shadow(offset: Offset(1.5, 1.5), color: Colors.grey),
                                          const Shadow(offset: Offset(-1.5, 1.5), color: Colors.grey),
                                        ],
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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

class SignInForm extends StatefulFormWidget<SignInFormValue> {
  const SignInForm({
    super.key,
    required SignInFormController super.controller,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> with FormMixin {
  TextEditingController uNameTextEditingController = TextEditingController();
  TextEditingController pWDTextEditingController = TextEditingController();
  bool _isObscure = true;

  late FocusNode _uNameFocusNode;
  late FocusNode _pwdFocusNode;

  @override
  void initState() {
    super.initState();
    _uNameFocusNode = FocusNode()..addListener(_handleFocusChange);
    _pwdFocusNode = FocusNode()..addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _uNameFocusNode.removeListener(_handleFocusChange);
    _pwdFocusNode.removeListener(_handleFocusChange);

    _uNameFocusNode.dispose();
    _pwdFocusNode.dispose();

    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Color uNameIconColor = _uNameFocusNode.hasFocus ? const Color(0xFF002366) : Colors.black54;
    final Color pwdIconColor = _pwdFocusNode.hasFocus ? const Color(0xFF002366) : Colors.black54;

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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0, bottom: 2.0),
                  child: TextField(
                    focusNode: _uNameFocusNode,
                    controller: uNameTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    style: GoogleFonts.lato(color: const Color(0xFF000000)),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Email",
                      hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                      errorText: formValue.getError("uName"),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: uNameIconColor,
                      ),
                    ),
                    onChanged: (value) => widget.controller.setValue(
                      widget.controller.value..uName = value,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  border:
                      Border.all(color: Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0, bottom: 2.0),
                  child: TextField(
                    focusNode: _pwdFocusNode,
                    controller: pWDTextEditingController,
                    obscureText: _isObscure,
                    autocorrect: false,
                    style: GoogleFonts.lato(
                      color: const Color(0xFF000000),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Password",
                      hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                      errorText: formValue.getError("pwd"),
                      prefixIcon: Icon(Icons.lock_outline_rounded, color: pwdIconColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: pwdIconColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    onChanged: (value) => widget.controller.setValue(
                      widget.controller.value..pwd = value,
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

class SignInFormValue extends FormValue {
  String? uName;
  String? pwd;

  SignInFormValue({this.uName, this.pwd});
}

class SignInFormController extends FormController<SignInFormValue> {
  SignInFormController() : super(initialValue: SignInFormValue());
  @override
  Future<bool> validate() async {
    value.errors.clear();

    String? uName = value.uName;
    String? password = value.pwd;

    if (FormValidators.isEmpty(uName)) {
      value.errors.addAll({"uName": "Email is required"});
    } else {
      try {
        FormValidators.email(uName!);
      } on ArgumentError catch (err) {
        value.errors.addAll({"uName": err.message});
      }
    }

    if (FormValidators.isEmpty(password)) {
      value.errors.addAll({"pwd": "Password is required"});
    } else {
      try {
        FormValidators.password(password!);
      } on ArgumentError catch (err) {
        value.errors.addAll({"pwd": err.message});
      }
    }

    setValue(value);
    return value.errors.isEmpty;
  }
}
