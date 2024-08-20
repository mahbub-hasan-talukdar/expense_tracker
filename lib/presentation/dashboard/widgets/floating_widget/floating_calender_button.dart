import 'package:flutter/material.dart';

class MyFloatingCalender extends StatelessWidget {
  const MyFloatingCalender({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            elevation: const WidgetStatePropertyAll(5),
            minimumSize: WidgetStatePropertyAll(
              Size(screenWidth, 75),
            ),
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.primary,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit_calendar_outlined,
                color: Theme.of(context).colorScheme.surface,
              ),
              const SizedBox(width: 10),
              Text(
                '10 jan, 2024',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: FloatingActionButton(
            onPressed: () {
              DateTime? dateTime;
              Future(() async {
                dateTime = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
              });
              print(dateTime);
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
