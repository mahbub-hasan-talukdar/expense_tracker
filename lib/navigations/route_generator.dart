import 'package:expense_tracker/presentation/dashboard/page/dashboard.dart';
import 'package:expense_tracker/presentation/dashboard/widgets/add_expense/add_expense_page.dart';
import 'package:expense_tracker/presentation/items_list/page/item_list_page.dart';
import 'package:go_router/go_router.dart';

import '../presentation/item_details/page/expense_details.dart';
import '../presentation/landing/landing.dart';
import 'error_screen.dart';

class RouteGenerator {
  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) {
          return "/${LandingPage.path}";
        },
      ),
      GoRoute(
        name: LandingPage.path,
        path: "/${LandingPage.path}",
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        name: ExpenseDetailsPage.path,
        path: "/${ExpenseDetailsPage.path}",
        builder: (context, state) => const ExpenseDetailsPage(),
      ),
      GoRoute(
        name: ItemListPage.path,
        path: "/${ItemListPage.path}",
        builder: (context, state) => const ItemListPage(),
      ),
      GoRoute(
        name: Dashboard.path,
        path: "/${Dashboard.path}",
        builder: (context, state) => const Dashboard(),
      ),
      GoRoute(
        name: AddExpensePage.path,
        path: "/${AddExpensePage.path}",
        builder: (context, state) => AddExpensePage(),
      ),
    ],
  );
}
