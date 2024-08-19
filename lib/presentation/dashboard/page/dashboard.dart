import 'package:expense_tracker/presentation/dashboard/bloc/add_expense_bloc/add_expense_bloc.dart';
import 'package:expense_tracker/presentation/dashboard/bloc/add_expense_bloc/add_expense_event.dart';
import 'package:expense_tracker/presentation/dashboard/bloc/graph_bloc/graph_bloc.dart';
import 'package:expense_tracker/presentation/dashboard/bloc/graph_bloc/graph_event.dart';
import 'package:expense_tracker/presentation/dashboard/bloc/graph_bloc/graph_state.dart';
import 'package:expense_tracker/presentation/dashboard/widgets/add_expense/add_expense_page.dart';
import 'package:expense_tracker/presentation/items_list/page/item_list_page.dart';
import 'package:expense_tracker/presentation/dashboard/widgets/my_bar_chart/bar_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/add_expense_bloc/add_expense_state.dart';

enum GraphType { daily, monthly, yearly }

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });
  static const String path = 'dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GraphBloc graphBloc = GraphBloc();
  final AddExpenseBloc addExpenseBloc = AddExpenseBloc();
  DateTime selectedDate = DateTime.now();

  final List<GraphType> graphType = [
    GraphType.daily,
    GraphType.monthly,
    GraphType.yearly,
  ];
  @override
  void dispose() {
    super.dispose();
    graphBloc.close();
    addExpenseBloc.close();
  }

  @override
  void initState() {
    super.initState();
    graphBloc.add(const GraphEvent(graphType: GraphType.daily));
    addExpenseBloc.add(CalendarEvent(dateTime: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              BlocBuilder<GraphBloc, GraphState>(
                bloc: graphBloc,
                builder: (context, state) {
                  if (state is GraphStateSuccess) {
                    return Column(
                      children: [
                        BarList(
                          items: state.itemList,
                          graphType: state.graphType,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            3,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _selectGraph(
                                  index,
                                  state.graphType,
                                  context,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (state is GraphStateFailed) {
                    return Text(state.errorMessage);
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
              TextButton(
                onPressed: () {
                  context.push(
                    '/${ItemListPage.path}',
                  );
                },
                style: ButtonStyle(
                  minimumSize: const WidgetStatePropertyAll(
                    Size(double.infinity, 15),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
                child: Text(
                  'See expenses list',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/${AddExpensePage.path}');
                },
                child: Text('add expense'),
              ),
              // AddExpensePage(),
              BlocBuilder<AddExpenseBloc, AddExpenseState>(
                bloc: addExpenseBloc,
                builder: (context, state) {
                  if (state is CalendarState) {
                    return TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        hintText: state.dateTime.toString().split(' ')[0],
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      onTap: _pickDate,
                    );
                  } else {
                    return Text('Something went wrong');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _selectGraph(
    int index,
    GraphType selectedType,
    BuildContext context,
  ) {
    return ElevatedButton(
      onPressed: () {
        graphBloc.add(
          GraphEvent(
            graphType: graphType[index],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedType == graphType[index]
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
      ),
      child: Text(
        () {
          switch (index) {
            case 0:
              return 'Daily';
            case 1:
              return 'Monthly';
            default:
              return 'Yearly';
          }
        }(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      addExpenseBloc.add(CalendarEvent(dateTime: pickedDate));
    }
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
}
