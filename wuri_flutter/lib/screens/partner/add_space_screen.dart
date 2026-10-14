
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

/// Formulaire responsive de publication d'un espace.
class AddSpaceScreen extends ConsumerStatefulWidget {
  const AddSpaceScreen({super.key});

  @override
  ConsumerState<AddSpaceScreen> createState() =>
      _AddSpaceScreenState();
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
    _mapController.dispose();
    super.dispose();
  }

  String? _required(String? value) {
    final l10n = AppLocalizations.of(context)!;
    return value == null || value.trim().isEmpty
        ? l10n.fieldRequired
        : null;
  }

  String? _positiveNumber(String? value) {
    final l10n = AppLocalizations.of(context)!;
    final number = int.tryParse(
      (value ?? '').replaceAll(' ', ''),
    );

    return number == null || number < 1
        ? l10n.invalidNumber
        : null;
  }

  Future<void> _pickImage() async {
    if (_saving) return;

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

  void _changeCity(NigerCity? city) {
    if (city == null) return;

    setState(() {
      _city = city;
      _latitude = city.latitude;
      _longitude = city.longitude;
    });

    _mapController.move(
      LatLng(city.latitude, city.longitude),
      12,
    );
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;

    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;

    final image = _image;
    final imageBytes = _imageBytes;

    if (image == null || imageBytes == null) {
      showAppSnackBar(context, l10n.fieldRequired);
      return;
    }

    setState(() => _saving = true);

    try {
      final extension = image.name.contains('.')
          ? image.name.split('.').last.toLowerCase()
          : 'jpg';

      final upload =
          await client.hostSpace.getSpaceImageUploadDescription(
        extension,
      );

      final uploaded = await FileUploader(
        upload.uploadDescription,
      ).uploadByteData(
        ByteData.sublistView(imageBytes),
      );

      if (!uploaded) {
        throw AppException(message: 'Image upload failed.');
      }

      final photoUrl =
          await client.hostSpace.verifySpaceImageUpload(
        upload.path,
      );

      await client.hostSpace.createSpace(
        name: _name.text.trim(),
        type: _type,
        description: _description.text.trim(),
        city: _city.name,
        latitude: _latitude,
        longitude: _longitude,
        pricePerNight: int.parse(
          _price.text.replaceAll(' ', ''),
        ),
        maxGuests: int.parse(
          _guests.text.replaceAll(' ', ''),
        ),
        photoUrls: [photoUrl],
      );

      ref.invalidate(mySpacesProvider);
      ref.invalidate(spacesProvider);

      if (!mounted) return;

      showAppSnackBar(context, l10n.spacePublished);
      context.pop();
    } on AppException catch (e) {
      if (mounted) {
        showAppSnackBar(context, e.message);
      }
    } catch (_) {
      if (mounted) {
        showAppSnackBar(
          context,
          l10n.genericError,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Widget _sectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.terracotta,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(AppLocalizations l10n) {
    return _sectionCard(
      icon: Icons.home_work_outlined,
      title: l10n.addSpace,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _name,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.spaceName,
              prefixIcon: const Icon(Icons.title),
            ),
            validator: _required,
          ),
          const SizedBox(height: 18),
          DropdownButtonFormField<SpaceType>(
            initialValue: _type,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: l10n.spaceTypeLabel,
              prefixIcon: const Icon(Icons.category_outlined),
            ),
            items: [
              for (final type in SpaceType.values)
                DropdownMenuItem(
                  value: type,
                  child: Text(
                    spaceTypeLabel(l10n, type),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
            onChanged: _saving
                ? null
                : (value) {
                    if (value != null) {
                      setState(() => _type = value);
                    }
                  },
          ),
          const SizedBox(height: 18),
          DropdownButtonFormField<NigerCity>(
            initialValue: _city,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: l10n.cityLabel,
              prefixIcon: const Icon(Icons.location_city_outlined),
            ),
            items: [
              for (final city in nigerCities)
                DropdownMenuItem(
                  value: city,
                  child: Text(
                    city.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
            onChanged: _saving ? null : _changeCity,
          ),
          const SizedBox(height: 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final horizontal = constraints.maxWidth >= 420;

              final priceField = TextFormField(
                controller: _price,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l10n.pricePerNightLabel,
                  prefixIcon: const Icon(Icons.payments_outlined),
                  suffixText: 'FCFA',
                ),
                validator: _positiveNumber,
              );

              final guestsField = TextFormField(
                controller: _guests,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l10n.maxGuestsLabel,
                  prefixIcon: const Icon(Icons.people_outline),
                ),
                validator: _positiveNumber,
              );

              if (!horizontal) {
                return Column(
                  children: [
                    priceField,
                    const SizedBox(height: 18),
                    guestsField,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: priceField),
                  const SizedBox(width: 14),
                  Expanded(child: guestsField),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          TextFormField(
            controller: _description,
            minLines: 4,
            maxLines: 8,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: l10n.descriptionLabel,
              alignLabelWithHint: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(bottom: 68),
                child: Icon(Icons.notes_outlined),
              ),
            ),
            validator: _required,
          ),
        ],
      ),
    );
  }

  Widget _buildLocation(AppLocalizations l10n) {
    return _sectionCard(
      icon: Icons.map_outlined,
      title: l10n.locationLabel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.locationHelp,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.muted,
                ),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final mapHeight = constraints.maxWidth >= 600
                  ? 340.0
                  : 260.0;

              return SizedBox(
                height: mapHeight,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(
                        _latitude,
                        _longitude,
                      ),
                      initialZoom: 12,
                      onTap: (_, point) {
                        if (_saving) return;

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
                            point: LatLng(
                              _latitude,
                              _longitude,
                            ),
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
                          TextSourceAttribution(
                            'OpenStreetMap contributors',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.sand.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.my_location,
                  color: AppColors.terracotta,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.locationLabel,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 4),
                      SelectableText(
                        '${_latitude.toStringAsFixed(5)}, '
                        '${_longitude.toStringAsFixed(5)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoto(AppLocalizations l10n) {
    return _sectionCard(
      icon: Icons.add_a_photo_outlined,
      title: l10n.photoUrlLabel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.photoUrlHelp,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.muted,
                ),
          ),
          const SizedBox(height: 14),
          Material(
            color: AppColors.sand,
            borderRadius: BorderRadius.circular(14),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: _saving ? null : _pickImage,
              child: Container(
                constraints: const BoxConstraints(
                  minHeight: 180,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.sandDeep,
                  ),
                ),
                child: _imageBytes == null
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 42,
                              color: AppColors.terracotta,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              l10n.photoUrlHelp,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Icon(Icons.upload_outlined),
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 230,
                            child: Image.memory(
                              _imageBytes!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: IconButton.filled(
                              tooltip: MaterialLocalizations.of(context)
                                  .deleteButtonTooltip,
                              onPressed: _saving
                                  ? null
                                  : () {
                                      setState(() {
                                        _image = null;
                                        _imageBytes = null;
                                      });
                                    },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                          Positioned(
                            left: 10,
                            bottom: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(
                                  alpha: 0.65,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Photo sélectionnée',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPublishButton(AppLocalizations l10n) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton.icon(
        onPressed: _saving ? null : _submit,
        icon: _saving
            ? const SizedBox(
                width: 19,
                height: 19,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.publish_outlined),
        label: Text(
          _saving ? 'Publication...' : l10n.publishSpace,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addSpace),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: LayoutBuilder(
            builder: (context, screenConstraints) {
              final isWide = screenConstraints.maxWidth >= 900;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: screenConstraints.maxWidth >= 700
                      ? 28
                      : 16,
                  vertical: 24,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1200,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.addSpace,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.locationHelp,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: AppColors.muted,
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (isWide)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: _buildDetails(l10n),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    _buildLocation(l10n),
                                    const SizedBox(height: 24),
                                    _buildPhoto(l10n),
                                  ],
                                ),
                              ),
                            ],
                          )
                        else
                          Column(
                            children: [
                              _buildDetails(l10n),
                              const SizedBox(height: 20),
                              _buildLocation(l10n),
                              const SizedBox(height: 20),
                              _buildPhoto(l10n),
                            ],
                          ),
                        const SizedBox(height: 24),
                        _buildPublishButton(l10n),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
