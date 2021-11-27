import 'package:equatable/equatable.dart';

abstract class TodoUpdateEvent extends Equatable {
  const TodoUpdateEvent();
  @override
  List<Object?> get props => [];
}

class TodoUpdateStatusEvent extends TodoUpdateEvent {}
