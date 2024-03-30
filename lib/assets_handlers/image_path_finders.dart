import 'package:randpg/entities/companions.dart';
import 'package:randpg/entities/deities.dart';
import 'package:randpg/entities/emblems.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/entities/kingdoms.dart';
import 'package:randpg/entities/landscapes.dart';
import 'package:randpg/entities/locations.dart';
import 'package:randpg/entities/races.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/entities/worlds.dart';

String getRaceImage(Race race) => "assets/races/${race.getName()}.webp";

String getLocationImage(LocationType location) =>
    "assets/locations/${location.getLocationType()}.webp";

String getSettlementImage(SettlementType settlement) =>
    "assets/settlements/${settlement.getSettlementType()}.webp";

String getLandscapeImage(LandscapeType landscape) =>
    "assets/landscapes/${landscape.getLandscapeType()}.webp";

String getDeityImage(DeityType deity) =>
    "assets/deities/${deity.getDeityType()}.webp";

String getGuildImage(GuildType guild) =>
    "assets/guilds/${guild.getGuildType()}.webp";

String getKingdomImage(GovernmentType government) =>
    "assets/kingdoms/${government.getGovernmentType()}.webp";

String getEmblemImage(Emblem emblem) => "assets/emblems/background.webp";

String getWorldImage(World world) => "assets/worlds/world.webp";

String getCompanionImage(CompanionType companion) =>
    "assets/companions/${companion.getCompanionType()}.webp";
