/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:wuri_server/src/generated/protocol.dart' as _ig0ersr1;
import 'space_type.dart' as _iycu1zrq;

abstract class Space implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Space._({
    this.id,
    required this.ownerId,
    required this.name,
    required this.type,
    required this.description,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.pricePerNight,
    required this.currency,
    required this.maxGuests,
    required this.photoUrls,
    required this.isActive,
    required this.createdAt,
  });

  factory Space({
    int? id,
    required int ownerId,
    required String name,
    required _iycu1zrq.SpaceType type,
    required String description,
    required String city,
    required double latitude,
    required double longitude,
    required int pricePerNight,
    required String currency,
    required int maxGuests,
    required List<String> photoUrls,
    required bool isActive,
    required DateTime createdAt,
  }) = _SpaceImpl;

  factory Space.fromJson(Map<String, dynamic> jsonSerialization) {
    return Space(
      id: jsonSerialization['id'] as int?,
      ownerId: jsonSerialization['ownerId'] as int,
      name: jsonSerialization['name'] as String,
      type: _iycu1zrq.SpaceType.fromJson((jsonSerialization['type'] as String)),
      description: jsonSerialization['description'] as String,
      city: jsonSerialization['city'] as String,
      latitude: (jsonSerialization['latitude'] as num).toDouble(),
      longitude: (jsonSerialization['longitude'] as num).toDouble(),
      pricePerNight: jsonSerialization['pricePerNight'] as int,
      currency: jsonSerialization['currency'] as String,
      maxGuests: jsonSerialization['maxGuests'] as int,
      photoUrls: _ig0ersr1.Protocol().deserialize<List<String>>(
        jsonSerialization['photoUrls'],
      ),
      isActive: _is.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = SpaceTable();

  static const db = SpaceRepository._();

  @override
  int? id;

  int ownerId;

  String name;

  _iycu1zrq.SpaceType type;

  String description;

  String city;

  double latitude;

  double longitude;

  int pricePerNight;

  String currency;

  int maxGuests;

  List<String> photoUrls;

  bool isActive;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Space]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Space copyWith({
    int? id,
    int? ownerId,
    String? name,
    _iycu1zrq.SpaceType? type,
    String? description,
    String? city,
    double? latitude,
    double? longitude,
    int? pricePerNight,
    String? currency,
    int? maxGuests,
    List<String>? photoUrls,
    bool? isActive,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Space',
      if (id != null) 'id': id,
      'ownerId': ownerId,
      'name': name,
      'type': type.toJson(),
      'description': description,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'pricePerNight': pricePerNight,
      'currency': currency,
      'maxGuests': maxGuests,
      'photoUrls': photoUrls.toJson(),
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Space',
      if (id != null) 'id': id,
      'ownerId': ownerId,
      'name': name,
      'type': type.toJson(),
      'description': description,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'pricePerNight': pricePerNight,
      'currency': currency,
      'maxGuests': maxGuests,
      'photoUrls': photoUrls.toJson(),
      'isActive': isActive,
      'createdAt': createdAt.toJson(),
    };
  }

  static SpaceInclude include() {
    return SpaceInclude._();
  }

  static SpaceIncludeList includeList({
    _is.WhereExpressionBuilder<SpaceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SpaceTable>? orderBy,
    _is.OrderByListBuilder<SpaceTable>? orderByList,
    SpaceInclude? include,
  }) {
    return SpaceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Space.t),
      orderByList: orderByList?.call(Space.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpaceImpl extends Space {
  _SpaceImpl({
    int? id,
    required int ownerId,
    required String name,
    required _iycu1zrq.SpaceType type,
    required String description,
    required String city,
    required double latitude,
    required double longitude,
    required int pricePerNight,
    required String currency,
    required int maxGuests,
    required List<String> photoUrls,
    required bool isActive,
    required DateTime createdAt,
  }) : super._(
         id: id,
         ownerId: ownerId,
         name: name,
         type: type,
         description: description,
         city: city,
         latitude: latitude,
         longitude: longitude,
         pricePerNight: pricePerNight,
         currency: currency,
         maxGuests: maxGuests,
         photoUrls: photoUrls,
         isActive: isActive,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Space]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Space copyWith({
    Object? id = _Undefined,
    int? ownerId,
    String? name,
    _iycu1zrq.SpaceType? type,
    String? description,
    String? city,
    double? latitude,
    double? longitude,
    int? pricePerNight,
    String? currency,
    int? maxGuests,
    List<String>? photoUrls,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Space(
      id: id is int? ? id : this.id,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      type: type ?? this.type,
      description: description ?? this.description,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      pricePerNight: pricePerNight ?? this.pricePerNight,
      currency: currency ?? this.currency,
      maxGuests: maxGuests ?? this.maxGuests,
      photoUrls: photoUrls ?? this.photoUrls.map((e0) => e0).toList(),
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class SpaceUpdateTable extends _is.UpdateTable<SpaceTable> {
  SpaceUpdateTable(super.table);

  _is.ColumnValue<int, int> ownerId(int value) => _is.ColumnValue(
    table.ownerId,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<_iycu1zrq.SpaceType, _iycu1zrq.SpaceType> type(
    _iycu1zrq.SpaceType value,
  ) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<String, String> description(String value) => _is.ColumnValue(
    table.description,
    value,
  );

  _is.ColumnValue<String, String> city(String value) => _is.ColumnValue(
    table.city,
    value,
  );

  _is.ColumnValue<double, double> latitude(double value) => _is.ColumnValue(
    table.latitude,
    value,
  );

  _is.ColumnValue<double, double> longitude(double value) => _is.ColumnValue(
    table.longitude,
    value,
  );

  _is.ColumnValue<int, int> pricePerNight(int value) => _is.ColumnValue(
    table.pricePerNight,
    value,
  );

  _is.ColumnValue<String, String> currency(String value) => _is.ColumnValue(
    table.currency,
    value,
  );

  _is.ColumnValue<int, int> maxGuests(int value) => _is.ColumnValue(
    table.maxGuests,
    value,
  );

  _is.ColumnValue<List<String>, List<String>> photoUrls(List<String> value) =>
      _is.ColumnValue(
        table.photoUrls,
        value,
      );

  _is.ColumnValue<bool, bool> isActive(bool value) => _is.ColumnValue(
    table.isActive,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class SpaceTable extends _is.Table<int?> {
  SpaceTable({super.tableRelation}) : super(tableName: 'space') {
    updateTable = SpaceUpdateTable(this);
    ownerId = _is.ColumnInt(
      'ownerId',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    type = _is.ColumnEnum(
      'type',
      this,
      _is.EnumSerialization.byName,
    );
    description = _is.ColumnString(
      'description',
      this,
    );
    city = _is.ColumnString(
      'city',
      this,
    );
    latitude = _is.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _is.ColumnDouble(
      'longitude',
      this,
    );
    pricePerNight = _is.ColumnInt(
      'pricePerNight',
      this,
    );
    currency = _is.ColumnString(
      'currency',
      this,
    );
    maxGuests = _is.ColumnInt(
      'maxGuests',
      this,
    );
    photoUrls = _is.ColumnSerializable<List<String>>(
      'photoUrls',
      this,
    );
    isActive = _is.ColumnBool(
      'isActive',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final SpaceUpdateTable updateTable;

  late final _is.ColumnInt ownerId;

  late final _is.ColumnString name;

  late final _is.ColumnEnum<_iycu1zrq.SpaceType> type;

  late final _is.ColumnString description;

  late final _is.ColumnString city;

  late final _is.ColumnDouble latitude;

  late final _is.ColumnDouble longitude;

  late final _is.ColumnInt pricePerNight;

  late final _is.ColumnString currency;

  late final _is.ColumnInt maxGuests;

  late final _is.ColumnSerializable<List<String>> photoUrls;

  late final _is.ColumnBool isActive;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    ownerId,
    name,
    type,
    description,
    city,
    latitude,
    longitude,
    pricePerNight,
    currency,
    maxGuests,
    photoUrls,
    isActive,
    createdAt,
  ];
}

class SpaceInclude extends _is.IncludeObject {
  SpaceInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Space.t;
}

class SpaceIncludeList extends _is.IncludeList {
  SpaceIncludeList._({
    _is.WhereExpressionBuilder<SpaceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Space.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Space.t;
}

class SpaceRepository {
  const SpaceRepository._();

  /// Returns a list of [Space]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Space>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SpaceTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SpaceTable>? orderBy,
    _is.OrderByListBuilder<SpaceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Space>(
      where: where?.call(Space.t),
      orderBy: orderBy?.call(Space.t),
      orderByList: orderByList?.call(Space.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Space] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Space?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SpaceTable>? where,
    int? offset,
    _is.OrderByBuilder<SpaceTable>? orderBy,
    _is.OrderByListBuilder<SpaceTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Space>(
      where: where?.call(Space.t),
      orderBy: orderBy?.call(Space.t),
      orderByList: orderByList?.call(Space.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Space] by its [id] or null if no such row exists.
  Future<Space?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Space>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Space]s in the list and returns the inserted rows.
  ///
  /// The returned [Space]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Space>> insert(
    _is.DatabaseSession session,
    List<Space> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Space>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Space] and returns the inserted row.
  ///
  /// The returned [Space] will have its `id` field set.
  Future<Space> insertRow(
    _is.DatabaseSession session,
    Space row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Space>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Space]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Space]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Space>> upsert(
    _is.DatabaseSession session,
    List<Space> rows, {
    required _is.ColumnSelections<SpaceTable> conflictColumns,
    _is.ColumnSelections<SpaceTable>? updateColumns,
    _is.WhereExpressionBuilder<SpaceTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Space>(
      rows,
      conflictColumns: conflictColumns(Space.t),
      updateColumns: updateColumns?.call(Space.t),
      updateWhere: updateWhere?.call(Space.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Space] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Space] will have its `id` field set.
  Future<Space?> upsertRow(
    _is.DatabaseSession session,
    Space row, {
    required _is.ColumnSelections<SpaceTable> conflictColumns,
    _is.ColumnSelections<SpaceTable>? updateColumns,
    _is.WhereExpressionBuilder<SpaceTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Space>(
      row,
      conflictColumns: conflictColumns(Space.t),
      updateColumns: updateColumns?.call(Space.t),
      updateWhere: updateWhere?.call(Space.t),
      transaction: transaction,
    );
  }

  /// Updates all [Space]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Space>> update(
    _is.DatabaseSession session,
    List<Space> rows, {
    _is.ColumnSelections<SpaceTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Space>(
      rows,
      columns: columns?.call(Space.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Space]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Space> updateRow(
    _is.DatabaseSession session,
    Space row, {
    _is.ColumnSelections<SpaceTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Space>(
      row,
      columns: columns?.call(Space.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Space] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Space?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SpaceUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Space>(
      id,
      columnValues: columnValues(Space.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Space]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Space>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SpaceUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SpaceTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SpaceTable>? orderBy,
    _is.OrderByListBuilder<SpaceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Space>(
      columnValues: columnValues(Space.t.updateTable),
      where: where(Space.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Space.t),
      orderByList: orderByList?.call(Space.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Space]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Space>> delete(
    _is.DatabaseSession session,
    List<Space> rows, {
    _is.OrderByBuilder<SpaceTable>? orderBy,
    _is.OrderByListBuilder<SpaceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Space>(
      rows,
      orderBy: orderBy?.call(Space.t),
      orderByList: orderByList?.call(Space.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Space].
  Future<Space> deleteRow(
    _is.DatabaseSession session,
    Space row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Space>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Space>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SpaceTable> where,
    _is.OrderByBuilder<SpaceTable>? orderBy,
    _is.OrderByListBuilder<SpaceTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Space>(
      where: where(Space.t),
      orderBy: orderBy?.call(Space.t),
      orderByList: orderByList?.call(Space.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SpaceTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Space>(
      where: where?.call(Space.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Space] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SpaceTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Space>(
      where: where(Space.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
