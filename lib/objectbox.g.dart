// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/todo.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 27809188797693798),
      name: 'Todo',
      lastPropertyId: const IdUid(4, 12490531379472180),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1372452643035728050),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4718464643435510912),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 11256728733807096),
            name: 'detail',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 12490531379472180),
            name: 'status',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 27809188797693798),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Todo: EntityDefinition<Todo>(
        model: _entities[0],
        toOneRelations: (Todo object) => [],
        toManyRelations: (Todo object) => {},
        getId: (Todo object) => object.id,
        setId: (Todo object, int id) {
          object.id = id;
        },
        objectToFB: (Todo object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final detailOffset =
              object.detail == null ? null : fbb.writeString(object.detail!);
          final statusOffset = fbb.writeString(object.status);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, detailOffset);
          fbb.addOffset(3, statusOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Todo(
              name:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 6, ''),
              detail: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              status:
                  const fb.StringReader().vTableGet(buffer, rootOffset, 10, ''))
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Todo] entity fields to define ObjectBox queries.
class Todo_ {
  /// see [Todo.id]
  static final id = QueryIntegerProperty<Todo>(_entities[0].properties[0]);

  /// see [Todo.name]
  static final name = QueryStringProperty<Todo>(_entities[0].properties[1]);

  /// see [Todo.detail]
  static final detail = QueryStringProperty<Todo>(_entities[0].properties[2]);

  /// see [Todo.status]
  static final status = QueryStringProperty<Todo>(_entities[0].properties[3]);
}
