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
import 'space_type.dart' as _iycu1zrq;
import 'status.dart' as _ihjssg7m;

abstract class PartnerApplication
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['reviewedAt'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [PartnerApplication]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
