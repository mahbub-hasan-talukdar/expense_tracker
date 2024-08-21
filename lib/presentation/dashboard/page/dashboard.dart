import 'package:expense_tracker/presentation/dashboard/bloc/graph_bloc/graph_bloc.dart';
import 'package:expense_tracker/presentation/dashboard/bloc/graph_bloc/graph_event.dart';
import 'package:expense_tracker/presentation/dashboard/bloc/graph_bloc/graph_state.dart';
import 'package:expense_tracker/presentation/items_list/page/item_list_page.dart';
import 'package:expense_tracker/presentation/dashboard/widgets/my_bar_chart/bar_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utilities/utilities.dart';

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
  final BehaviorSubject<String> _currentDate =
      BehaviorSubject<String>.seeded(DateTime.now().formattedDate());

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
    _currentDate.close();
  }

  @override
  void initState() {
    super.initState();
    graphBloc.add(const GraphEvent(graphType: GraphType.daily));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: myAppBar(context),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Stack(
        children: [
          SizedBox(
            width: screenWidth - 30,
            child: ElevatedButton(
              onPressed: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (selectedDate != null) {
                  _currentDate.add(selectedDate.formattedDate());
                }
              },
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                elevation: const WidgetStatePropertyAll(5),
                minimumSize: WidgetStatePropertyAll(
                  Size(screenWidth, 75),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit_calendar_outlined,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  const SizedBox(width: 10),
                  StreamBuilder<String>(
                    stream: _currentDate,
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.data ?? 'select a date',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: BlocBuilder<GraphBloc, GraphState>(
                    bloc: graphBloc,
                    builder: (context, state) {
                      if (state is GraphStateSuccess) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                3,
                                (index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: _selectGraph(
                                      index,
                                      state.graphType,
                                      context,
                                    ),
                                  );
                                },
                              ),
                            ),
                            BarList(
                              items: state.itemList,
                              graphType: state.graphType,
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
                ),
              ),
              const SizedBox(height: 10),
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
                  'See expense list',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _selectGraph(
    int index,
    GraphType selectedType,
    BuildContext context,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenWidth * .05,
      width: screenWidth * .25,
      child: ElevatedButton(
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
            fontSize: screenWidth * .025,
          ),
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
}
