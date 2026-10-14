import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';

/// Les filtres choisis par l'utilisateur sur l'accueil.
class SpaceFilter {
  const SpaceFilter({this.city = '', this.type});

  final String city;
  final SpaceType? type;

  SpaceFilter copyWith({String? city, SpaceType? type, bool clearType = false}) {
    return SpaceFilter(
      city: city ?? this.city,
      type: clearType ? null : (type ?? this.type),
    );
  }
}

class SpaceFilterNotifier extends Notifier<SpaceFilter> {
  @override
  SpaceFilter build() => const SpaceFilter();

  void setCity(String city) => state = state.copyWith(city: city);

  void setType(SpaceType? type) {
    state = type == null
        ? state.copyWith(clearType: true)
        : state.copyWith(type: type);
  }
}

final spaceFilterProvider =
    NotifierProvider<SpaceFilterNotifier, SpaceFilter>(SpaceFilterNotifier.new);

/// La liste des espaces. Elle se recharge toute seule quand le filtre change.
final spacesProvider = FutureProvider.autoDispose<List<Space>>((ref) {
  final filter = ref.watch(spaceFilterProvider);
  final city = filter.city.trim();

  return client.space.listSpaces(
    city: city.isEmpty ? null : city,
    type: filter.type,
  );
});

/// Un espace par son identifiant (pour la fiche détail).
final spaceByIdProvider =
    FutureProvider.autoDispose.family<Space?, int>((ref, id) {
  return client.space.getSpace(id);
});