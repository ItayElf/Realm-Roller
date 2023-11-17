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
    emblemData TEXT NOT NULL,
    isSaved INTEGER NOT NULL,
    isSavedByParent INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS settlements (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    settlementType TEXT NOT NULL,
    dominantRace TEXT,
    description TEXT NOT NULL,
    dominantOccupation TEXT,
    population INTEGER NOT NULL,
    trouble TEXT NOT NULL,
    importantIn INTEGER REFERENCES kingdoms(id) ON DELETE CASCADE,
    isSaved INTEGER NOT NULL,
    isSavedByParent INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS npcs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
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
    importantIn INTEGER REFERENCES settlements(id) ON DELETE CASCADE,
    notableMemberOf INTEGER REFERENCES guilds(id) ON DELETE CASCADE,
    rulerOf INTEGER REFERENCES kingdoms(id) ON DELETE CASCADE,
    importantInWorld INTEGER REFERENCES worlds(id) ON DELETE CASCADE,
    isSaved INTEGER NOT NULL,
    isSavedByParent INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS names (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    names TEXT NOT NULL,
    imagePath TEXT NOT NULL,
    description TEXT NOT NULL,
    isSaved INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS settlement_names (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    names TEXT NOT NULL,
    imagePath TEXT NOT NULL,
    description TEXT NOT NULL,
    isSaved INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS locations (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    ownerId INTEGER NOT NULL REFERENCES npcs(id) ON DELETE CASCADE,
    type TEXT NOT NULL,
    zone TEXT NOT NULL,
    outsideDescription TEXT NOT NULL,
    buildingDescription TEXT NOT NULL,
    goods TEXT NOT NULL,
    locatedIn INTEGER REFERENCES settlements(id) ON DELETE CASCADE,
    isSaved INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS landscapes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    location TEXT NOT NULL,
    weather TEXT NOT NULL,
    landscapeType TEXT NOT NULL,
    features TEXT NOT NULL,
    resources TEXT NOT NULL,
    encounters TEXT NOT NULL,
    knownFor TEXT NOT NULL,
    size TEXT NOT NULL,
    travelRate TEXT NOT NULL,
    locatedIn INTEGER REFERENCES worlds(id) ON DELETE CASCADE,
    isSaved INTEGER NOT NULL,
    isSavedByParent INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS deities (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
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
    deityIn INTEGER REFERENCES worlds(id) ON DELETE CASCADE,
    lesserDeityIn INTEGER REFERENCES worlds(id) ON DELETE CASCADE,
    higherDeityIn INTEGER REFERENCES worlds(id) ON DELETE CASCADE,
    isSaved INTEGER NOT NULL,
    isSavedByParent INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS guilds (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    leaderId INTEGER NOT NULL REFERENCES npcs(id) ON DELETE CASCADE,
    guildType TEXT NOT NULL,
    reputation TEXT NOT NULL,
    history TEXT NOT NULL,
    emblemId INTEGER NOT NULL REFERENCES emblems(id) ON DELETE CASCADE,
    motto TEXT NOT NULL,
    specialties TEXT NOT NULL,
    quests TEXT NOT NULL,
    locatedIn INTEGER REFERENCES kingdoms(id) ON DELETE CASCADE,
    locatedInWorld INTEGER REFERENCES worlds(id) ON DELETE CASCADE,
    isSaved INTEGER NOT NULL,
    isSavedByParent INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS kingdoms (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    kingdomType TEXT NOT NULL,
    race TEXT NOT NULL,
    population INTEGER NOT NULL,
    capitalId INTEGER NOT NULL REFERENCES settlements(id) ON DELETE CASCADE,
    governmentType TEXT NOT NULL,
    emblemId INTEGER NOT NULL REFERENCES emblems(id) ON DELETE CASCADE,
    knownFor TEXT NOT NULL,
    history TEXT NOT NULL,
    trouble TEXT NOT NULL,
    locatedIn TEXT REFERENCES worlds(name) ON DELETE CASCADE,
    isSaved INTEGER NOT NULL,
    isSavedByParent INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS worlds (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    worldSettings TEXT NOT NULL,
    opinions TEXT NOT NULL,
    worldLore TEXT NOT NULL,
    isSaved INTEGER NOT NULL
);""";
}
