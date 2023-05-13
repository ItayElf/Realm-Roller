import 'package:flutter/material.dart';
import 'package:randpg/entities/deities.dart';
import 'package:randpg/enums/gender.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/image_path_finders.dart';
import 'package:realm_roller/custom_widgets/entity_pages/entity_page.dart';
import 'package:realm_roller/custom_widgets/expanded_paragraphs/expanded_paragraph.dart';

/// A view that features a deity
class DeityView extends StatelessWidget {
  const DeityView({super.key, required this.deity});

  final Deity deity;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: EntityPage(
          title: deity.name,
          subtitle: subtitle,
          imagePath: getDeityImage(deity.deityType),
          children: [
            const SizedBox(height: 18),
            SelectableText(
              description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            ExpandedParagraph(
              title: "Domains",
              icon: Icons.auto_awesome,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: deity.domains
                    .map((domain) => getDomainText(domain, context))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column getDomainText(String domain, BuildContext context) {
    return Column(
      children: [
        SelectableText(
          "\u2022\t${titled(domain)}",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  String get possessive => deity.gender == null
      ? "it"
      : deity.gender == Gender.male
          ? "him"
          : "her";

  String get relPronoun => deity.gender == null
      ? "its"
      : deity.gender == Gender.male
          ? "his"
          : "her";

  String get worshipers => deity.worshipedBy == null
      ? "worshipers with no particular race"
      : "${deity.worshipedBy!.getAdjective()} worshipers";

  String get description =>
      "${deity.name} is often depicted as ${deity.depiction}.\n\n"
      "${titled(deity.worshipers)} $worshipers worship ${deity.name} and $relPronoun shrines ${deity.shrinesRarity}.\n\n"
      "${deity.name} is described as ${deity.positiveAttribute} by those who worship $possessive and as ${deity.negativeAttribute} "
      "by those who oppose $possessive.";

  String get alignment => deity.alignment == null
      ? "Unaligned"
      : titled(
          "${deity.alignment!.ethical.name} ${deity.alignment!.moral.name}");

  String get subtitle =>
      "$alignment ${deity.deityType.getDeityTitle(deity.gender)}";
}
