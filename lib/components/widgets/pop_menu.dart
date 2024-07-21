import 'package:flutter/material.dart';
import 'package:malltiverse/components/colors.dart';
import 'package:malltiverse/screens/order_history.dart';
import 'package:malltiverse/screens/profile.dart';
import 'package:malltiverse/screens/wishlist.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        switch (value) {
          case '/profile':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
            break;
          case '/orderHistory':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
            );
            break;
          case '/wishlist':
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WishListScreen()),
            );
            break;
        }
      },
      color: mainBlack.withOpacity(0.8),
      position: PopupMenuPosition.under,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      icon: const Icon(
        Icons.person_outline,
        color: Colors.black,
        size: 28,
      ),
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: '/orderHistory',
            child: PopUpItem(
              title: 'Order History',
              icon: Icons.receipt,
            ),
          ),
          const PopupMenuItem<String>(
            value: '/wishlist',
            child: PopUpItem(
              title: 'Wishlist',
              icon: Icons.favorite_rounded,
            ),
          ),
        ];
      },
    );
  }
}

class PopUpItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const PopUpItem({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
