import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';

/// Les espaces publiés par l'hôte connecté.
final mySpacesProvider = FutureProvider.autoDispose<List<Space>>((ref) {
  return client.hostSpace.listMySpaces();
});