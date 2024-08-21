
import '../../../../domain/entity/item_entity.dart';
import 'single_item.dart';

import 'package:flutter/material.dart';

class MyItems extends StatefulWidget {
  final List<ItemEntity>? itemList;
  static const path = 'MyItems';
  const MyItems({super.key, required this.itemList});

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
    return Scaffold(
      appBar: myAppBar(context),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // GenerateBars().myBarChart(widget.itemList),
            // if (widget.itemList != null) BarList(items: widget.itemList!),
            if (widget.itemList != null)
              Expanded(child: _buildItems(widget.itemList!)),
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

  ListView _buildItems(List<ItemEntity> itemList) {
    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return _animatedItem(context, itemList[index]);
          },
        );
      },
    );
  }

  Transform _animatedItem(
    BuildContext context,
    ItemEntity item,
  ) {
    return Transform.translate(
      offset: Offset(
        0,
        _controller.value * 20,
      ),
      child: Opacity(
        opacity: _controller.value,
        child: SingleItem(
          item: item,
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
