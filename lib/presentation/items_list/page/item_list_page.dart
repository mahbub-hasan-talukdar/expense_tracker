import '../../../config/service_locator.dart';
import '../bloc/item_bloc.dart';
import '../bloc/item_event.dart';
import '../bloc/item_state.dart';
import 'error_page.dart';
import '../widgets/item_widgets/items.dart';

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
            return MyItems(itemList: state.list);
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
