import 'package:expense_tracker/presentation/dashboard/page/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../item_details/page/expense_details.dart';
import '../items_list/page/item_list_page.dart';

class LandingPage extends StatefulWidget {
  static const String path = "landing";

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () {
                    //final selectedDate = DateTime.now();
                    final dateString = "2025-08-20";
                    print("format: $dateString");
                    context.go("/${ExpenseDetailsPage.path}/$dateString");
                  },
                  child: const Text(
                    'item_details',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.blue),
                  ),
                  onPressed: () {
                    context.go('/${Dashboard.path}');
                  },
                  child: const Text(
                    'Dashboard',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
