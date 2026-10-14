import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wuri_client/wuri_client.dart';

import 'package:wuri_flutter/client.dart';
import 'package:wuri_flutter/providers/auth_providers.dart';

/// Mes réservations (côté client).
final myBookingsProvider =
    FutureProvider.autoDispose<List<MyBooking>>((ref) async {
  if (!ref.watch(signedInProvider)) return [];
  return client.booking.listMyBookings();
});

/// Les demandes reçues pour mes espaces (côté hôte).
final hostRequestsProvider =
    FutureProvider.autoDispose<List<HostBookingRequest>>((ref) async {
  if (!ref.watch(signedInProvider)) return [];
  return client.hostBooking.listRequests();
});