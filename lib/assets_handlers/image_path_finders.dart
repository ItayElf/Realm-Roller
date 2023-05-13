import 'package:randpg/entities/locations.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/entities/settlements.dart';

String getRaceImage(Race race) => "assets/races/${race.getName()}.webp";

String getLocationImage(LocationType location) =>
    "assets/locations/${location.getLocationType()}.webp";

String getSettlementImage(SettlementType settlement) =>
    "assets/settlements/${settlement.getSettlementType()}.webp";
