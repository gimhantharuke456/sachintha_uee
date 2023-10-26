import 'package:flutter/material.dart';

class BackRow extends StatelessWidget {
  const BackRow({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.black,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            Text(
              "Back",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
