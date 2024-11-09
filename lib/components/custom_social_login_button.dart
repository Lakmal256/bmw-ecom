import 'package:flutter/material.dart';

class CustomSocialSignInButton extends StatelessWidget {
  const CustomSocialSignInButton({
    super.key,
    required this.onPressed,
    required this.width,
    required this.height,
    required this.text,
    required this.imagePath,
    required this.iconSize,
    this.isIcon = false,
  });

  final VoidCallback onPressed;
  final double width;
  final double height;
  final String text;
  final String imagePath;
  final bool isIcon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.grey), // Black border color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(width, height),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Image(
                image: AssetImage(imagePath),
                height: iconSize,
                width: iconSize,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}