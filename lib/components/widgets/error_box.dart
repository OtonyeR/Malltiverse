import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

// Error message widget
class ErrorBox extends StatelessWidget {
  final String message;
  final Function() onPressed;
  const ErrorBox({
    super.key,
    required this.onPressed,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ImageIcon(
            AssetImage('assets/error.png'),
          ),
          const SizedBox(height: 24),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Text(
                message,
                textAlign: TextAlign.center,
              )),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: onPressed, // Properly call the function
            style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 16)),
            child: const Text(
              'Reload',
              style: TextStyle(
                fontSize: 12,
                color: mainWhite,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
