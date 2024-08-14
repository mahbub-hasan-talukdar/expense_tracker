import 'package:expense_tracker/presentation/items_list/bloc/item_bloc.dart';
import 'package:expense_tracker/presentation/items_list/bloc/item_event.dart';
import 'package:expense_tracker/presentation/items_list/bloc/item_state.dart';
import 'package:expense_tracker/presentation/items_list/widgets/item_bar_graph/generate_bars.dart';
import 'package:expense_tracker/presentation/items_list/widgets/item_bar_graph/item_bar_graph.dart';
import 'package:expense_tracker/presentation/items_list/widgets/single_item.dart';
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
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
    context.read<ItemBloc>().add(InitialFetchEvent());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<ItemBloc, InitialFetchState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: myAppBar(context),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // myBarChart(state),
                Expanded(
                  child: (state.errorMessage != null)
                      ? _showError(state)
                      : _buildItems(state, screenWidth),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ListView _buildItems(InitialFetchState state, double screenWidth) {
    return ListView.builder(
      itemCount: state.list!.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return _animatedItem(screenWidth, context, state, index);
          },
        );
      },
    );
  }

  Transform _animatedItem(
    double screenWidth,
    BuildContext context,
    InitialFetchState state,
    int index,
  ) {
    return Transform.translate(
      offset: Offset(
        0,
        _controller.value * 20,
      ),
      child: Opacity(
        opacity: _controller.value,
        child: SingleItem(
          screenWidth: screenWidth,
          context: context,
          items: state.list!,
          index: index,
        ),
      ),
    );
  }

  Center _showError(InitialFetchState state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text("Error: ${state.errorMessage!}"),
      ),
    );
  }

  SizedBox myBarChart(InitialFetchState state) {
    return SizedBox(
      height: 200,
      width: (state.list == null) ? 0 : state.list!.length * 60.0,
      child: ItemBarGraph(
        itemBars: GenerateBars.generateBars(state.list),
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Expense Tracker',
        style: TextStyle(
          color: Theme.of(context).colorScheme.surface,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }

  void _initializeController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.forward(from: 0.0);
  }
}
