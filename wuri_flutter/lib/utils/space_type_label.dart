import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';

/// Le libellé traduit d'un type d'espace.
String spaceTypeLabel(AppLocalizations l10n, SpaceType type) {
  return switch (type) {
    SpaceType.hotel => l10n.typeHotel,
    SpaceType.stay => l10n.typeStay,
    SpaceType.workspace => l10n.typeWorkspace,
  };
}