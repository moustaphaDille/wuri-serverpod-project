import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/host_providers.dart';
import 'package:wuri_flutter/providers/space_providers.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/niger_cities.dart';
import 'package:wuri_flutter/utils/snackbar.dart';
import 'package:wuri_flutter/utils/space_type_label.dart';

/// Formulaire de publication d'un espace.
class AddSpaceScreen extends ConsumerStatefulWidget {
  const AddSpaceScreen({super.key});

  @override
  ConsumerState<AddSpaceScreen> createState() => _AddSpaceScreenState();
}

class _AddSpaceScreenState extends ConsumerState<AddSpaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _guests = TextEditingController(text: '2');
  final _imagePicker = ImagePicker();

  SpaceType _type = SpaceType.hotel;
  NigerCity _city = nigerCities.first;
  late final MapController _mapController;
  late double _latitude;
  late double _longitude;
  XFile? _image;
  Uint8List? _imageBytes;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _latitude = _city.latitude;
    _longitude = _city.longitude;
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    _price.dispose();
    _guests.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 2400,
    );
    if (image == null) return;

    final bytes = await image.readAsBytes();
    if (!mounted) return;
    setState(() {
      _image = image;
      _imageBytes = bytes;
    });
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;
    final image = _image;
    final imageBytes = _imageBytes;
    if (image == null || imageBytes == null) {
      showAppSnackBar(context, l10n!.fieldRequired);
      return;
    }

    setState(() => _saving = true);
    try {
      final extension = image.name.contains('.')
          ? image.name.split('.').last.toLowerCase()
          : 'jpg';
      final upload = await client.hostSpace.getSpaceImageUploadDescription(
        extension,
      );
      final uploaded = await FileUploader(
        upload.uploadDescription,
      ).uploadByteData(ByteData.sublistView(imageBytes));
      if (!uploaded) {
        throw AppException(message: 'Image upload failed.');
      }
      final photoUrl = await client.hostSpace.verifySpaceImageUpload(
        upload.path,
      );

      await client.hostSpace.createSpace(
        name: _name.text,
        type: _type,
        description: _description.text,
        city: _city.name,
        latitude: _latitude,
        longitude: _longitude,
        pricePerNight: int.parse(_price.text.replaceAll(' ', '')),
        maxGuests: int.parse(_guests.text),
        photoUrls: [photoUrl],
      );

      // L'espace doit apparaître dans ma liste et sur l'accueil.
      ref.invalidate(mySpacesProvider);
      ref.invalidate(spacesProvider);

      if (!mounted) return;
      showAppSnackBar(context, l10n!.spacePublished);
      context.pop();
    } on AppException catch (e) {
      if (mounted) showAppSnackBar(context, e.message);
    } catch (_) {
      if (mounted) showAppSnackBar(context, l10n!.genericError);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    String? required(String? v) =>
        (v == null || v.trim().isEmpty) ? l10n!.fieldRequired : null;

    String? positiveNumber(String? v) {
      final n = int.tryParse((v ?? '').replaceAll(' ', ''));
      return (n == null || n < 1) ? l10n!.invalidNumber : null;
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n!.addSpace)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _name,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(labelText: l10n.spaceName),
                  validator: required,
                ),
                const SizedBox(height: 16),
                Text(l10n.spaceTypeLabel),
                const SizedBox(height: 8),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final compact = constraints.maxWidth < 520;
                    if (compact) {
                      return DropdownButtonFormField<SpaceType>(
                        initialValue: _type,
                        decoration: InputDecoration(
                          labelText: l10n.spaceTypeLabel,
                        ),
                        items: [
                          for (final t in SpaceType.values)
                            DropdownMenuItem(
                              value: t,
                              child: Text(spaceTypeLabel(l10n, t)),
                            ),
                        ],
                        onChanged: (value) {
                          if (value != null) setState(() => _type = value);
                        },
                      );
                    }

                    return SegmentedButton<SpaceType>(
                      showSelectedIcon: false,
                      segments: [
                        for (final t in SpaceType.values)
                          ButtonSegment(
                            value: t,
                            label: Text(
                              spaceTypeLabel(l10n, t),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                      selected: {_type},
                      onSelectionChanged: (s) =>
                          setState(() => _type = s.first),
                    );
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<NigerCity>(
                  initialValue: _city,
                  decoration: InputDecoration(labelText: l10n.cityLabel),
                  items: [
                    for (final c in nigerCities)
                      DropdownMenuItem(value: c, child: Text(c.name)),
                  ],
                  onChanged: (c) {
                    if (c != null) {
                      setState(() {
                        _city = c;
                        _latitude = c.latitude;
                        _longitude = c.longitude;
                      });
                      _mapController.move(LatLng(c.latitude, c.longitude), 12);
                    }
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.locationLabel,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.locationHelp,
                  style: const TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 260,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter: LatLng(_latitude, _longitude),
                        initialZoom: 12,
                        onTap: (_, point) {
                          setState(() {
                            _latitude = point.latitude;
                            _longitude = point.longitude;
                          });
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.wuri.app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: LatLng(_latitude, _longitude),
                              width: 44,
                              height: 44,
                              child: const Icon(
                                Icons.location_pin,
                                color: AppColors.terracotta,
                                size: 44,
                              ),
                            ),
                          ],
                        ),
                        const RichAttributionWidget(
                          attributions: [
                            TextSourceAttribution('OpenStreetMap contributors'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${_latitude.toStringAsFixed(5)}, '
                  '${_longitude.toStringAsFixed(5)}',
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.pricePerNightLabel,
                  ),
                  validator: positiveNumber,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _guests,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: l10n.maxGuestsLabel),
                  validator: positiveNumber,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _description,
                  minLines: 3,
                  maxLines: 6,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(labelText: l10n.descriptionLabel),
                  validator: required,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.photoUrlLabel,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _saving ? null : _pickImage,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 190,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.sand,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.sandDeep),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: _imageBytes == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 42,
                                color: AppColors.terracotta,
                              ),
                              const SizedBox(height: 8),
                              Text(l10n.photoUrlHelp),
                            ],
                          )
                        : Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.memory(_imageBytes!, fit: BoxFit.cover),
                              Positioned(
                                right: 10,
                                top: 10,
                                child: IconButton.filled(
                                  onPressed: _saving
                                      ? null
                                      : () => setState(() {
                                          _image = null;
                                          _imageBytes = null;
                                        }),
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _saving ? null : _submit,
                  child: _saving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10n.publishSpace),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
