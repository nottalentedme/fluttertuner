import 'package:flutter/material.dart';

class AddBPMWidget extends StatelessWidget {
  const AddBPMWidget({
    super.key,
    required this.icon,
    required this.onTap,
  });
  final Icon icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: icon));
  }
}
