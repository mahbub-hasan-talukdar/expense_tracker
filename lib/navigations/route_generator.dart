import 'package:expense_tracker/presentation/items_list/page/item_list_page.dart';
import 'package:go_router/go_router.dart';

import '../presentation/items_list/page/item_list_page.dart';
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
        path: "/${ExpenseDetailsPage.path}/:date",
        builder: (context, state) {
          final dateString = state.pathParameters['date']!;
          final date = DateTime.parse(dateString);
          return ExpenseDetailsPage(dateTime: date);
        },
      ),

      GoRoute(
        name: ItemListPage.path,
        path: "/${ItemListPage.path}",
        builder: (context, state) => const ItemListPage(),
      )
    ],
  );
}
