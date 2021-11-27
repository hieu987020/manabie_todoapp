import 'package:equatable/equatable.dart';

abstract class TodoCreateState extends Equatable {
  const TodoCreateState();
  @override
  List<Object?> get props => [];
}

class TodoCreateInitialState extends TodoCreateState {}

class TodoCreateLoaded extends TodoCreateState {}

class TodoCreateLoading extends TodoCreateState {}

class TodoCreateError extends TodoCreateState {}

class TodoCreateShowNotification extends TodoCreateState {}
