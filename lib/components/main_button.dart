import 'package:sachintha_uee/utils/constants.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color color;
  final Color textColor;
  const MainButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.color = primaryColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: MaterialButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: onPressed,
        minWidth: MediaQuery.of(context).size.width,
        height: kToolbarHeight,
        elevation: 0,
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
