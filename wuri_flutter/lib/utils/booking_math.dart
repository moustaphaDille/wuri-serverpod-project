/// Ne garde que l'année, le mois et le jour, en UTC.
/// Le serveur raisonne en dates UTC : on envoie donc des dates UTC.
DateTime utcDate(DateTime d) => DateTime.utc(d.year, d.month, d.day);

/// Nombre de nuits entre l'arrivée et le départ (même règle que le serveur).
int nightsBetween(DateTime checkIn, DateTime checkOut) {
  return utcDate(checkOut).difference(utcDate(checkIn)).inDays;
}