import 'package:expense_tracker/config/service_locator.dart';
import 'package:expense_tracker/domain/entity/expense_details_entity.dart';
import 'package:expense_tracker/presentation/item_details/bloc/expense_details_bloc.dart';
import 'package:expense_tracker/presentation/item_details/bloc/expense_details_event.dart';
import 'package:expense_tracker/presentation/item_details/bloc/expense_details_state.dart';
import 'package:expense_tracker/presentation/item_details/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilities/extensions/extensions.dart';

import '../widget/button.dart';

class ExpenseDetailsPage extends StatefulWidget {
  static const String path = "expense-details";

  const ExpenseDetailsPage({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  State<ExpenseDetailsPage> createState() => _ExpenseDetailsPageState();
}

class _ExpenseDetailsPageState extends State<ExpenseDetailsPage> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  final BehaviorSubject<bool> _isAddButtonVisible =
      BehaviorSubject<bool>.seeded(true);
  final ExpenseDetailsBloc _bloc = sl<ExpenseDetailsBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(FetchExpenseEvent(date: widget.dateTime));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    title.dispose();
    price.dispose();
    _isAddButtonVisible.close();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
      widget.dateTime.formattedDate(),
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _expenseList(BuildContext context) {
    return BlocBuilder<ExpenseDetailsBloc, ExpenseDetailsState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is FetchExpenseSuccess) {
          final expenses = state.list;
          if (expenses == null || expenses.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text('No expenses found.')),
                const SizedBox(height: 30),
                bottomItem(context),
              ],
            );
          }

          return ListView.builder(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            itemCount: expenses.length + 1,
            itemBuilder: (context, index) {
              if (index < expenses.length) {
                final expense = expenses[index];
                return expenseItem(context, expense, Theme.of(context));
              } else {
                return bottomItem(context);
              }
            },
          );
        } else if (state is FetchExpenseError) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget expenseItem(
      BuildContext context, ExpenseDetailsEntity expense, ThemeData theme) {
    return GestureDetector(
      onLongPress: () {
        _longPressEvent(context, expense);
      },
      child: card(context, theme, expense),
    );
  }

  void _longPressEvent(BuildContext context, ExpenseDetailsEntity expense) {
    _isAddButtonVisible.add(false);
    _scrollDown();
  }

  Widget card(
      BuildContext context, ThemeData theme, ExpenseDetailsEntity expense) {
    return Card(
      elevation: 2.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: _cardItem(expense, theme),
    );
  }

  _cardItem(ExpenseDetailsEntity expense, ThemeData theme) {
    return ListTile(
      contentPadding: const EdgeInsets.all(16),
      leading: Icon(Icons.shopping_cart, color: theme.colorScheme.primary),
      title: Text(
        expense.name,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: _trailingItem(expense.price, expense.id, theme),
    );
  }

  _trailingItem(int price, int id, ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          price.toString(),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline_outlined),
          onPressed: () {
            _bloc.add(DeleteExpense(id: id));
            _bloc.add(FetchExpenseEvent(date: widget.dateTime));
          },
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
                ? GradientButton(
                    text: 'Add more...',
                    onPressed: () {
                      _isAddButtonVisible.add(false);
                      _scrollDown();
                    },
                    gradientColors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.tertiaryFixed
                    ],
                  )
                : _addNewExpenseForm(),
          ],
        );
      },
    );
  }

  void _scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 220.0,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _addNewExpenseForm() {
    return Column(
      children: [
        CustomTextField(
            labelText: "Description",
            controller: title,
            keyboardType: TextInputType.text),
        CustomTextField(
          labelText: "Price",
          controller: price,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
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
    return GradientButton(
      text: 'Save',
      onPressed: () {
        _isAddButtonVisible.add(true);
        _bloc.add(AddNewExpense(
          description: title.text,
          price: int.parse(price.text),
          dateTime: widget.dateTime,
        ));
        _bloc.add(FetchExpenseEvent(date: widget.dateTime));
        title.clear();
        price.clear();
      },
      gradientColors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.tertiaryFixed
      ], // Optional: custom gradient colors
    );
  }
}
