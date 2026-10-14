/// Une ville avec les coordonnées approximatives de son centre.
/// Provisoire : sera remplacé par le choix précis sur la carte.
class NigerCity {
  const NigerCity(this.name, this.latitude, this.longitude);

  final String name;
  final double latitude;
  final double longitude;
}

const nigerCities = [
  NigerCity('Niamey', 13.5116, 2.1254),
  NigerCity('Zinder', 13.8069, 8.9881),
  NigerCity('Maradi', 13.5000, 7.1017),
  NigerCity('Agadez', 16.9742, 7.9911),
  NigerCity('Tahoua', 14.8888, 5.2692),
  NigerCity('Dosso', 13.0490, 3.1937),
  NigerCity('Tillabéri', 14.2108, 1.4531),
  NigerCity('Diffa', 13.3154, 12.6113),
];