
import 'package:expense_tracker/domain/entity/item_entity.dart';
import 'package:expense_tracker/presentation/items_list/bloc/item_bloc.dart';
import 'package:expense_tracker/presentation/items_list/bloc/item_event.dart';
import 'package:expense_tracker/presentation/items_list/bloc/item_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});
  static const String path = 'itemList';

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    context.read<ItemBloc>().add(InitialFetchEvent());

    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;

    return BlocBuilder<ItemBloc, InitialFetchState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: Text(
              'Expense Tracker',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: SafeArea(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: (state.errorMessage != null)
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text("Error: ${state.errorMessage!}"),
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.list!.length,
                            itemBuilder: (context, index) {
                              return AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(
                                      0,
                                      _controller.value * 20,
                                    ),
                                    child: Opacity(
                                      opacity: _controller.value,
                                      child: _item(
                                          size, context, state.list!, index),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Card _item(
    double size,
    BuildContext context,
    List<ItemEntity> items,
    int index,
  ) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          height: size * .10,
          width: size * .10,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(1),
                Theme.of(context).colorScheme.primary.withOpacity(.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.account_balance_wallet,
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        title: Text(
          (items[index].date ==
                  DateFormat('d MMM, yyyy').format(DateTime.now()))
              ? 'Today'
              : items[index].date,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        subtitle: Text(
          'Total expense \$${items[index].price}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: () {},
      ),
    );
  }
}
