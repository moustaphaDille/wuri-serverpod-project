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
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:wuri_client/src/protocol/protocol.dart' as _iwbmijg2;
import 'user_role.dart' as _ir0y0iu6;

abstract class AppUser
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AppUser._({
    this.id,
    required this.authUserId,
    this.authUser,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.role,
    required this.language,
    required this.createdAt,
  });

  factory AppUser({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required String firstName,
    required String lastName,
    required String phone,
    required _ir0y0iu6.UserRole role,
    required String language,
    required DateTime createdAt,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _iwbmijg2.Protocol().deserialize<_iacc.AuthUser>(
              jsonSerialization['authUser'],
            ),
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      phone: jsonSerialization['phone'] as String,
      role: _ir0y0iu6.UserRole.fromJson((jsonSerialization['role'] as String)),
      language: jsonSerialization['language'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  _iacc.AuthUser? authUser;

  String firstName;

  String lastName;

  String phone;

  _ir0y0iu6.UserRole role;

  String language;

  DateTime createdAt;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AppUser copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    _iacc.AuthUser? authUser,
    String? firstName,
    String? lastName,
    String? phone,
    _ir0y0iu6.UserRole? role,
    String? language,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'role': role.toJson(),
      'language': language,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'role': role.toJson(),
      'language': language,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    int? id,
    required _isc.UuidValue authUserId,
    _iacc.AuthUser? authUser,
    required String firstName,
    required String lastName,
    required String phone,
    required _ir0y0iu6.UserRole role,
    required String language,
    required DateTime createdAt,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         firstName: firstName,
         lastName: lastName,
         phone: phone,
         role: role,
         language: language,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AppUser copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    Object? authUser = _Undefined,
    String? firstName,
    String? lastName,
    String? phone,
    _ir0y0iu6.UserRole? role,
    String? language,
    DateTime? createdAt,
  }) {
    return AppUser(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _iacc.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
