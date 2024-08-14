import 'package:expense_tracker/presentation/item_details/item_details.dart';
import 'package:expense_tracker/presentation/items_list/page/item_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../item_details/page/expense_details.dart';
import '../items_list/items_list.dart';

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
                    context.go("/${ExpenseDetailsPage.path}");
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
                    context.go('/${ItemListPage.path}');
                  },
                  child: const Text(
                    'item lists',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
