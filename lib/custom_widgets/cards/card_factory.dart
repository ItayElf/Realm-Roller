import 'package:randpg/entities/companions.dart';
import 'package:randpg/entities/deities.dart';
import 'package:randpg/entities/emblems.dart';
import 'package:randpg/entities/guilds.dart';
import 'package:randpg/entities/kingdoms.dart';
import 'package:randpg/entities/landscapes.dart';
import 'package:randpg/entities/npcs.dart';
import 'package:randpg/entities/settlements.dart';
import 'package:randpg/entities/worlds.dart';
import 'package:realm_roller/custom_widgets/cards/companions/companion_card.dart';
import 'package:realm_roller/custom_widgets/cards/deities/deity_card.dart';
import 'package:realm_roller/custom_widgets/cards/emblems/emblem_card.dart';
import 'package:realm_roller/custom_widgets/cards/entity_card.dart';
import 'package:realm_roller/custom_widgets/cards/guilds/guild_card.dart';
import 'package:realm_roller/custom_widgets/cards/kingdoms/kingdom_card.dart';
import 'package:realm_roller/custom_widgets/cards/landscapes/landscape_card.dart';
import 'package:realm_roller/custom_widgets/cards/locations/location_card.dart';
import 'package:realm_roller/custom_widgets/cards/names/name_data_card.dart';
import 'package:realm_roller/custom_widgets/cards/npcs/npc_card.dart';
import 'package:realm_roller/custom_widgets/cards/settlements/settlement_card.dart';
import 'package:realm_roller/custom_widgets/cards/worlds/world_card.dart';
import 'package:realm_roller/extensions/entities/names_data.dart';

EntityCard getCardFromEntity(dynamic entity, double size) {
  if (entity is Npc) {
    return NpcCard(size: size, npc: entity);
  } else if (entity is Location) {
    return LocationCard(size: size, location: entity);
  } else if (entity is Settlement) {
    return SettlementCard(size: size, settlement: entity);
  } else if (entity is Landscape) {
    return LandscapeCard(size: size, landscape: entity);
  } else if (entity is Deity) {
    return DeityCard(size: size, deity: entity);
  } else if (entity is Guild) {
    return GuildCard(size: size, guild: entity);
  } else if (entity is Kingdom) {
    return KingdomCard(size: size, kingdom: entity);
  } else if (entity is Emblem) {
    return EmblemCard(size: size, emblem: entity);
  } else if (entity is World) {
    return WorldCard(size: size, world: entity);
  } else if (entity is NamesData) {
    return NamesCard(size: size, namesData: entity);
  } else if (entity is Companion) {
    return CompanionCard(size: size, companion: entity);
  }
  throw Exception("No entity card from type ${entity.runtimeType}");
}
