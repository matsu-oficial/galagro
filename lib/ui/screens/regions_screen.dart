import 'package:flutter/material.dart';
import 'package:galagro/model/agro_region.dart';
import 'package:galagro/ui/components/region_list_card.dart';
import 'package:galagro/ui/components/sim_note.dart';
import 'package:galagro/ui/theme/responsive_layout.dart';

class RegionsScreen extends StatelessWidget {
  final List<AgroRegion> regions;
  final ValueChanged<AgroRegion> onOpenRegion;

  const RegionsScreen({
    super.key,
    required this.regions,
    required this.onOpenRegion,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveContent(
      child: ListView(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: SimNote(text: 'Base demonstrativa de áreas agrícolas'),
          ),
          const SizedBox(height: 12),
          ...regions.map(
            (region) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: RegionListCard(region: region, onTap: onOpenRegion),
            ),
          ),
        ],
      ),
    );
  }
}
