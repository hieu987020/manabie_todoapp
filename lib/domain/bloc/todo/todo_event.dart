import 'package:equatable/equatable.dart';
import 'package:manabie_todoapp/data/helper.dart';

class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TodoFetchEvent extends TodoEvent {
  TodoFetchEvent({required this.status, required this.objectBox});
  final String status;
  final ObjectBox objectBox;
}
