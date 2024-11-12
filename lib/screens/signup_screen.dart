import 'package:e_commerce/components/components.dart';
import 'package:e_commerce/controllers/controllers.dart';
import 'package:e_commerce/screens/dashboard.dart';
import 'package:e_commerce/screens/launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();
  final SignUpFormController controller = SignUpFormController();

  handleSignUpWithEmail() async {
    if (await controller.validate()) {
      try {
        locate<ProgressIndicatorController>().show();
        await AuthController()
            .createUserAccountWithEmail(email: controller.value.uName!, password: controller.value.pwd!);
        locate<PopupController>().addItemFor(
          DismissiblePopup(
            title: "Profile Created",
            subtitle: "The Profile has been created successfully!",
            color: Colors.green,
            onDismiss: (self) => locate<PopupController>().removeItem(self),
          ),
          const Duration(seconds: 5),
        );
        if (mounted) {
          CustomNavigator().goTo(
            context,
            const LauncherScreen(),
          );
        }
      } on UserAlreadyExistsException catch (e) {
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
                  image: const AssetImage('assets/bmw_xm.jpg'),
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
                      'Create a New Account',
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
                    SignUpForm(controller: controller),
                    CustomGradientButton(
                        onPressed: () => handleSignUpWithEmail(),
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        text: 'Sign Up'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Sign In',
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
                      height: 15,
                    ),
                    CustomSocialSignInButton(
                      onPressed: () => handleSignInWithGoogle(),
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      text: 'Sign In with Google',
                      imagePath: 'assets/google_icon.webp',
                      iconSize: 30,
                    ),
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
                )),
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

class SignUpForm extends StatefulFormWidget<SignUpFormValue> {
  const SignUpForm({
    super.key,
    required SignUpFormController super.controller,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with FormMixin {
  TextEditingController uNameTextEditingController = TextEditingController();
  TextEditingController pWDTextEditingController = TextEditingController();
  TextEditingController pWDConfirmTextEditingController = TextEditingController();
  bool _isObscure = true;
  late FocusNode _uNameFocusNode;
  late FocusNode _pwdFocusNode;
  late FocusNode _pwdConfirmFocusNode;

  @override
  void initState() {
    super.initState();
    _uNameFocusNode = FocusNode()..addListener(_handleFocusChange);
    _pwdFocusNode = FocusNode()..addListener(_handleFocusChange);
    _pwdConfirmFocusNode = FocusNode()..addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _uNameFocusNode.removeListener(_handleFocusChange);
    _pwdFocusNode.removeListener(_handleFocusChange);
    _pwdConfirmFocusNode.removeListener(_handleFocusChange);

    _uNameFocusNode.dispose();
    _pwdFocusNode.dispose();
    _pwdConfirmFocusNode.dispose();

    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Color uNameIconColor = _uNameFocusNode.hasFocus ? const Color(0xFF002366) : Colors.black54;
    final Color pwdIconColor = _pwdFocusNode.hasFocus ? const Color(0xFF002366) : Colors.black54;
    final Color pwdConfirmIconColor = _pwdConfirmFocusNode.hasFocus ? const Color(0xFF002366) : Colors.black54;

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
                    focusNode: _pwdConfirmFocusNode,
                    controller: pWDConfirmTextEditingController,
                    obscureText: _isObscure,
                    autocorrect: false,
                    style: GoogleFonts.lato(
                      color: const Color(0xFF000000),
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Confirm Password",
                      hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
                      errorText: formValue.getError("confirmPwd"),
                      prefixIcon: Icon(Icons.lock_outline_rounded, color: pwdConfirmIconColor),
                    ),
                    onChanged: (value) => widget.controller.setValue(
                      widget.controller.value..confirmPwd = value,
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

class SignUpFormValue extends FormValue {
  String? uName;
  String? pwd;
  String? confirmPwd;

  SignUpFormValue({this.uName, this.pwd, this.confirmPwd});
}

class SignUpFormController extends FormController<SignUpFormValue> {
  SignUpFormController() : super(initialValue: SignUpFormValue());
  @override
  Future<bool> validate() async {
    value.errors.clear();

    String? uName = value.uName;
    String? password = value.pwd;
    String? cPassword = value.confirmPwd;

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

      if (password != cPassword) {
        value.errors.addAll({"confirmPwd": "Confirmation do not match"});
      }
    }

    if (FormValidators.isEmpty(cPassword)) {
      value.errors.addAll({"confirmPwd": "Password confirmation is required"});
    }

    setValue(value);
    return value.errors.isEmpty;
  }
}
