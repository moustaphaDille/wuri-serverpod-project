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

abstract class SpaceImageUpload
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SpaceImageUpload._({
    required this.path,
    required this.uploadDescription,
  });

  factory SpaceImageUpload({
    required String path,
    required String uploadDescription,
  }) = _SpaceImageUploadImpl;

  factory SpaceImageUpload.fromJson(Map<String, dynamic> jsonSerialization) {
    return SpaceImageUpload(
      path: jsonSerialization['path'] as String,
      uploadDescription: jsonSerialization['uploadDescription'] as String,
    );
  }

  String path;

  String uploadDescription;

  /// Returns a shallow copy of this [SpaceImageUpload]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SpaceImageUpload copyWith({
    String? path,
    String? uploadDescription,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SpaceImageUpload',
      'path': path,
      'uploadDescription': uploadDescription,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SpaceImageUpload',
      'path': path,
      'uploadDescription': uploadDescription,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SpaceImageUploadImpl extends SpaceImageUpload {
  _SpaceImageUploadImpl({
    required String path,
    required String uploadDescription,
  }) : super._(
         path: path,
         uploadDescription: uploadDescription,
       );

  /// Returns a shallow copy of this [SpaceImageUpload]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SpaceImageUpload copyWith({
    String? path,
    String? uploadDescription,
  }) {
    return SpaceImageUpload(
      path: path ?? this.path,
      uploadDescription: uploadDescription ?? this.uploadDescription,
    );
  }
}
