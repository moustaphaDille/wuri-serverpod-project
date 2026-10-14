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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'booking_status.dart' as _ifekp8p0;
import 'payment_method.dart' as _imotz5ce;

abstract class Booking
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      checkIn: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['checkIn'],
      ),
      checkOut: _isc.DateTimeJsonExtension.fromJson(
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
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [Booking]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
