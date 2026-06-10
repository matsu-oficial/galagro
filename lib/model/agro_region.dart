class AgroRegion {
  final String id;
  final String name;
  final String city;
  final String farmName;
  final String producerName;
  final String cropName;
  final String publicRecommendation;
  final String producerGuidance;
  final double areaInHectares;
  final String climateRisk;
  final String severity;
  final String regionStatus;
  final int soilHumidityPercent;
  final double ndvi;
  final int estimatedRainfallMm;
  final int estimatedTemperatureCelsius;
  final String riskWindow;
  final int impactedProducers;

  const AgroRegion({
    required this.id,
    required this.name,
    required this.city,
    required this.farmName,
    required this.producerName,
    required this.cropName,
    required this.publicRecommendation,
    required this.producerGuidance,
    required this.areaInHectares,
    required this.climateRisk,
    required this.severity,
    required this.regionStatus,
    required this.soilHumidityPercent,
    required this.ndvi,
    required this.estimatedRainfallMm,
    required this.estimatedTemperatureCelsius,
    required this.riskWindow,
    required this.impactedProducers,
  });

  String get formattedArea => '${areaInHectares.toStringAsFixed(1)} ha';
  String get formattedNdvi => ndvi.toStringAsFixed(2);
  String get formattedRainfall => '$estimatedRainfallMm mm';
  String get formattedTemperature => '$estimatedTemperatureCelsius °C';
}
