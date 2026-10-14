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
import 'space_type.dart' as _iycu1zrq;
import 'status.dart' as _ihjssg7m;

abstract class PartnerApplication
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PartnerApplication._({
    this.id,
    required this.appUserId,
    required this.businessName,
    required this.businessType,
    required this.city,
    required this.address,
    required this.registrationNumber,
    this.documentPath,
    required this.status,
    this.rejectionReason,
    required this.createdAt,
    this.reviewedAt,
  });

  factory PartnerApplication({
    int? id,
    required int appUserId,
    required String businessName,
    required _iycu1zrq.SpaceType businessType,
    required String city,
    required String address,
    required String registrationNumber,
    String? documentPath,
    required _ihjssg7m.ApplicationStatus status,
    String? rejectionReason,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) = _PartnerApplicationImpl;

  factory PartnerApplication.fromJson(Map<String, dynamic> jsonSerialization) {
    return PartnerApplication(
      id: jsonSerialization['id'] as int?,
      appUserId: jsonSerialization['appUserId'] as int,
      businessName: jsonSerialization['businessName'] as String,
      businessType: _iycu1zrq.SpaceType.fromJson(
        (jsonSerialization['businessType'] as String),
      ),
      city: jsonSerialization['city'] as String,
      address: jsonSerialization['address'] as String,
      registrationNumber: jsonSerialization['registrationNumber'] as String,
      documentPath: jsonSerialization['documentPath'] as String?,
      status: _ihjssg7m.ApplicationStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      rejectionReason: jsonSerialization['rejectionReason'] as String?,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
    );
  }

  static final t = PartnerApplicationTable();

  static const db = PartnerApplicationRepository._();

  @override
  int? id;

  int appUserId;

  String businessName;

  _iycu1zrq.SpaceType businessType;

  String city;

  String address;

  String registrationNumber;

  String? documentPath;

  _ihjssg7m.ApplicationStatus status;

  String? rejectionReason;

  DateTime createdAt;

  DateTime? reviewedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PartnerApplication]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PartnerApplication copyWith({
    int? id,
    int? appUserId,
    String? businessName,
    _iycu1zrq.SpaceType? businessType,
    String? city,
    String? address,
    String? registrationNumber,
    String? documentPath,
    _ihjssg7m.ApplicationStatus? status,
    String? rejectionReason,
    DateTime? createdAt,
    DateTime? reviewedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PartnerApplication',
      if (id != null) 'id': id,
      'appUserId': appUserId,
      'businessName': businessName,
      'businessType': businessType.toJson(),
      'city': city,
      'address': address,
      'registrationNumber': registrationNumber,
      if (documentPath != null) 'documentPath': documentPath,
      'status': status.toJson(),
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PartnerApplication',
      if (id != null) 'id': id,
      'appUserId': appUserId,
      'businessName': businessName,
      'businessType': businessType.toJson(),
      'city': city,
      'address': address,
      'registrationNumber': registrationNumber,
      if (documentPath != null) 'documentPath': documentPath,
      'status': status.toJson(),
      if (rejectionReason != null) 'rejectionReason': rejectionReason,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  static PartnerApplicationInclude include() {
    return PartnerApplicationInclude._();
  }

  static PartnerApplicationIncludeList includeList({
    _is.WhereExpressionBuilder<PartnerApplicationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerApplicationTable>? orderBy,
    _is.OrderByListBuilder<PartnerApplicationTable>? orderByList,
    PartnerApplicationInclude? include,
  }) {
    return PartnerApplicationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerApplication.t),
      orderByList: orderByList?.call(PartnerApplication.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartnerApplicationImpl extends PartnerApplication {
  _PartnerApplicationImpl({
    int? id,
    required int appUserId,
    required String businessName,
    required _iycu1zrq.SpaceType businessType,
    required String city,
    required String address,
    required String registrationNumber,
    String? documentPath,
    required _ihjssg7m.ApplicationStatus status,
    String? rejectionReason,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) : super._(
         id: id,
         appUserId: appUserId,
         businessName: businessName,
         businessType: businessType,
         city: city,
         address: address,
         registrationNumber: registrationNumber,
         documentPath: documentPath,
         status: status,
         rejectionReason: rejectionReason,
         createdAt: createdAt,
         reviewedAt: reviewedAt,
       );

  /// Returns a shallow copy of this [PartnerApplication]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PartnerApplication copyWith({
    Object? id = _Undefined,
    int? appUserId,
    String? businessName,
    _iycu1zrq.SpaceType? businessType,
    String? city,
    String? address,
    String? registrationNumber,
    Object? documentPath = _Undefined,
    _ihjssg7m.ApplicationStatus? status,
    Object? rejectionReason = _Undefined,
    DateTime? createdAt,
    Object? reviewedAt = _Undefined,
  }) {
    return PartnerApplication(
      id: id is int? ? id : this.id,
      appUserId: appUserId ?? this.appUserId,
      businessName: businessName ?? this.businessName,
      businessType: businessType ?? this.businessType,
      city: city ?? this.city,
      address: address ?? this.address,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      documentPath: documentPath is String? ? documentPath : this.documentPath,
      status: status ?? this.status,
      rejectionReason: rejectionReason is String?
          ? rejectionReason
          : this.rejectionReason,
      createdAt: createdAt ?? this.createdAt,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
    );
  }
}

class PartnerApplicationUpdateTable
    extends _is.UpdateTable<PartnerApplicationTable> {
  PartnerApplicationUpdateTable(super.table);

  _is.ColumnValue<int, int> appUserId(int value) => _is.ColumnValue(
    table.appUserId,
    value,
  );

  _is.ColumnValue<String, String> businessName(String value) => _is.ColumnValue(
    table.businessName,
    value,
  );

  _is.ColumnValue<_iycu1zrq.SpaceType, _iycu1zrq.SpaceType> businessType(
    _iycu1zrq.SpaceType value,
  ) => _is.ColumnValue(
    table.businessType,
    value,
  );

  _is.ColumnValue<String, String> city(String value) => _is.ColumnValue(
    table.city,
    value,
  );

  _is.ColumnValue<String, String> address(String value) => _is.ColumnValue(
    table.address,
    value,
  );

  _is.ColumnValue<String, String> registrationNumber(String value) =>
      _is.ColumnValue(
        table.registrationNumber,
        value,
      );

  _is.ColumnValue<String, String> documentPath(String? value) =>
      _is.ColumnValue(
        table.documentPath,
        value,
      );

  _is.ColumnValue<_ihjssg7m.ApplicationStatus, _ihjssg7m.ApplicationStatus>
  status(_ihjssg7m.ApplicationStatus value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> rejectionReason(String? value) =>
      _is.ColumnValue(
        table.rejectionReason,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> reviewedAt(DateTime? value) =>
      _is.ColumnValue(
        table.reviewedAt,
        value,
      );
}

class PartnerApplicationTable extends _is.Table<int?> {
  PartnerApplicationTable({super.tableRelation})
    : super(tableName: 'partner_application') {
    updateTable = PartnerApplicationUpdateTable(this);
    appUserId = _is.ColumnInt(
      'appUserId',
      this,
    );
    businessName = _is.ColumnString(
      'businessName',
      this,
    );
    businessType = _is.ColumnEnum(
      'businessType',
      this,
      _is.EnumSerialization.byName,
    );
    city = _is.ColumnString(
      'city',
      this,
    );
    address = _is.ColumnString(
      'address',
      this,
    );
    registrationNumber = _is.ColumnString(
      'registrationNumber',
      this,
    );
    documentPath = _is.ColumnString(
      'documentPath',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    rejectionReason = _is.ColumnString(
      'rejectionReason',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    reviewedAt = _is.ColumnDateTime(
      'reviewedAt',
      this,
    );
  }

  late final PartnerApplicationUpdateTable updateTable;

  late final _is.ColumnInt appUserId;

  late final _is.ColumnString businessName;

  late final _is.ColumnEnum<_iycu1zrq.SpaceType> businessType;

  late final _is.ColumnString city;

  late final _is.ColumnString address;

  late final _is.ColumnString registrationNumber;

  late final _is.ColumnString documentPath;

  late final _is.ColumnEnum<_ihjssg7m.ApplicationStatus> status;

  late final _is.ColumnString rejectionReason;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime reviewedAt;

  @override
  List<_is.Column> get columns => [
    id,
    appUserId,
    businessName,
    businessType,
    city,
    address,
    registrationNumber,
    documentPath,
    status,
    rejectionReason,
    createdAt,
    reviewedAt,
  ];
}

class PartnerApplicationInclude extends _is.IncludeObject {
  PartnerApplicationInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PartnerApplication.t;
}

class PartnerApplicationIncludeList extends _is.IncludeList {
  PartnerApplicationIncludeList._({
    _is.WhereExpressionBuilder<PartnerApplicationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PartnerApplication.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PartnerApplication.t;
}

class PartnerApplicationRepository {
  const PartnerApplicationRepository._();

  /// Returns a list of [PartnerApplication]s matching the given query parameters.
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
  Future<List<PartnerApplication>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerApplicationTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerApplicationTable>? orderBy,
    _is.OrderByListBuilder<PartnerApplicationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PartnerApplication>(
      where: where?.call(PartnerApplication.t),
      orderBy: orderBy?.call(PartnerApplication.t),
      orderByList: orderByList?.call(PartnerApplication.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [PartnerApplication] matching the given query parameters.
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
  Future<PartnerApplication?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerApplicationTable>? where,
    int? offset,
    _is.OrderByBuilder<PartnerApplicationTable>? orderBy,
    _is.OrderByListBuilder<PartnerApplicationTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PartnerApplication>(
      where: where?.call(PartnerApplication.t),
      orderBy: orderBy?.call(PartnerApplication.t),
      orderByList: orderByList?.call(PartnerApplication.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PartnerApplication] by its [id] or null if no such row exists.
  Future<PartnerApplication?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PartnerApplication>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PartnerApplication]s in the list and returns the inserted rows.
  ///
  /// The returned [PartnerApplication]s will have their `id` fields set.
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
  Future<List<PartnerApplication>> insert(
    _is.DatabaseSession session,
    List<PartnerApplication> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PartnerApplication>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PartnerApplication] and returns the inserted row.
  ///
  /// The returned [PartnerApplication] will have its `id` field set.
  Future<PartnerApplication> insertRow(
    _is.DatabaseSession session,
    PartnerApplication row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PartnerApplication>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PartnerApplication]s in the list and returns the resulting rows.
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
  /// The returned [PartnerApplication]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerApplication>> upsert(
    _is.DatabaseSession session,
    List<PartnerApplication> rows, {
    required _is.ColumnSelections<PartnerApplicationTable> conflictColumns,
    _is.ColumnSelections<PartnerApplicationTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerApplicationTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PartnerApplication>(
      rows,
      conflictColumns: conflictColumns(PartnerApplication.t),
      updateColumns: updateColumns?.call(PartnerApplication.t),
      updateWhere: updateWhere?.call(PartnerApplication.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PartnerApplication] and returns the resulting row.
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
  /// The returned [PartnerApplication] will have its `id` field set.
  Future<PartnerApplication?> upsertRow(
    _is.DatabaseSession session,
    PartnerApplication row, {
    required _is.ColumnSelections<PartnerApplicationTable> conflictColumns,
    _is.ColumnSelections<PartnerApplicationTable>? updateColumns,
    _is.WhereExpressionBuilder<PartnerApplicationTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PartnerApplication>(
      row,
      conflictColumns: conflictColumns(PartnerApplication.t),
      updateColumns: updateColumns?.call(PartnerApplication.t),
      updateWhere: updateWhere?.call(PartnerApplication.t),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerApplication]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerApplication>> update(
    _is.DatabaseSession session,
    List<PartnerApplication> rows, {
    _is.ColumnSelections<PartnerApplicationTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PartnerApplication>(
      rows,
      columns: columns?.call(PartnerApplication.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PartnerApplication]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PartnerApplication> updateRow(
    _is.DatabaseSession session,
    PartnerApplication row, {
    _is.ColumnSelections<PartnerApplicationTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PartnerApplication>(
      row,
      columns: columns?.call(PartnerApplication.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PartnerApplication] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PartnerApplication?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PartnerApplicationUpdateTable>
    columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PartnerApplication>(
      id,
      columnValues: columnValues(PartnerApplication.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PartnerApplication]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PartnerApplication>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PartnerApplicationUpdateTable>
    columnValues,
    required _is.WhereExpressionBuilder<PartnerApplicationTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PartnerApplicationTable>? orderBy,
    _is.OrderByListBuilder<PartnerApplicationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PartnerApplication>(
      columnValues: columnValues(PartnerApplication.t.updateTable),
      where: where(PartnerApplication.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PartnerApplication.t),
      orderByList: orderByList?.call(PartnerApplication.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PartnerApplication]s in the list and returns the deleted rows.
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
  Future<List<PartnerApplication>> delete(
    _is.DatabaseSession session,
    List<PartnerApplication> rows, {
    _is.OrderByBuilder<PartnerApplicationTable>? orderBy,
    _is.OrderByListBuilder<PartnerApplicationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PartnerApplication>(
      rows,
      orderBy: orderBy?.call(PartnerApplication.t),
      orderByList: orderByList?.call(PartnerApplication.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PartnerApplication].
  Future<PartnerApplication> deleteRow(
    _is.DatabaseSession session,
    PartnerApplication row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PartnerApplication>(
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
  Future<List<PartnerApplication>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerApplicationTable> where,
    _is.OrderByBuilder<PartnerApplicationTable>? orderBy,
    _is.OrderByListBuilder<PartnerApplicationTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PartnerApplication>(
      where: where(PartnerApplication.t),
      orderBy: orderBy?.call(PartnerApplication.t),
      orderByList: orderByList?.call(PartnerApplication.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PartnerApplicationTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PartnerApplication>(
      where: where?.call(PartnerApplication.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PartnerApplication] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PartnerApplicationTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PartnerApplication>(
      where: where(PartnerApplication.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
