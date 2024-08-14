import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({super.key});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  bool isButtonEnable = false;
  bool _showTextField = false;
  bool _showSaveButton = false;
  bool _showAddMoreButton = true;
  bool _isLongPressed = false;

  ({bool title, bool price}) enableButtonNotifier =
      (title: false, price: false);

  @override
  void initState() {
    super.initState();
    title.addListener(
      () => updateEnableButtonNotifier(),
    );
    price.addListener(
      () => updateEnableButtonNotifier(),
    );
  }

  void updateEnableButtonNotifier() {
    setState(() {
      enableButtonNotifier = (
        title: title.value.text.isNotEmpty,
        price: price.value.text.isNotEmpty,
      );
      isButtonEnable = enableButtonNotifier.title && enableButtonNotifier.price;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    title.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Details"),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _date(context),
              Expanded(child: _expenseList(theme)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _date(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      DateFormat('d MMM, yyyy').format(DateTime.now()),
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _expenseList(ThemeData theme) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 12,
      itemBuilder: (context, index) {
        if (index < 11) {
          return expenseItem(context, index, theme);
        } else {
          return bottomItem(context);
        }
      },
    );
  }

  Widget expenseItem(BuildContext context, int index, ThemeData theme) {
    return GestureDetector(
      onLongPress: () {
        _longPressEvent(index);
      },
      child: card(context, theme, index),
    );
  }

  void _longPressEvent(int index) {
    if (_isLongPressed) return;

    setState(() {
      _showAddMoreButton = false;
      _showSaveButton = true;
      _showTextField = true;
      title.text = "Product ${index + 1}";
      price.text = "${(index + 1) * 10}";
      _isLongPressed = true;
    });

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 200.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  card(BuildContext context, ThemeData theme, int index) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _showAddMoreButton == true ? _addButton(context) : Container(),
        if (_showTextField) _titleTextField(),
        if (_showTextField) _priceTextField(),
        if (_showSaveButton == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _saveButton(context),
            ],
          ),
      ],
    );
  }

  _addButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _addButtonEvent();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: const Text('Add'),
    );
  }

  void _addButtonEvent() {
    setState(() {
      _showAddMoreButton = false;
      _showSaveButton = true;
      _showTextField = true;
    });
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 200.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  _saveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        onPressed: () {
          _saveButtonEvent();
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: isButtonEnable
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: const Text('Save'),
      ),
    );
  }

  void _saveButtonEvent() {
    isButtonEnable
        ? setState(() {
            _showTextField = false;
            _showSaveButton = false;
            _showAddMoreButton = true;
            _isLongPressed = false;
            title.clear();
            price.clear();
          })
        : null;
  }

  Widget _titleTextField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: title,
        decoration: InputDecoration(
          labelText: "Description",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _priceTextField() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: price,
        decoration: InputDecoration(
          labelText: "Price",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
