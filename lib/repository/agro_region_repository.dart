import 'package:galagro/model/agro_region.dart';

const AgroRegion coffeeBeltRegion = AgroRegion(
  id: 'cafeeiro',
  name: 'Cinturão Cafeeiro',
  city: 'Franca/SP',
  farmName: 'Fazenda Boa Vista',
  producerName: 'João Ferreira',
  cropName: 'Café arábica',
  publicRecommendation:
      'Acionar a equipe municipal para vistoria preventiva, orientar o escalonamento da colheita e atualizar o boletim regional antes do próximo pico de chuva.',
  producerGuidance:
      'Reforçar a drenagem entre linhas, suspender a aplicação foliar nas próximas horas e revisar talhões com histórico de encharcamento.',
  areaInHectares: 12.5,
  climateRisk: 'Chuva intensa',
  severity: 'Crítico',
  regionStatus: 'Atenção',
  soilHumidityPercent: 78,
  ndvi: 0.68,
  estimatedRainfallMm: 42,
  estimatedTemperatureCelsius: 23,
  riskWindow: 'Próximas 24h',
  impactedProducers: 7,
);

const AgroRegion northRuralRegion = AgroRegion(
  id: 'norte',
  name: 'Zona Rural Norte',
  city: 'Ribeirão Preto/SP',
  farmName: 'Sítio Santa Helena',
  producerName: 'Marcos Almeida',
  cropName: 'Soja',
  publicRecommendation:
      'Manter alerta ativo com a rede municipal, priorizar visitas nas propriedades sem sombreamento e reforçar o aviso de estresse térmico para as próximas 48 horas.',
  producerGuidance:
      'Concentrar manejo no início da manhã, revisar a disponibilidade hídrica dos reservatórios e evitar pulverização no período de maior insolação.',
  areaInHectares: 28,
  climateRisk: 'Calor extremo',
  severity: 'Alto',
  regionStatus: 'Monitoramento ativo',
  soilHumidityPercent: 34,
  ndvi: 0.58,
  estimatedRainfallMm: 4,
  estimatedTemperatureCelsius: 36,
  riskWindow: 'Próximas 48h',
  impactedProducers: 10,
);

const AgroRegion southFarmRegion = AgroRegion(
  id: 'sul',
  name: 'Área Agrícola Sul',
  city: 'Ribeirão Preto/SP',
  farmName: 'Fazenda Três Ipês',
  producerName: 'Ana Souza',
  cropName: 'Milho',
  publicRecommendation:
      'Monitorar a disponibilidade de água nas comunidades atendidas, priorizar comunicação com produtores de sequeiro e revisar o plano local de resposta à estiagem.',
  producerGuidance:
      'Antecipar a checagem da umidade do solo, revisar a estratégia de irrigação suplementar e registrar sinais de enrolamento foliar nos talhões mais expostos.',
  areaInHectares: 18.7,
  climateRisk: 'Seca',
  severity: 'Moderado',
  regionStatus: 'Em análise',
  soilHumidityPercent: 26,
  ndvi: 0.61,
  estimatedRainfallMm: 0,
  estimatedTemperatureCelsius: 33,
  riskWindow: 'Próximos 3 dias',
  impactedProducers: 5,
);

List<AgroRegion> getAllMonitoredRegions() {
  return const [coffeeBeltRegion, northRuralRegion, southFarmRegion];
}

AgroRegion? getRegionById(String regionId) {
  for (final region in getAllMonitoredRegions()) {
    if (region.id == regionId) {
      return region;
    }
  }
  return null;
}
