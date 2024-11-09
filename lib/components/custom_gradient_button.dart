import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton(
      {super.key,
      required this.onPressed,
      required this.width,
      required this.height,
      required this.text,
      this.isIcon = false});

  final VoidCallback onPressed;
  final double width;
  final double height;
  final String text;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
      child: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF002399), Color(0xFF002366)]),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: TextButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
