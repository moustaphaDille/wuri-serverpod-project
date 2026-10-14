import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../profile/host_guard.dart';

/// Gestion des espaces par leur propriétaire. Réservé aux utilisateurs connectés.
class HostSpaceEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<SpaceImageUpload> getSpaceImageUploadDescription(
    Session session,
    String extension,
  ) async {
    final host = await requireHostProfile(session);
    final normalizedExtension = extension.toLowerCase().replaceFirst('.', '');
    const allowedExtensions = {'jpg', 'jpeg', 'png', 'webp'};
    if (!allowedExtensions.contains(normalizedExtension)) {
      throw AppException(message: 'Unsupported image format.');
    }
    final path =
        'spaces/${host.id}/${DateTime.now().toUtc().microsecondsSinceEpoch}.$normalizedExtension';
    final uploadDescription = await session.storage.createUploadDescription(
      storageId: 'public',
      path: path,
    );
    return SpaceImageUpload(
      path: path,
      uploadDescription: uploadDescription,
    );
  }

  Future<String> verifySpaceImageUpload(
    Session session,
    String path,
  ) async {
    final host = await requireHostProfile(session);
    final hasAllowedExtension = ['.jpg', '.jpeg', '.png', '.webp']
        .any(path.endsWith);
    if (!path.startsWith('spaces/${host.id}/') || !hasAllowedExtension) {
      throw AppException(message: 'Invalid image upload.');
    }
    final verified = await session.storage.verifyUpload(
      storageId: 'public',
      path: path,
    );
    if (!verified) {
      throw AppException(message: 'Image upload verification failed.');
    }
    final downloadUrl = await session.storage.publicDownloadUrl(
      storageId: 'public',
      path: path,
    );
    return downloadUrl.toString();
  }

  /// Les espaces de l'hôte connecté.
  Future<List<Space>> listMySpaces(Session session) async {
    final host = await requireHostProfile(session);
    return Space.db.find(
      session,
      where: (t) => t.ownerId.equals(host.id!),
            orderBy: (t) => t.createdAt.desc(),
    );
  }

  /// Publie un nouvel espace.
  Future<Space> createSpace(
    Session session, {
    required String name,
    required SpaceType type,
    required String description,
    required String city,
    required double latitude,
    required double longitude,
    required int pricePerNight,
    required int maxGuests,
    required List<String> photoUrls,
  }) async {
    final host = await requireHostProfile(session);

    if (name.trim().isEmpty || city.trim().isEmpty) {
      throw AppException(message: 'Name and city are required.');
    }
    if (pricePerNight <= 0) {
      throw AppException(message: 'Price must be greater than 0.');
    }
    if (maxGuests < 1) {
      throw AppException(message: 'At least 1 guest is required.');
    }
    if (latitude < -90 || latitude > 90 || longitude < -180 || longitude > 180) {
      throw AppException(message: 'Invalid location.');
    }
    final cleanPhotoUrls = photoUrls
        .map((url) => url.trim())
        .where((url) => url.isNotEmpty)
        .toList();
    if (cleanPhotoUrls.isEmpty) {
      throw AppException(message: 'At least one space image is required.');
    }
    if (cleanPhotoUrls.any((url) => !url.startsWith('http'))) {
      throw AppException(message: 'Space image URLs must start with http.');
    }
    if (cleanPhotoUrls.length > 10) {
      throw AppException(message: 'Maximum 10 photos.');
    }

    final space = Space(
      ownerId: host.id!,
      name: name.trim(),
      type: type,
      description: description.trim(),
      city: city.trim(),
      latitude: latitude,
      longitude: longitude,
      pricePerNight: pricePerNight,
      currency: 'XOF',
      maxGuests: maxGuests,
      photoUrls: cleanPhotoUrls,
      isActive: true,
      createdAt: DateTime.now().toUtc(),
    );

    return Space.db.insertRow(session, space);
  }
}