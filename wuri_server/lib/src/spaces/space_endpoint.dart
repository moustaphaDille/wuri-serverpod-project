import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Parcourir les espaces. Public : pas besoin d'être connecté.
class SpaceEndpoint extends Endpoint {
  /// Liste les espaces actifs, avec filtres facultatifs par ville et type.
  Future<List<Space>> listSpaces(
    Session session, {
    String? city,
    SpaceType? type,
  }) async {
    return Space.db.find(
      session,
      where: (t) {
        var filter = t.isActive.equals(true);
        if (city != null && city.trim().isNotEmpty) {
          filter = filter & t.city.ilike('%${city.trim()}%');
        }
        if (type != null) {
          filter = filter & t.type.equals(type);
        }
        return filter;
      },
        orderBy: (t) => t.createdAt.desc(),
      limit: 50,
    );
  }

  /// Renvoie un espace par son identifiant, ou null s'il n'existe pas.
  Future<Space?> getSpace(Session session, int id) async {
    final space = await Space.db.findById(session, id);
    if (space == null || !space.isActive) return null;
    return space;
  }
}