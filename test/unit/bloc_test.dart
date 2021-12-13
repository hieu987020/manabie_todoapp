import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manabie_todoapp/data/data.dart';
import 'package:manabie_todoapp/domain/bloc/blocs.dart';

void main() async {
  group('TodoBloc', () {
    blocTest(
      'emits [] when nothing is added',
      build: () => TodoBloc(),
      expect: () => [],
    );
    blocTest(
      'emits [] when nothing is added',
      build: () => TodoBloc(),
      expect: () => [],
    );
    // blocTest(
    //   'emits [1] when Increment is added',
    //   build: () => TodoBloc(),
    //   act: (bloc) =>
    //       TodoBloc().add(TodoFetchEvent(objectBox: objectbox, status: '')),
    //   expect: () {
    //     // expectLater(actual, matcher)
    //     emitsInOrder([isA<TodoFetchSuccess>()]);
    //   },
    // );
  });
}
