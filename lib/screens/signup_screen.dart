import 'package:e_commerce/components/components.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();

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
                    CustomTextField(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm Password',
                        fontSize: 14,
                        icon: const Icon(Icons.password_outlined),
                        controller: confirmPasswordTextEditingController,
                        obscureText: _isObscured,
                        showVisibilityToggle: false),
                    CustomGradientButton(
                        onPressed: () {}, width: MediaQuery.of(context).size.width, height: 45, text: 'Sign Up'),
                    const SizedBox(
                      height: 20,
                    ),
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
