import 'package:e_commerce/components/components.dart';
import 'package:e_commerce/components/custom_social_login_button.dart';
import 'package:e_commerce/screens/screens.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool _isObscured = true;

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
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
                    CustomTextField(
                        labelText: 'Email',
                        hintText: 'Email',
                        fontSize: 14,
                        icon: const Icon(Icons.email),
                        controller: emailTextEditingController),
                    CustomTextField(
                        labelText: 'Password',
                        hintText: 'Password',
                        fontSize: 14,
                        icon: const Icon(Icons.password_outlined),
                        controller: passwordTextEditingController,
                        obscureText: _isObscured,
                        showVisibilityToggle: true,
                        toggleObscureTextCallback: _toggleObscureText),
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
                        onPressed: () {}, width: MediaQuery.of(context).size.width, height: 45, text: 'Sign In'),
                    CustomSocialSignInButton(
                      onPressed: () {},
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
