import 'package:expense_tracker/presentation/item_details/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilities/extensions/extensions.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  final BehaviorSubject<bool> _isAddButtonVisible =
      BehaviorSubject<bool>.seeded(true);

  @override
  void dispose() {
    _scrollController.dispose();
    title.dispose();
    price.dispose();
    _isAddButtonVisible.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Details"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _date(context),
              Expanded(child: _expenseList(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _date(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      DateTime.now().formattedDate(),
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _expenseList(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 12,
      itemBuilder: (context, index) {
        if (index < 11) {
          return expenseItem(context, index, Theme.of(context));
        } else {
          return bottomItem(context);
        }
      },
    );
  }

  Widget expenseItem(BuildContext context, int index, ThemeData theme) {
    return GestureDetector(
      onLongPress: () {
        _longPressEvent(context, index);
      },
      child: card(context, theme, index),
    );
  }

  void _longPressEvent(BuildContext context, int index) {
    _isAddButtonVisible.add(false);
    _scrollDown();
  }

  Widget card(BuildContext context, ThemeData theme, int index) {
    return Card(
      elevation: 2.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: _cardItem(index, theme),
    );
  }

  _cardItem(int index, ThemeData theme) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: Icon(Icons.shopping_cart, color: theme.colorScheme.primary),
      title: Text(
        "Product ${index + 1}",
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: _trailingItem(index, theme),
    );
  }

  _trailingItem(int index, ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "\$${(index + 1) * 10}",
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline_outlined),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget bottomItem(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _isAddButtonVisible,
      initialData: true,
      builder: (context, addButtonSnapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (addButtonSnapshot.data!)
                ? _addButton(context)
                : _addNewExpenseForm(),
          ],
        );
      },
    );
  }

  Widget _addButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _isAddButtonVisible.add(false);
        _scrollDown();
      },
      style: _buttonStyle(),
      child: const Text('Add'),
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 200.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Widget _addNewExpenseForm() {
    return Column(
      children: [
        CustomTextField(labelText: "Description", controller: title),
        CustomTextField(labelText: "Price", controller: price),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _saveButton(context),
          ],
        ),
      ],
    );
  }

  Widget _saveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        onPressed: () {
          _isAddButtonVisible.add(true);
        },
        style: _buttonStyle(),
        child: const Text('Save'),
      ),
    );
  }

  _buttonStyle() {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12),
    );
  }
}
