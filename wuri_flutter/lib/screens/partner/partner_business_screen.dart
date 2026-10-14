
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/l10n/app_localizations.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';
import 'package:wuri_flutter/theme/app_theme.dart';
import 'package:wuri_flutter/utils/niger_cities.dart';
import 'package:wuri_flutter/utils/snackbar.dart';
import 'package:wuri_flutter/utils/space_type_label.dart';

/// Le partenaire décrit son établissement (envoyé pour vérification).
class PartnerBusinessScreen extends ConsumerStatefulWidget {
  const PartnerBusinessScreen({super.key});

  @override
  ConsumerState<PartnerBusinessScreen> createState() =>
      _PartnerBusinessScreenState();
}

class _PartnerBusinessScreenState
    extends ConsumerState<PartnerBusinessScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _registration = TextEditingController();

  SpaceType _type = SpaceType.hotel;
  NigerCity _city = nigerCities.first;
  bool _saving = false;

  bool get _isWide => MediaQuery.sizeOf(context).width >= 900;

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _registration.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    try {
      await client.partner.submitApplication(
        businessName: _name.text.trim(),
        businessType: _type,
        city: _city.name,
        address: _address.text.trim(),
        registrationNumber: _registration.text.trim(),
      );

      ref.invalidate(applicationProvider);

      if (!mounted) return;
      showAppSnackBar(context, l10n.applicationSent);
      context.go('/profile');
    } on AppException catch (e) {
      if (mounted) showAppSnackBar(context, e.message);
    } catch (_) {
      if (mounted) showAppSnackBar(context, l10n.genericError);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    String? required(String? value) {
      return (value == null || value.trim().isEmpty)
          ? l10n.fieldRequired
          : null;
    }

    String? registrationRule(String? value) {
      final text = (value ?? '').trim();
      return (text.length < 3 || text.length > 50)
          ? l10n.fieldRequired
          : null;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: Text(l10n.businessTitle),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= 900;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: wide ? 32 : 20,
                vertical: wide ? 32 : 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1000),
                  child: Container(
                    padding: EdgeInsets.all(wide ? 36 : 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(wide ? 24 : 0),
                      border: wide
                          ? Border.all(
                              color: AppColors.border.withValues(alpha: 0.7),
                            )
                          : null,
                      boxShadow: wide
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.035),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ]
                          : null,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(l10n, wide),
                          SizedBox(height: wide ? 32 : 24),

                          // Nom de l'établissement.
                          _buildSectionTitle(
                            icon: Icons.business_outlined,
                            title: l10n.businessName,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _name,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                            decoration: _inputDecoration(
                              label: l10n.businessName,
                              hint: l10n.businessName,
                              icon: Icons.storefront_outlined,
                            ),
                            validator: required,
                          ),

                          const SizedBox(height: 28),

                          // Type d'établissement.
                          _buildSectionTitle(
                            icon: Icons.category_outlined,
                            title: l10n.spaceTypeLabel,
                          ),
                          const SizedBox(height: 12),
                          LayoutBuilder(
                            builder: (context, typeConstraints) {
                              final compact =
                                  typeConstraints.maxWidth < 560;

                              if (compact) {
                                return Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    for (final type in SpaceType.values)
                                      _TypeChoice(
                                        label: spaceTypeLabel(l10n, type),
                                        selected: _type == type,
                                        onTap: () {
                                          setState(() => _type = type);
                                        },
                                      ),
                                  ],
                                );
                              }

                              return SegmentedButton<SpaceType>(
                                showSelectedIcon: false,
                                segments: [
                                  for (final type in SpaceType.values)
                                    ButtonSegment(
                                      value: type,
                                      label: Text(
                                        spaceTypeLabel(l10n, type),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                ],
                                selected: {_type},
                                onSelectionChanged: (selection) {
                                  setState(() => _type = selection.first);
                                },
                              );
                            },
                          ),

                          const SizedBox(height: 28),

                          // Localisation et adresse.
                          _buildSectionTitle(
                            icon: Icons.location_on_outlined,
                            title: l10n.cityLabel,
                          ),
                          const SizedBox(height: 12),

                          if (wide)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: _buildCityField(l10n),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: _buildAddressField(
                                    l10n,
                                    required,
                                  ),
                                ),
                              ],
                            )
                          else ...[
                            _buildCityField(l10n),
                            const SizedBox(height: 16),
                            _buildAddressField(l10n, required),
                          ],

                          const SizedBox(height: 28),

                          // Informations administratives.
                          _buildSectionTitle(
                            icon: Icons.verified_user_outlined,
                            title: l10n.registrationNumber,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _registration,
                            textCapitalization:
                                TextCapitalization.characters,
                            textInputAction: TextInputAction.done,
                            decoration: _inputDecoration(
                              label: l10n.registrationNumber,
                              hint: l10n.registrationNumber,
                              icon: Icons.badge_outlined,
                            ),
                            validator: registrationRule,
                          ),

                          const SizedBox(height: 32),

                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: wide ? 320 : double.infinity,
                              height: 52,
                              child: FilledButton.icon(
                                onPressed: _saving ? null : _submit,
                                icon: _saving
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.send_rounded,
                                        size: 19,
                                      ),
                                label: Text(
                                  _saving
                                      ? l10n.sendForVerification
                                      : l10n.sendForVerification,
                                  textAlign: TextAlign.center,
                                ),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.indigo,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n, bool wide) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.indigo.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(17),
          ),
          child: const Icon(
            Icons.apartment_rounded,
            color: AppColors.indigo,
            size: 30,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          l10n.businessTitle,
          style: TextStyle(
            fontSize: wide ? 30 : 25,
            fontWeight: FontWeight.w700,
            height: 1.25,
            color: const Color(0xFF172554),
          ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: Text(
            l10n.businessBody,
            style: const TextStyle(
              fontSize: 15,
              height: 1.65,
              color: Color(0xFF64748B),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.indigo),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF172554),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCityField(AppLocalizations l10n) {
    return DropdownButtonFormField<NigerCity>(
      initialValue: _city,
      isExpanded: true,
      decoration: _inputDecoration(
        label: l10n.cityLabel,
        hint: l10n.cityLabel,
        icon: Icons.location_city_outlined,
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
      onChanged: (city) {
        if (city != null) setState(() => _city = city);
      },
    );
  }

  Widget _buildAddressField(
    AppLocalizations l10n,
    String? Function(String?) validator,
  ) {
    return TextFormField(
      controller: _address,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.next,
      minLines: 1,
      maxLines: 3,
      decoration: _inputDecoration(
        label: l10n.addressLabel,
        hint: l10n.addressLabel,
        icon: Icons.pin_drop_outlined,
        alignIconTop: true,
      ),
      validator: validator,
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    bool alignIconTop = false,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Padding(
        padding: EdgeInsets.only(
          bottom: alignIconTop ? 32 : 0,
        ),
        child: Icon(icon, size: 21),
      ),
      filled: true,
      fillColor: const Color(0xFFFAFBFE),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 17,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.indigo,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.terracotta),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.terracotta,
          width: 1.5,
        ),
      ),
    );
  }
}

class _TypeChoice extends StatelessWidget {
  const _TypeChoice({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => onTap(),
      showCheckmark: true,
      selectedColor: AppColors.indigo.withValues(alpha: 0.10),
      backgroundColor: Colors.white,
      side: BorderSide(
        color: selected ? AppColors.indigo : AppColors.border,
        width: selected ? 1.5 : 1,
      ),
      labelStyle: TextStyle(
        color: selected ? AppColors.indigo : const Color(0xFF475569),
        fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
    );
  }
}
