import 'package:flutter/material.dart';
import 'package:wuri_client/wuri_client.dart';

/// L'icône qui représente un type d'espace.
IconData spaceTypeIcon(SpaceType type) => switch (type) {
      SpaceType.hotel => Icons.apartment_rounded,
      SpaceType.stay => Icons.home_rounded,
      SpaceType.workspace => Icons.work_rounded,
    };