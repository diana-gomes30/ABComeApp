import 'package:flutter/material.dart';

class IconBottomSheetWidget extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const IconBottomSheetWidget({
    Key? key,
    required this.color,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 20.0),
      child: Column(
        children: <Widget>[
          RawMaterialButton(
            onPressed: onPressed,
            fillColor: color,
            elevation: 2.0,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              icon,
              size: 40.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}