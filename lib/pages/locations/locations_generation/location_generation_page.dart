import 'package:flutter/material.dart';
import 'package:randpg/entities/locations.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/enums/gender.dart';
import 'package:randpg/generators.dart';
import 'package:randpg/string_manipulations.dart';
import 'package:realm_roller/assets_handlers/custom_icons.dart';
import 'package:realm_roller/custom_widgets/generator_pages/generator_page.dart';
import 'package:realm_roller/custom_widgets/route_builder/route_builder.dart';
import 'package:realm_roller/pages/locations/location_view/location_view.dart';
import 'package:realm_roller/pages/names/names_view/names_view.dart';

import '../../../custom_widgets/dropdowns/dropdown.dart';

/// The page for generating locations
class LocationGenerationPage extends StatefulWidget {
  const LocationGenerationPage({super.key});

  @override
  State<LocationGenerationPage> createState() => _LocationGenerationPageState();
}

class _LocationGenerationPageState extends State<LocationGenerationPage> {
  String currentLocation = "Random";
  String currentRace = "Random";

  void onGenerate(BuildContext context) {
    final locationType = currentLocation == "Random"
        ? ListItemGenerator(LocationManager.activeLocationTypes).generate()
        : LocationManager.getLocationTypeByType(currentLocation.toLowerCase());

    final race = currentRace == "Random"
        ? ListItemGenerator(RaceManager.activeRaces).generate()
        : RaceManager.getRaceByName(currentRace.toLowerCase());

    final location = LocationGenerator(locationType, race).generate();

    Navigator.of(context).push(buildRoute(
      LocationView(
        location: location,
      ),
    ));
  }

  void onLocationChange(String? value) {
    setState(() {
      currentLocation = value ?? currentLocation;
    });
  }

  void onRaceChange(String? value) {
    setState(() {
      currentRace = value ?? currentRace;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: GeneratorPage(
          title: "Locations Generator",
          onGenerate: () => onGenerate(context),
          children: [
            Dropdown(
              title: "Location:",
              icon: Icons.location_on,
              currentValue: currentLocation,
              onChanged: onLocationChange,
              options: [
                "Random",
                ...LocationManager.activeLocationTypes
                    .map((e) => titledEach(e.getLocationType()))
              ],
            ),
            const SizedBox(height: 28),
            Dropdown(
              title: "Owner Race:",
              icon: Icons.groups,
              currentValue: currentRace,
              onChanged: onRaceChange,
              options: [
                "Random",
                ...RaceManager.activeRaces.map((e) => titledEach(e.getName()))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
