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
    title.clear();
    price.clear();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _date(context),
            _selectAllRow(theme),
            Expanded(child: _expenseList(theme)),
          ],
        ),
      ),
    );
  }

  Widget _date(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        DateFormat('d MMM, yyyy').format(DateTime.now()),
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _selectAllRow(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Checkbox(
            value: false,
            onChanged: (value) {},
          ),
          const Text('Select All'),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
          const Text('Delete'),
        ],
      ),
    );
  }

  Widget _expenseList(ThemeData theme) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 8,
      itemBuilder: (context, index) {
        if (index < 7) {
          return GestureDetector(
            onLongPress: () {
              _isLongPressed
                  ? null
                  : setState(() {
                      _showAddMoreButton = false;
                      _showSaveButton = true;
                      _showTextField = true;
                      title.text = "Product ${index + 1}";
                      price.text = "${(index + 1) * 10}";
                    });
              if (_isLongPressed == false) {
                setState(() {
                  _isLongPressed = true;
                });
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent + 200.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: card(context, theme, index),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: _showAddMoreButton == true
                    ? _addMoreButton(context)
                    : Container(),
              ),
              if (_showTextField) _titleTextField(),
              if (_showTextField) _priceTextField(),
              if (_showSaveButton == true)
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _saveButton(context),
                    ],
                  ),
                )
            ],
          );
        }
      },
    );
  }

  card(BuildContext context, ThemeData theme, int index) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(Icons.shopping_cart, color: theme.colorScheme.primary),
        title: Text(
          "Product ${index + 1}",
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Row(
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
        ),
      ),
    );
  }

  _addMoreButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
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

  _saveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        isButtonEnable
            ? setState(() {
                _showTextField = false;
                _showSaveButton = false;
                _showAddMoreButton = true;
                title.clear();
                price.clear();
              })
            : null;
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
    );
  }

  Widget _titleTextField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
      padding: const EdgeInsets.all(16.0),
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
