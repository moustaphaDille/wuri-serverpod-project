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

abstract class HostBookingRequest
    implements _is.SerializableModel, _is.ProtocolSerialization {
  HostBookingRequest._({
    required this.booking,
    required this.spaceName,
    required this.guestFirstName,
    required this.guestLastName,
  });

  factory HostBookingRequest({
    required _igagux5r.Booking booking,
    required String spaceName,
    required String guestFirstName,
    required String guestLastName,
  }) = _HostBookingRequestImpl;

  factory HostBookingRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return HostBookingRequest(
      booking: _ig0ersr1.Protocol().deserialize<_igagux5r.Booking>(
        jsonSerialization['booking'],
      ),
      spaceName: jsonSerialization['spaceName'] as String,
      guestFirstName: jsonSerialization['guestFirstName'] as String,
      guestLastName: jsonSerialization['guestLastName'] as String,
    );
  }

  _igagux5r.Booking booking;

  String spaceName;

  String guestFirstName;

  String guestLastName;

  /// Returns a shallow copy of this [HostBookingRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  HostBookingRequest copyWith({
    _igagux5r.Booking? booking,
    String? spaceName,
    String? guestFirstName,
    String? guestLastName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'HostBookingRequest',
      'booking': booking.toJson(),
      'spaceName': spaceName,
      'guestFirstName': guestFirstName,
      'guestLastName': guestLastName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'HostBookingRequest',
      'booking': booking.toJsonForProtocol(),
      'spaceName': spaceName,
      'guestFirstName': guestFirstName,
      'guestLastName': guestLastName,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _HostBookingRequestImpl extends HostBookingRequest {
  _HostBookingRequestImpl({
    required _igagux5r.Booking booking,
    required String spaceName,
    required String guestFirstName,
    required String guestLastName,
  }) : super._(
         booking: booking,
         spaceName: spaceName,
         guestFirstName: guestFirstName,
         guestLastName: guestLastName,
       );

  /// Returns a shallow copy of this [HostBookingRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  HostBookingRequest copyWith({
    _igagux5r.Booking? booking,
    String? spaceName,
    String? guestFirstName,
    String? guestLastName,
  }) {
    return HostBookingRequest(
      booking: booking ?? this.booking.copyWith(),
      spaceName: spaceName ?? this.spaceName,
      guestFirstName: guestFirstName ?? this.guestFirstName,
      guestLastName: guestLastName ?? this.guestLastName,
    );
  }
}
