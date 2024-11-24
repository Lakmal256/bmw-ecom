import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import 'screens.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  final List<Widget> _mainPages = [
    const Dashboard(),
    const FavouriteScreen(),
    const MyCart(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<LauncherProvider>(builder: (context, value, child) {
      return SafeArea(
        child: Scaffold(
          body: _mainPages[value.currentIndex],
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNBIcon(
                icon: Icons.home,
                isActive: value.currentIndex == 0,
                text: "Home",
                onTap: () {
                  value.changeIndex(0);
                },
              ),
              BottomNBIcon(
                icon: Icons.favorite,
                isActive: value.currentIndex == 1,
                text: "Favourite",
                onTap: () {
                  value.changeIndex(1);
                },
              ),
              BottomNBIcon(
                icon: Icons.shopping_cart,
                isActive: value.currentIndex == 2,
                text: "My Cart",
                onTap: () {
                  value.changeIndex(2);
                },
              ),
              BottomNBIcon(
                icon: Icons.person,
                isActive: value.currentIndex == 3,
                text: "Profile",
                onTap: () {
                  value.changeIndex(3);
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

class BottomNBIcon extends StatelessWidget {
  const BottomNBIcon({super.key, required this.icon, required this.isActive, required this.onTap, required this.text});
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Icon(
                icon,
                color: isActive ? const Color(0xFF002366).withOpacity(0.8) : Colors.grey.shade500,
              ),
              Text(
                text,
                style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
