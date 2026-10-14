/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:wuri_server/src/generated/admin_application.dart' as _ifmbzt8a;
import 'package:wuri_server/src/generated/app_user.dart' as _i817yw5p;
import 'package:wuri_server/src/generated/host_booking_request.dart'
    as _i9xwz50h;
import 'package:wuri_server/src/generated/my_booking.dart' as _i6nfd25k;
import 'package:wuri_server/src/generated/space.dart' as _i06orfqi;
import 'admin_application.dart' as _ialps7z9;
import 'app_exception.dart' as _it4z223c;
import 'app_user.dart' as _i2j2xfrn;
import 'booking.dart' as _igagux5r;
import 'booking_status.dart' as _ifekp8p0;
import 'greetings/greeting.dart' as _izw8z7ou;
import 'host_booking_request.dart' as _i7tlmwdz;
import 'my_booking.dart' as _i16ts3lu;
import 'partner_application.dart' as _isvd2p1g;
import 'payment_method.dart' as _imotz5ce;
import 'space.dart' as _i1yjuv69;
import 'space_image_upload.dart' as _ifjq756c;
import 'space_type.dart' as _iycu1zrq;
import 'status.dart' as _ihjssg7m;
import 'user_role.dart' as _ir0y0iu6;
export 'admin_application.dart';
export 'app_exception.dart';
export 'app_user.dart';
export 'booking.dart';
export 'booking_status.dart';
export 'greetings/greeting.dart';
export 'host_booking_request.dart';
export 'my_booking.dart';
export 'partner_application.dart';
export 'payment_method.dart';
export 'space.dart';
export 'space_image_upload.dart';
export 'space_type.dart';
export 'status.dart';
export 'user_role.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'app_user',
      dartName: 'AppUser',
      schema: 'public',
      module: 'wuri',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'authUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'firstName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'lastName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'phone',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:UserRole',
        ),
        _isp.ColumnDefinition(
          name: 'language',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'app_user_fk_0',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'app_user_auth_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'booking',
      dartName: 'Booking',
      schema: 'public',
      module: 'wuri',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'placeId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'guestId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'checkIn',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'checkOut',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'guests',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'totalPrice',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'currency',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:BookingStatus',
        ),
        _isp.ColumnDefinition(
          name: 'paymentMethod',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PaymentMethod',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'booking_fk_0',
          columns: ['placeId'],
          referenceTable: 'space',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
        _isp.ForeignKeyDefinition(
          constraintName: 'booking_fk_1',
          columns: ['guestId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'partner_application',
      dartName: 'PartnerApplication',
      schema: 'public',
      module: 'wuri',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'appUserId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'businessName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'businessType',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SpaceType',
        ),
        _isp.ColumnDefinition(
          name: 'city',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'address',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'registrationNumber',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'documentPath',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:ApplicationStatus',
        ),
        _isp.ColumnDefinition(
          name: 'rejectionReason',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'reviewedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'partner_application_fk_0',
          columns: ['appUserId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'partner_application_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'appUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'space',
      dartName: 'Space',
      schema: 'public',
      module: 'wuri',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'ownerId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:SpaceType',
        ),
        _isp.ColumnDefinition(
          name: 'description',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'city',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'latitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'longitude',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'pricePerNight',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'currency',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'maxGuests',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'photoUrls',
          columnType: _isp.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _isp.ColumnDefinition(
          name: 'isActive',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'space_fk_0',
          columns: ['ownerId'],
          referenceTable: 'app_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.noAction,
          matchType: null,
        ),
      ],
      indexes: [],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _ialps7z9.AdminApplication) {
      return _ialps7z9.AdminApplication.fromJson(data) as T;
    }
    if (t == _it4z223c.AppException) {
      return _it4z223c.AppException.fromJson(data) as T;
    }
    if (t == _i2j2xfrn.AppUser) {
      return _i2j2xfrn.AppUser.fromJson(data) as T;
    }
    if (t == _igagux5r.Booking) {
      return _igagux5r.Booking.fromJson(data) as T;
    }
    if (t == _ifekp8p0.BookingStatus) {
      return _ifekp8p0.BookingStatus.fromJson(data) as T;
    }
    if (t == _izw8z7ou.Greeting) {
      return _izw8z7ou.Greeting.fromJson(data) as T;
    }
    if (t == _i7tlmwdz.HostBookingRequest) {
      return _i7tlmwdz.HostBookingRequest.fromJson(data) as T;
    }
    if (t == _i16ts3lu.MyBooking) {
      return _i16ts3lu.MyBooking.fromJson(data) as T;
    }
    if (t == _isvd2p1g.PartnerApplication) {
      return _isvd2p1g.PartnerApplication.fromJson(data) as T;
    }
    if (t == _imotz5ce.PaymentMethod) {
      return _imotz5ce.PaymentMethod.fromJson(data) as T;
    }
    if (t == _i1yjuv69.Space) {
      return _i1yjuv69.Space.fromJson(data) as T;
    }
    if (t == _ifjq756c.SpaceImageUpload) {
      return _ifjq756c.SpaceImageUpload.fromJson(data) as T;
    }
    if (t == _iycu1zrq.SpaceType) {
      return _iycu1zrq.SpaceType.fromJson(data) as T;
    }
    if (t == _ihjssg7m.ApplicationStatus) {
      return _ihjssg7m.ApplicationStatus.fromJson(data) as T;
    }
    if (t == _ir0y0iu6.UserRole) {
      return _ir0y0iu6.UserRole.fromJson(data) as T;
    }
    if (t == _is.getType<_ialps7z9.AdminApplication?>()) {
      return (data != null ? _ialps7z9.AdminApplication.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_it4z223c.AppException?>()) {
      return (data != null ? _it4z223c.AppException.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i2j2xfrn.AppUser?>()) {
      return (data != null ? _i2j2xfrn.AppUser.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_igagux5r.Booking?>()) {
      return (data != null ? _igagux5r.Booking.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifekp8p0.BookingStatus?>()) {
      return (data != null ? _ifekp8p0.BookingStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i7tlmwdz.HostBookingRequest?>()) {
      return (data != null ? _i7tlmwdz.HostBookingRequest.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i16ts3lu.MyBooking?>()) {
      return (data != null ? _i16ts3lu.MyBooking.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_isvd2p1g.PartnerApplication?>()) {
      return (data != null ? _isvd2p1g.PartnerApplication.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_imotz5ce.PaymentMethod?>()) {
      return (data != null ? _imotz5ce.PaymentMethod.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i1yjuv69.Space?>()) {
      return (data != null ? _i1yjuv69.Space.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifjq756c.SpaceImageUpload?>()) {
      return (data != null ? _ifjq756c.SpaceImageUpload.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iycu1zrq.SpaceType?>()) {
      return (data != null ? _iycu1zrq.SpaceType.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ihjssg7m.ApplicationStatus?>()) {
      return (data != null ? _ihjssg7m.ApplicationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ir0y0iu6.UserRole?>()) {
      return (data != null ? _ir0y0iu6.UserRole.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ifmbzt8a.AdminApplication>) {
      return (data as List)
              .map((e) => deserialize<_ifmbzt8a.AdminApplication>(e))
              .toList()
          as T;
    }
    if (t == List<_i817yw5p.AppUser>) {
      return (data as List)
              .map((e) => deserialize<_i817yw5p.AppUser>(e))
              .toList()
          as T;
    }
    if (t == List<_i6nfd25k.MyBooking>) {
      return (data as List)
              .map((e) => deserialize<_i6nfd25k.MyBooking>(e))
              .toList()
          as T;
    }
    if (t == List<_i9xwz50h.HostBookingRequest>) {
      return (data as List)
              .map((e) => deserialize<_i9xwz50h.HostBookingRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_i06orfqi.Space>) {
      return (data as List).map((e) => deserialize<_i06orfqi.Space>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _ialps7z9.AdminApplication => 'AdminApplication',
      _it4z223c.AppException => 'AppException',
      _i2j2xfrn.AppUser => 'AppUser',
      _igagux5r.Booking => 'Booking',
      _ifekp8p0.BookingStatus => 'BookingStatus',
      _izw8z7ou.Greeting => 'Greeting',
      _i7tlmwdz.HostBookingRequest => 'HostBookingRequest',
      _i16ts3lu.MyBooking => 'MyBooking',
      _isvd2p1g.PartnerApplication => 'PartnerApplication',
      _imotz5ce.PaymentMethod => 'PaymentMethod',
      _i1yjuv69.Space => 'Space',
      _ifjq756c.SpaceImageUpload => 'SpaceImageUpload',
      _iycu1zrq.SpaceType => 'SpaceType',
      _ihjssg7m.ApplicationStatus => 'ApplicationStatus',
      _ir0y0iu6.UserRole => 'UserRole',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('wuri.', '');
    }

    switch (data) {
      case _ialps7z9.AdminApplication():
        return 'AdminApplication';
      case _it4z223c.AppException():
        return 'AppException';
      case _i2j2xfrn.AppUser():
        return 'AppUser';
      case _igagux5r.Booking():
        return 'Booking';
      case _ifekp8p0.BookingStatus():
        return 'BookingStatus';
      case _izw8z7ou.Greeting():
        return 'Greeting';
      case _i7tlmwdz.HostBookingRequest():
        return 'HostBookingRequest';
      case _i16ts3lu.MyBooking():
        return 'MyBooking';
      case _isvd2p1g.PartnerApplication():
        return 'PartnerApplication';
      case _imotz5ce.PaymentMethod():
        return 'PaymentMethod';
      case _i1yjuv69.Space():
        return 'Space';
      case _ifjq756c.SpaceImageUpload():
        return 'SpaceImageUpload';
      case _iycu1zrq.SpaceType():
        return 'SpaceType';
      case _ihjssg7m.ApplicationStatus():
        return 'ApplicationStatus';
      case _ir0y0iu6.UserRole():
        return 'UserRole';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AdminApplication') {
      return deserialize<_ialps7z9.AdminApplication>(data['data']);
    }
    if (dataClassName == 'AppException') {
      return deserialize<_it4z223c.AppException>(data['data']);
    }
    if (dataClassName == 'AppUser') {
      return deserialize<_i2j2xfrn.AppUser>(data['data']);
    }
    if (dataClassName == 'Booking') {
      return deserialize<_igagux5r.Booking>(data['data']);
    }
    if (dataClassName == 'BookingStatus') {
      return deserialize<_ifekp8p0.BookingStatus>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_izw8z7ou.Greeting>(data['data']);
    }
    if (dataClassName == 'HostBookingRequest') {
      return deserialize<_i7tlmwdz.HostBookingRequest>(data['data']);
    }
    if (dataClassName == 'MyBooking') {
      return deserialize<_i16ts3lu.MyBooking>(data['data']);
    }
    if (dataClassName == 'PartnerApplication') {
      return deserialize<_isvd2p1g.PartnerApplication>(data['data']);
    }
    if (dataClassName == 'PaymentMethod') {
      return deserialize<_imotz5ce.PaymentMethod>(data['data']);
    }
    if (dataClassName == 'Space') {
      return deserialize<_i1yjuv69.Space>(data['data']);
    }
    if (dataClassName == 'SpaceImageUpload') {
      return deserialize<_ifjq756c.SpaceImageUpload>(data['data']);
    }
    if (dataClassName == 'SpaceType') {
      return deserialize<_iycu1zrq.SpaceType>(data['data']);
    }
    if (dataClassName == 'ApplicationStatus') {
      return deserialize<_ihjssg7m.ApplicationStatus>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_ir0y0iu6.UserRole>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('wuri', this);
    _iacs.Protocol().registerHostProtocol('wuri', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i2j2xfrn.AppUser:
        return _i2j2xfrn.AppUser.t;
      case _igagux5r.Booking:
        return _igagux5r.Booking.t;
      case _isvd2p1g.PartnerApplication:
        return _isvd2p1g.PartnerApplication.t;
      case _i1yjuv69.Space:
        return _i1yjuv69.Space.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'wuri';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
