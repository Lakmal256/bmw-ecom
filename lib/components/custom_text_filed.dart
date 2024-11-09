import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final double fontSize;
  final Icon icon;
  final TextEditingController controller;
  final bool obscureText;
  final bool showVisibilityToggle;
  final VoidCallback? toggleObscureTextCallback; // Added callback

  const CustomTextField({
    super.key,
    required this.labelText,
    this.hintText = '',
    required this.fontSize,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.showVisibilityToggle = false,
    this.toggleObscureTextCallback, // Added callback parameter
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor = _focusNode.hasFocus ? const Color(0xFF002366) : Colors.black54;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          border: Border.all(color: Theme.of(context).brightness == Brightness.light ? Colors.grey : Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          style: GoogleFonts.lato(color: const Color(0xFF000000)),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: Theme.of(context).inputDecorationTheme.labelStyle,
            prefixIcon: Icon(widget.icon.icon, color: iconColor),
            suffixIcon: widget.showVisibilityToggle
                ? IconButton(
              icon: Icon(
                widget.obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: iconColor,
              ),
              onPressed: widget.toggleObscureTextCallback, // Calls the callback when tapped
            )
                : null,
          ),
          obscureText: widget.obscureText,
          autocorrect: false,
        ),
      ),
    );
  }
}