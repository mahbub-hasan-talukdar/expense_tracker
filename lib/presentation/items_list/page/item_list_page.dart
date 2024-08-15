import 'package:expense_tracker/config/service_locator.dart';
import 'package:expense_tracker/navigations/error_screen.dart';
import 'package:expense_tracker/presentation/items_list/bloc/item_bloc.dart';
import 'package:expense_tracker/presentation/items_list/bloc/item_event.dart';
import 'package:expense_tracker/presentation/items_list/bloc/item_state.dart';
import 'package:expense_tracker/presentation/items_list/page/error_page.dart';
import 'package:expense_tracker/presentation/items_list/widgets/item_widgets/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});
  static const String path = 'itemList';

  @override
  ItemListState createState() => ItemListState();
}

class ItemListState extends State<ItemListPage>
    with SingleTickerProviderStateMixin {
  final ItemBloc _itemBloc = sl<ItemBloc>();

  @override
  void initState() {
    super.initState();
    _itemBloc.add(InitialFetchEvent());
  }

  @override
  void dispose() {
    _itemBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(
      bloc: _itemBloc,
      builder: (context, state) {
        switch (state) {
          case InitialFetchFailed():
            return MyErrorPage(errorMessage: state.errorMessage);
          case InitialFetchSuccess():
            return MyItems(state: state);
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
