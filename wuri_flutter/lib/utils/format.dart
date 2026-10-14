//import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// Formate un prix avec des espaces : 35000 devient "35 000".
String formatPrice(int value) {
  return value.toString().replaceAllMapped(
        RegExp(r'\B(?=(\d{3})+(?!\d))'),
        (_) => '\u00A0',
      );
}

/// Formate une date selon la langue de l'app (par exemple "12 nov. 2026").
String formatDate(BuildContext context, DateTime date) {
  final locale = Localizations.localeOf(context).toString();
  return DateFormat.yMMMd(locale).format(date);
}