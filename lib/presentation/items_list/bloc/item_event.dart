import 'package:equatable/equatable.dart';


class ItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialFetchEvent extends ItemEvent {}

// class ReportTypeEvent extends ItemEvent {
//   final GraphType type;
//   final List<ItemEntity>? list;
//   ReportTypeEvent({
//     required this.type,
//     required this.list,
//   });
//   @override
//   List<Object?> get props => [type, list];
// }
