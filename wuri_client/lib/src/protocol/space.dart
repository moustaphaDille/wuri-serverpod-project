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
import 'package:wuri_client/src/protocol/protocol.dart' as _iwbmijg2;
import 'space_type.dart' as _iycu1zrq;

abstract class Space
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      photoUrls: _iwbmijg2.Protocol().deserialize<List<String>>(
        jsonSerialization['photoUrls'],
      ),
      isActive: _isc.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [Space]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
