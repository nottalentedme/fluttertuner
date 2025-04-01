import 'package:flutter/material.dart';

class InstrumentTitleWidget extends StatelessWidget {
  const InstrumentTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          //TODO Заменить иконку потом на DropDownMenu
          DropdownButton(
            items: const [
              DropdownMenuItem(
                child: Text(
                  'Гитара',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(
            width: 100,
          ),
        ],
      ),
    );
  }
}
