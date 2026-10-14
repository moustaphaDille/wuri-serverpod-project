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
import 'booking.dart' as _igagux5r;
import 'space.dart' as _i1yjuv69;

abstract class MyBooking
    implements _is.SerializableModel, _is.ProtocolSerialization {
  MyBooking._({
    required this.booking,
    required this.space,
  });

  factory MyBooking({
    required _igagux5r.Booking booking,
    required _i1yjuv69.Space space,
  }) = _MyBookingImpl;

  factory MyBooking.fromJson(Map<String, dynamic> jsonSerialization) {
    return MyBooking(
      booking: _ig0ersr1.Protocol().deserialize<_igagux5r.Booking>(
        jsonSerialization['booking'],
      ),
      space: _ig0ersr1.Protocol().deserialize<_i1yjuv69.Space>(
        jsonSerialization['space'],
      ),
    );
  }

  _igagux5r.Booking booking;

  _i1yjuv69.Space space;

  /// Returns a shallow copy of this [MyBooking]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  MyBooking copyWith({
    _igagux5r.Booking? booking,
    _i1yjuv69.Space? space,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MyBooking',
      'booking': booking.toJson(),
      'space': space.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MyBooking',
      'booking': booking.toJsonForProtocol(),
      'space': space.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _MyBookingImpl extends MyBooking {
  _MyBookingImpl({
    required _igagux5r.Booking booking,
    required _i1yjuv69.Space space,
  }) : super._(
         booking: booking,
         space: space,
       );

  /// Returns a shallow copy of this [MyBooking]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  MyBooking copyWith({
    _igagux5r.Booking? booking,
    _i1yjuv69.Space? space,
  }) {
    return MyBooking(
      booking: booking ?? this.booking.copyWith(),
      space: space ?? this.space.copyWith(),
    );
  }
}
