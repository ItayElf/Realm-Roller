import 'package:flutter/material.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/string_manipulations.dart';

/// A card for a location goods
class LocationGoodsCard extends StatelessWidget {
  const LocationGoodsCard({super.key, required this.goods});

  final Goods goods;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFB4236), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SelectableText(
            titledEach(goods.name),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (goods.description != null && goods.description!.isNotEmpty) ...[
            SelectableText(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
          ],
          if (goods.price != null && goods.price!.isNotEmpty)
            SelectableText(
              "Price: ${goods.price}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
        ],
      ),
    );
  }

  String get description =>
      goods.description!.split(". ").map(titled).join(". ");
}
