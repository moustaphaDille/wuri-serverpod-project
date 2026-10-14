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
import 'booking_status.dart' as _ifekp8p0;
import 'payment_method.dart' as _imotz5ce;

abstract class Booking
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Booking._({
    this.id,
    required this.placeId,
    required this.guestId,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.totalPrice,
    required this.currency,
    required this.status,
    required this.paymentMethod,
    required this.createdAt,
  });

  factory Booking({
    int? id,
    required int placeId,
    required int guestId,
    required DateTime checkIn,
    required DateTime checkOut,
    required int guests,
    required int totalPrice,
    required String currency,
    required _ifekp8p0.BookingStatus status,
    required _imotz5ce.PaymentMethod paymentMethod,
    required DateTime createdAt,
  }) = _BookingImpl;

  factory Booking.fromJson(Map<String, dynamic> jsonSerialization) {
    return Booking(
      id: jsonSerialization['id'] as int?,
      placeId: jsonSerialization['placeId'] as int,
      guestId: jsonSerialization['guestId'] as int,
      checkIn: _is.DateTimeJsonExtension.fromJson(jsonSerialization['checkIn']),
      checkOut: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['checkOut'],
      ),
      guests: jsonSerialization['guests'] as int,
      totalPrice: jsonSerialization['totalPrice'] as int,
      currency: jsonSerialization['currency'] as String,
      status: _ifekp8p0.BookingStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      paymentMethod: _imotz5ce.PaymentMethod.fromJson(
        (jsonSerialization['paymentMethod'] as String),
      ),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = BookingTable();

  static const db = BookingRepository._();

  @override
  int? id;

  int placeId;

  int guestId;

  DateTime checkIn;

  DateTime checkOut;

  int guests;

  int totalPrice;

  String currency;

  _ifekp8p0.BookingStatus status;

  _imotz5ce.PaymentMethod paymentMethod;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Booking copyWith({
    int? id,
    int? placeId,
    int? guestId,
    DateTime? checkIn,
    DateTime? checkOut,
    int? guests,
    int? totalPrice,
    String? currency,
    _ifekp8p0.BookingStatus? status,
    _imotz5ce.PaymentMethod? paymentMethod,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Booking',
      if (id != null) 'id': id,
      'placeId': placeId,
      'guestId': guestId,
      'checkIn': checkIn.toJson(),
      'checkOut': checkOut.toJson(),
      'guests': guests,
      'totalPrice': totalPrice,
      'currency': currency,
      'status': status.toJson(),
      'paymentMethod': paymentMethod.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Booking',
      if (id != null) 'id': id,
      'placeId': placeId,
      'guestId': guestId,
      'checkIn': checkIn.toJson(),
      'checkOut': checkOut.toJson(),
      'guests': guests,
      'totalPrice': totalPrice,
      'currency': currency,
      'status': status.toJson(),
      'paymentMethod': paymentMethod.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static BookingInclude include() {
    return BookingInclude._();
  }

  static BookingIncludeList includeList({
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    BookingInclude? include,
  }) {
    return BookingIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookingImpl extends Booking {
  _BookingImpl({
    int? id,
    required int placeId,
    required int guestId,
    required DateTime checkIn,
    required DateTime checkOut,
    required int guests,
    required int totalPrice,
    required String currency,
    required _ifekp8p0.BookingStatus status,
    required _imotz5ce.PaymentMethod paymentMethod,
    required DateTime createdAt,
  }) : super._(
         id: id,
         placeId: placeId,
         guestId: guestId,
         checkIn: checkIn,
         checkOut: checkOut,
         guests: guests,
         totalPrice: totalPrice,
         currency: currency,
         status: status,
         paymentMethod: paymentMethod,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Booking copyWith({
    Object? id = _Undefined,
    int? placeId,
    int? guestId,
    DateTime? checkIn,
    DateTime? checkOut,
    int? guests,
    int? totalPrice,
    String? currency,
    _ifekp8p0.BookingStatus? status,
    _imotz5ce.PaymentMethod? paymentMethod,
    DateTime? createdAt,
  }) {
    return Booking(
      id: id is int? ? id : this.id,
      placeId: placeId ?? this.placeId,
      guestId: guestId ?? this.guestId,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      guests: guests ?? this.guests,
      totalPrice: totalPrice ?? this.totalPrice,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class BookingUpdateTable extends _is.UpdateTable<BookingTable> {
  BookingUpdateTable(super.table);

  _is.ColumnValue<int, int> placeId(int value) => _is.ColumnValue(
    table.placeId,
    value,
  );

  _is.ColumnValue<int, int> guestId(int value) => _is.ColumnValue(
    table.guestId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> checkIn(DateTime value) =>
      _is.ColumnValue(
        table.checkIn,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> checkOut(DateTime value) =>
      _is.ColumnValue(
        table.checkOut,
        value,
      );

  _is.ColumnValue<int, int> guests(int value) => _is.ColumnValue(
    table.guests,
    value,
  );

  _is.ColumnValue<int, int> totalPrice(int value) => _is.ColumnValue(
    table.totalPrice,
    value,
  );

  _is.ColumnValue<String, String> currency(String value) => _is.ColumnValue(
    table.currency,
    value,
  );

  _is.ColumnValue<_ifekp8p0.BookingStatus, _ifekp8p0.BookingStatus> status(
    _ifekp8p0.BookingStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<_imotz5ce.PaymentMethod, _imotz5ce.PaymentMethod>
  paymentMethod(_imotz5ce.PaymentMethod value) => _is.ColumnValue(
    table.paymentMethod,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class BookingTable extends _is.Table<int?> {
  BookingTable({super.tableRelation}) : super(tableName: 'booking') {
    updateTable = BookingUpdateTable(this);
    placeId = _is.ColumnInt(
      'placeId',
      this,
    );
    guestId = _is.ColumnInt(
      'guestId',
      this,
    );
    checkIn = _is.ColumnDateTime(
      'checkIn',
      this,
    );
    checkOut = _is.ColumnDateTime(
      'checkOut',
      this,
    );
    guests = _is.ColumnInt(
      'guests',
      this,
    );
    totalPrice = _is.ColumnInt(
      'totalPrice',
      this,
    );
    currency = _is.ColumnString(
      'currency',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
    );
    paymentMethod = _is.ColumnEnum(
      'paymentMethod',
      this,
      _is.EnumSerialization.byName,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final BookingUpdateTable updateTable;

  late final _is.ColumnInt placeId;

  late final _is.ColumnInt guestId;

  late final _is.ColumnDateTime checkIn;

  late final _is.ColumnDateTime checkOut;

  late final _is.ColumnInt guests;

  late final _is.ColumnInt totalPrice;

  late final _is.ColumnString currency;

  late final _is.ColumnEnum<_ifekp8p0.BookingStatus> status;

  late final _is.ColumnEnum<_imotz5ce.PaymentMethod> paymentMethod;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    placeId,
    guestId,
    checkIn,
    checkOut,
    guests,
    totalPrice,
    currency,
    status,
    paymentMethod,
    createdAt,
  ];
}

class BookingInclude extends _is.IncludeObject {
  BookingInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Booking.t;
}

class BookingIncludeList extends _is.IncludeList {
  BookingIncludeList._({
    _is.WhereExpressionBuilder<BookingTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Booking.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Booking.t;
}

class BookingRepository {
  const BookingRepository._();

  /// Returns a list of [Booking]s matching the given query parameters.
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
  Future<List<Booking>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Booking>(
      where: where?.call(Booking.t),
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Booking] matching the given query parameters.
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
  Future<Booking?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Booking>(
      where: where?.call(Booking.t),
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Booking] by its [id] or null if no such row exists.
  Future<Booking?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Booking>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Booking]s in the list and returns the inserted rows.
  ///
  /// The returned [Booking]s will have their `id` fields set.
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
  Future<List<Booking>> insert(
    _is.DatabaseSession session,
    List<Booking> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Booking>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Booking] and returns the inserted row.
  ///
  /// The returned [Booking] will have its `id` field set.
  Future<Booking> insertRow(
    _is.DatabaseSession session,
    Booking row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Booking>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Booking]s in the list and returns the resulting rows.
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
  /// The returned [Booking]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Booking>> upsert(
    _is.DatabaseSession session,
    List<Booking> rows, {
    required _is.ColumnSelections<BookingTable> conflictColumns,
    _is.ColumnSelections<BookingTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Booking>(
      rows,
      conflictColumns: conflictColumns(Booking.t),
      updateColumns: updateColumns?.call(Booking.t),
      updateWhere: updateWhere?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Booking] and returns the resulting row.
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
  /// The returned [Booking] will have its `id` field set.
  Future<Booking?> upsertRow(
    _is.DatabaseSession session,
    Booking row, {
    required _is.ColumnSelections<BookingTable> conflictColumns,
    _is.ColumnSelections<BookingTable>? updateColumns,
    _is.WhereExpressionBuilder<BookingTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Booking>(
      row,
      conflictColumns: conflictColumns(Booking.t),
      updateColumns: updateColumns?.call(Booking.t),
      updateWhere: updateWhere?.call(Booking.t),
      transaction: transaction,
    );
  }

  /// Updates all [Booking]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Booking>> update(
    _is.DatabaseSession session,
    List<Booking> rows, {
    _is.ColumnSelections<BookingTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Booking>(
      rows,
      columns: columns?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Booking]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Booking> updateRow(
    _is.DatabaseSession session,
    Booking row, {
    _is.ColumnSelections<BookingTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Booking>(
      row,
      columns: columns?.call(Booking.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Booking] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Booking?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BookingUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Booking>(
      id,
      columnValues: columnValues(Booking.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Booking]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Booking>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BookingUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BookingTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Booking>(
      columnValues: columnValues(Booking.t.updateTable),
      where: where(Booking.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Booking]s in the list and returns the deleted rows.
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
  Future<List<Booking>> delete(
    _is.DatabaseSession session,
    List<Booking> rows, {
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Booking>(
      rows,
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Booking].
  Future<Booking> deleteRow(
    _is.DatabaseSession session,
    Booking row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Booking>(
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
  Future<List<Booking>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingTable> where,
    _is.OrderByBuilder<BookingTable>? orderBy,
    _is.OrderByListBuilder<BookingTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Booking>(
      where: where(Booking.t),
      orderBy: orderBy?.call(Booking.t),
      orderByList: orderByList?.call(Booking.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BookingTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Booking>(
      where: where?.call(Booking.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Booking] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BookingTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Booking>(
      where: where(Booking.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
