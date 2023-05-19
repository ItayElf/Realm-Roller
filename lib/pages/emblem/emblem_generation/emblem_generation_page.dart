import 'package:flutter/material.dart';
import 'package:randpg/entities/emblems.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/emblem/emblem_view/emblem_view.dart';

class EmblemGenerationPage extends StatelessWidget {
  const EmblemGenerationPage({super.key});

  void onGenerate(BuildContext context) {
    final emblem = EmblemGenerator(const DefaultEmblemType()).generate();

    Navigator.of(context).push(buildRoute(EmblemView(emblem: emblem)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: GeneratorPage(
          title: "Emblem Generator",
          onGenerate: () => onGenerate(context),
          children: [
            Text.rich(
              TextSpan(
                text: "No options to choose from, just click!",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: const Color(0xFF9D9D9D),
                    ),
                children: const [
                  WidgetSpan(child: SizedBox(width: 16)),
                  WidgetSpan(
                    child: Icon(
                      Icons.auto_awesome,
                      size: 36,
                      color: Color(0xFF9D9D9D),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
