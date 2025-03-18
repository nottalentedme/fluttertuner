import 'package:flutter/material.dart';

class AddBPMWidget extends StatelessWidget {
  const AddBPMWidget({
    super.key,
    required this.icon,
  });
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 2,
          color: Colors.black,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {},
        child: icon,
      ),
    );
  }
}
