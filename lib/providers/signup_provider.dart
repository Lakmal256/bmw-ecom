import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pWDController = TextEditingController();
  final TextEditingController _pWDConfirmController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get pWDController => _pWDController;
  TextEditingController get pWDConfirmController => _pWDConfirmController;
}
