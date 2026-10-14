// Règles métier des réservations.
// Ce sont des fonctions pures : elles ne touchent pas à la base de données,
// donc elles sont faciles à tester.

/// Ne garde que la date (année, mois, jour) en UTC, sans l'heure.
DateTime dateOnly(DateTime d) {
  final u = d.toUtc();
  return DateTime.utc(u.year, u.month, u.day);
}

/// Nombre de nuits entre l'arrivée et le départ.
int nightsBetween(DateTime checkIn, DateTime checkOut) {
  return dateOnly(checkOut).difference(dateOnly(checkIn)).inDays;
}

/// Deux séjours se chevauchent si chacun commence avant la fin de l'autre.
/// Un départ le jour de l'arrivée d'un autre n'est PAS un chevauchement.
bool datesOverlap(
  DateTime aCheckIn,
  DateTime aCheckOut,
  DateTime bCheckIn,
  DateTime bCheckOut,
) {
  return dateOnly(aCheckIn).isBefore(dateOnly(bCheckOut)) &&
      dateOnly(aCheckOut).isAfter(dateOnly(bCheckIn));
}

/// Prix total en FCFA (entier).
int computeTotal(int pricePerNight, int nights) => pricePerNight * nights;