import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/format.dart';
import 'package:wuri_flutter/widgets/space_image.dart';

/// Carte OpenStreetMap avec un repère de prix par espace.
class SpacesMap extends StatefulWidget {
  const SpacesMap({super.key, required this.spaces, required this.onOpen});

  final List<Space> spaces;
  final void Function(Space space) onOpen;

  @override
  State<SpacesMap> createState() => _SpacesMapState();
}

class _SpacesMapState extends State<SpacesMap> {
  Space? _selected;

  /// Centre et niveau de zoom de départ, selon l'étendue des espaces.
  (LatLng, double) _camera() {
    if (widget.spaces.isEmpty) return (const LatLng(16.0, 8.0), 5.2);

    final points = [
      for (final space in widget.spaces)
        LatLng(space.latitude, space.longitude),
    ];
    final lats = points.map((p) => p.latitude);
    final lngs = points.map((p) => p.longitude);
    final minLat = lats.reduce(math.min);
    final maxLat = lats.reduce(math.max);
    final minLng = lngs.reduce(math.min);
    final maxLng = lngs.reduce(math.max);

    final span = math.max(maxLat - minLat, maxLng - minLng);
    final zoom = span < 0.1
        ? 12.0
        : span < 1
        ? 9.0
        : span < 4
        ? 7.0
        : 5.5;

    return (LatLng((minLat + maxLat) / 2, (minLng + maxLng) / 2), zoom);
  }

  /// 35000 devient "35k".
  String _shortPrice(int price) {
    if (price < 1000) return '$price';
    final k = price / 1000;
    return '${k.toStringAsFixed(price % 1000 == 0 ? 0 : 1)}k';
  }

  @override
  Widget build(BuildContext context) {
    final (center, zoom) = _camera();

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: center,
            initialZoom: zoom,
            onTap: (tapPosition, point) => setState(() => _selected = null),
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              // Obligatoire : identifie l'application auprès du serveur de tuiles.
              userAgentPackageName: 'com.wuri.app',
            ),
            MarkerLayer(
              markers: [
                for (final space in widget.spaces)
                  Marker(
                    point: LatLng(space.latitude, space.longitude),
                    width: 64,
                    height: 30,
                    child: GestureDetector(
                      onTap: () => setState(() => _selected = space),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selected?.id == space.id
                              ? AppColors.indigo
                              : AppColors.terracotta,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white, width: 1.5),
                          boxShadow: softShadow,
                        ),
                        child: Text(
                          _shortPrice(space.pricePerNight),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            // Obligatoire : l'attribution des données OpenStreetMap.
            const RichAttributionWidget(
              attributions: [
                TextSourceAttribution('OpenStreetMap contributors'),
              ],
            ),
          ],
        ),
        if (_selected != null)
          Positioned(
            left: 12,
            right: 12,
            bottom: 28,
            child: _SelectedTile(
              space: _selected!,
              onOpen: () => widget.onOpen(_selected!),
            ),
          ),
      ],
    );
  }
}

class _SelectedTile extends StatelessWidget {
  const _SelectedTile({required this.space, required this.onOpen});

  final Space space;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              SizedBox(
                width: 72,
                height: 72,
                child: SpaceImage(
                  space: space,
                  height: 72,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      space.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      space.city,
                      style: const TextStyle(color: AppColors.muted),
                    ),
                    Text(
                      l10n.perNight(formatPrice(space.pricePerNight)),
                      style: const TextStyle(
                        color: AppColors.terracotta,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}
