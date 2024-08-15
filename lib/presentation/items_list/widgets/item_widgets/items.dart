import 'package:expense_tracker/presentation/items_list/bloc/item_state.dart';
import 'package:expense_tracker/presentation/items_list/widgets/item_bar_graph/generate_bars.dart';
import 'package:expense_tracker/presentation/items_list/widgets/item_widgets/single_item.dart';
import 'package:flutter/material.dart';

class MyItems extends StatefulWidget {
  final InitialFetchSuccess state;
  const MyItems({super.key, required this.state});

  @override
  State<MyItems> createState() => _MyItemsState();
}

class _MyItemsState extends State<MyItems> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: myAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            GenerateBars().myBarChart(widget.state),
            Expanded(
              child: _buildItems(widget.state, screenWidth),
            ),
          ],
        ),
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

  ListView _buildItems(InitialFetchSuccess state, double screenWidth) {
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
    InitialFetchSuccess state,
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

  void _initializeController() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.forward(from: 0.0);
  }
}
