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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:wuri_client/src/protocol/admin_application.dart' as _im8qqavm;
import 'package:wuri_client/src/protocol/app_user.dart' as _ickzx3kh;
import 'package:wuri_client/src/protocol/host_booking_request.dart'
    as _idzklkdv;
import 'package:wuri_client/src/protocol/my_booking.dart' as _ii5svgo2;
import 'package:wuri_client/src/protocol/space.dart' as _ibf88rrb;
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
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

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
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _isc.getType<_ialps7z9.AdminApplication?>()) {
      return (data != null ? _ialps7z9.AdminApplication.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_it4z223c.AppException?>()) {
      return (data != null ? _it4z223c.AppException.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i2j2xfrn.AppUser?>()) {
      return (data != null ? _i2j2xfrn.AppUser.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_igagux5r.Booking?>()) {
      return (data != null ? _igagux5r.Booking.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ifekp8p0.BookingStatus?>()) {
      return (data != null ? _ifekp8p0.BookingStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_izw8z7ou.Greeting?>()) {
      return (data != null ? _izw8z7ou.Greeting.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i7tlmwdz.HostBookingRequest?>()) {
      return (data != null ? _i7tlmwdz.HostBookingRequest.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i16ts3lu.MyBooking?>()) {
      return (data != null ? _i16ts3lu.MyBooking.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_isvd2p1g.PartnerApplication?>()) {
      return (data != null ? _isvd2p1g.PartnerApplication.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_imotz5ce.PaymentMethod?>()) {
      return (data != null ? _imotz5ce.PaymentMethod.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i1yjuv69.Space?>()) {
      return (data != null ? _i1yjuv69.Space.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ifjq756c.SpaceImageUpload?>()) {
      return (data != null ? _ifjq756c.SpaceImageUpload.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iycu1zrq.SpaceType?>()) {
      return (data != null ? _iycu1zrq.SpaceType.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ihjssg7m.ApplicationStatus?>()) {
      return (data != null ? _ihjssg7m.ApplicationStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ir0y0iu6.UserRole?>()) {
      return (data != null ? _ir0y0iu6.UserRole.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_im8qqavm.AdminApplication>) {
      return (data as List)
              .map((e) => deserialize<_im8qqavm.AdminApplication>(e))
              .toList()
          as T;
    }
    if (t == List<_ickzx3kh.AppUser>) {
      return (data as List)
              .map((e) => deserialize<_ickzx3kh.AppUser>(e))
              .toList()
          as T;
    }
    if (t == List<_ii5svgo2.MyBooking>) {
      return (data as List)
              .map((e) => deserialize<_ii5svgo2.MyBooking>(e))
              .toList()
          as T;
    }
    if (t == List<_idzklkdv.HostBookingRequest>) {
      return (data as List)
              .map((e) => deserialize<_idzklkdv.HostBookingRequest>(e))
              .toList()
          as T;
    }
    if (t == List<_ibf88rrb.Space>) {
      return (data as List).map((e) => deserialize<_ibf88rrb.Space>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    try {
      return _iaic.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacc.Protocol().deserialize<T>(data, t);
    } on _isc.DeserializationTypeNotFoundException catch (_) {}
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
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
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
      return _iaic.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacc.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('wuri', this);
    _iacc.Protocol().registerHostProtocol('wuri', this);
  }

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
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
