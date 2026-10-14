import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Le stockage local, créé une fois au démarrage dans main.dart.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Défini dans main.dart');
});

/// Les identifiants des espaces mis en favoris, mémorisés sur l'appareil.
class FavoritesNotifier extends Notifier<Set<int>> {
  static const _key = 'favorite_space_ids';

  @override
  Set<int> build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final saved = prefs.getStringList(_key) ?? <String>[];
    return saved.map(int.tryParse).whereType<int>().toSet();
  }

  Future<void> toggle(int spaceId) async {
    final next = {...state};
    if (!next.add(spaceId)) next.remove(spaceId);
    state = next;

    await ref
        .read(sharedPreferencesProvider)
        .setStringList(_key, next.map((id) => id.toString()).toList());
  }
}

final favoritesProvider =
    NotifierProvider<FavoritesNotifier, Set<int>>(FavoritesNotifier.new);