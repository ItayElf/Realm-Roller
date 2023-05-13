import 'package:randpg/entities/races.dart';
import 'package:randpg/entities/settlements.dart';

String getRaceImage(Race race) => "assets/races/${race.getName()}.webp";

String getLocationImage(Location location) =>
    "assets/locations/${location.type.getLocationType()}.webp";

String getSettlementImage(Settlement settlement) =>
    "assets/settlements/${settlement.settlementType.getSettlementType()}.webp";
