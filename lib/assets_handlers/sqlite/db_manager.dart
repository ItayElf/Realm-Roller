import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// A class that manages the database of the saved assets
class DBManager {
  static const String _databaseName = "saved_assets.db";

  static late Database _database;

  static Database get database => _database;

  static Future<void> initDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: _createDatabaseTables,
      version: 1,
    );
  }

  static Future _createDatabaseTables(Database db, int version) async {
    for (final instruction in _createTableInstructions.split(";")) {
      if (instruction.isNotEmpty) {
        await db.execute(instruction);
      }
    }
  }

  static const _createTableInstructions =
      """CREATE TABLE IF NOT EXISTS emblems (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    emblem_data TEXT NOT NULL,
    isSaved BOOLEAN NOT NULL,
    isSavedByParent BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS settlements (
    name TEXT PRIMARY KEY NOT NULL,
    settlementType TEXT NOT NULL,
    dominantRace TEXT,
    description TEXT NOT NULL,
    dominantOccupation TEXT,
    population INTEGER NOT NULL,
    trouble TEXT NOT NULL,
    importantIn TEXT REFERENCES kingdoms(name),
    isSaved BOOLEAN NOT NULL,
    isSavedByParent BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS npcs (
    name TEXT PRIMARY KEY NOT NULL,
    age INTEGER NOT NULL,
    gender TEXT NOT NULL,
    race TEXT NOT NULL,
    occupation TEXT NOT NULL,
    hairstyleLength TEXT NOT NULL,
    hairstyleType TEXT NOT NULL,
    hairstyleColor TEXT NOT NULL,
    eyes TEXT NOT NULL,
    skin TEXT NOT NULL,
    height INTEGER NOT NULL,
    build TEXT NOT NULL,
    face TEXT NOT NULL,
    beardLength TEXT,
    beardType TEXT,
    beardColor TEXT,
    specialFeatures TEXT NOT NULL,
    alignmentEthical TEXT NOT NULL,
    alignmentMoral TEXT NOT NULL,
    traits TEXT NOT NULL,
    quirks TEXT NOT NULL,
    descriptors TEXT NOT NULL,
    goal TEXT NOT NULL,
    importantIn TEXT REFERENCES settlements(name),
    notableMemberOf TEXT REFERENCES guilds(name),
    rulerOf TEXT REFERENCES kingdoms(name),
    importantInWorld TEXT REFERENCES worlds(name),
    isSaved BOOLEAN NOT NULL,
    isSavedByParent BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS names (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    names TEXT NOT NULL,
    imagePath TEXT NOT NULL,
    description TEXT NOT NULL,
    isSaved BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS settlement_names (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    names TEXT NOT NULL,
    imagePath TEXT NOT NULL,
    description TEXT NOT NULL,
    isSaved BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS locations (
    name TEXT PRIMARY KEY NOT NULL,
    owner_name TEXT NOT NULL REFERENCES npcs(name),
    type TEXT NOT NULL,
    zone TEXT NOT NULL,
    outsideDescription TEXT NOT NULL,
    buildingDescription TEXT NOT NULL,
    goods TEXT NOT NULL,
    locatedIn TEXT REFERENCES settlements(name),
    isSaved BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS landscapes (
    name TEXT PRIMARY KEY NOT NULL,
    location TEXT NOT NULL,
    weather TEXT NOT NULL,
    landscapeType TEXT NOT NULL,
    features TEXT NOT NULL,
    resources TEXT NOT NULL,
    encounters TEXT NOT NULL,
    knownFor TEXT NOT NULL,
    size TEXT NOT NULL,
    travelRate TEXT NOT NULL,
    locatedIn TEXT REFERENCES worlds(name),
    isSaved BOOLEAN NOT NULL,
    isSavedByParent BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS deities (
    name TEXT PRIMARY KEY NOT NULL,
    gender TEXT,
    deityType TEXT NOT NULL,
    domains TEXT NOT NULL,
    alignmentEthical TEXT,
    alignmentMoral TEXT,
    depiction TEXT NOT NULL,
    worshipedBy TEXT,
    worshipers TEXT NOT NULL,
    shrinesRarity TEXT NOT NULL,
    positiveAttribute TEXT NOT NULL,
    negativeAttribute TEXT NOT NULL,
    deityIn TEXT REFERENCES worlds(name),
    lesserDeityIn TEXT REFERENCES worlds(name),
    higherDeityIn TEXT REFERENCES worlds(name),
    isSaved BOOLEAN NOT NULL,
    isSavedByParent BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS guilds (
    name TEXT PRIMARY KEY NOT NULL,
    leader_name TEXT NOT NULL REFERENCES npcs(name),
    guildType TEXT NOT NULL,
    reputation TEXT NOT NULL,
    history TEXT NOT NULL,
    emblem_id INTEGER NOT NULL REFERENCES emblems(id),
    motto TEXT NOT NULL,
    specialties TEXT NOT NULL,
    quests TEXT NOT NULL,
    locatedIn TEXT REFERENCES kingdoms(name),
    locatedInWorld TEXT REFERENCES worlds(name),
    isSaved BOOLEAN NOT NULL,
    isSavedByParent BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS kingdoms (
    name TEXT PRIMARY KEY NOT NULL,
    kingdomType TEXT NOT NULL,
    race TEXT NOT NULL,
    population INTEGER NOT NULL,
    capitalName TEXT NOT NULL REFERENCES settlements(name),
    governmentType TEXT NOT NULL,
    emblem_id INTEGER NOT NULL REFERENCES emblems(id),
    knownFor TEXT NOT NULL,
    history TEXT NOT NULL,
    trouble TEXT NOT NULL,
    locatedIn TEXT REFERENCES worlds(name),
    isSaved BOOLEAN NOT NULL,
    isSavedByParent BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS worlds (
    name TEXT PRIMARY KEY NOT NULL,
    worldSettings TEXT NOT NULL,
    opinions TEXT NOT NULL,
    worldLore TEXT NOT NULL,
    isSaved BOOLEAN NOT NULL
);""";
}
