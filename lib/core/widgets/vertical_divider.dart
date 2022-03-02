import 'package:flutter/material.dart';

class VertDivider extends StatelessWidget {
  const VertDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 24,
      child: VerticalDivider(
        color: Colors.black,
      ),
    );
  }
}
