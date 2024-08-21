import 'package:equatable/equatable.dart';

import '../../page/dashboard.dart';

class GraphEvent extends Equatable {
  final GraphType graphType;
  const GraphEvent({
    required this.graphType,
  });
  @override
  List<Object?> get props => [graphType];
}
