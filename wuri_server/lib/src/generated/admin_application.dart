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
import 'partner_application.dart' as _isvd2p1g;

abstract class AdminApplication
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AdminApplication._({
    required this.application,
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.ownerPhone,
  });

  factory AdminApplication({
    required _isvd2p1g.PartnerApplication application,
    required String ownerFirstName,
    required String ownerLastName,
    required String ownerPhone,
  }) = _AdminApplicationImpl;

  factory AdminApplication.fromJson(Map<String, dynamic> jsonSerialization) {
    return AdminApplication(
      application: _ig0ersr1.Protocol()
          .deserialize<_isvd2p1g.PartnerApplication>(
            jsonSerialization['application'],
          ),
      ownerFirstName: jsonSerialization['ownerFirstName'] as String,
      ownerLastName: jsonSerialization['ownerLastName'] as String,
      ownerPhone: jsonSerialization['ownerPhone'] as String,
    );
  }

  _isvd2p1g.PartnerApplication application;

  String ownerFirstName;

  String ownerLastName;

  String ownerPhone;

  /// Returns a shallow copy of this [AdminApplication]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AdminApplication copyWith({
    _isvd2p1g.PartnerApplication? application,
    String? ownerFirstName,
    String? ownerLastName,
    String? ownerPhone,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AdminApplication',
      'application': application.toJson(),
      'ownerFirstName': ownerFirstName,
      'ownerLastName': ownerLastName,
      'ownerPhone': ownerPhone,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AdminApplication',
      'application': application.toJsonForProtocol(),
      'ownerFirstName': ownerFirstName,
      'ownerLastName': ownerLastName,
      'ownerPhone': ownerPhone,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AdminApplicationImpl extends AdminApplication {
  _AdminApplicationImpl({
    required _isvd2p1g.PartnerApplication application,
    required String ownerFirstName,
    required String ownerLastName,
    required String ownerPhone,
  }) : super._(
         application: application,
         ownerFirstName: ownerFirstName,
         ownerLastName: ownerLastName,
         ownerPhone: ownerPhone,
       );

  /// Returns a shallow copy of this [AdminApplication]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AdminApplication copyWith({
    _isvd2p1g.PartnerApplication? application,
    String? ownerFirstName,
    String? ownerLastName,
    String? ownerPhone,
  }) {
    return AdminApplication(
      application: application ?? this.application.copyWith(),
      ownerFirstName: ownerFirstName ?? this.ownerFirstName,
      ownerLastName: ownerLastName ?? this.ownerLastName,
      ownerPhone: ownerPhone ?? this.ownerPhone,
    );
  }
}
