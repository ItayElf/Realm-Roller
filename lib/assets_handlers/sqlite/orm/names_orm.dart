import 'dart:convert';

import 'package:realm_roller/assets_handlers/sqlite/db_manager.dart';
import 'package:realm_roller/assets_handlers/sqlite/orm/saveable_entity.dart';
import 'package:realm_roller/extensions/entities/names_data.dart';

/// Orm for names and settlement names
class NamesOrm {
  static const _nameTable = "names";
  static const _settlementNamesTable = "settlement_names";

  static Future<int> insertNames(SaveableEntity<NamesData> names) async {
    return await DBManager.database.insert(_nameTable, _getNamesMap(names));
  }

  static Future<int> insertSettlementNames(
    SaveableEntity<SettlementNamesData> names,
  ) async {
    return await DBManager.database
        .insert(_settlementNamesTable, _getNamesMap(names));
  }

  static Future<void> updateNames(
      int id, SaveableEntity<NamesData> newNames) async {
    await DBManager.database.update(
      _nameTable,
      _getNamesMap(newNames),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> updateSettlementNames(
      int id, SaveableEntity<SettlementNamesData> newNames) async {
    await DBManager.database.update(
      _settlementNamesTable,
      _getNamesMap(newNames),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteNames(int id) async {
    await DBManager.database.delete(
      _nameTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<void> deleteSettlementNames(int id) async {
    await DBManager.database.delete(
      _settlementNamesTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  static Future<List<SaveableEntity<NamesData>>> getSavedNames() =>
      _getSavedNamesByTable(_nameTable);

  static Future<List<SaveableEntity<NamesData>>> getSavedSettlementNames() =>
      _getSavedNamesByTable(_settlementNamesTable);

  static Future<List<SaveableEntity<NamesData>>> _getSavedNamesByTable(
      String table) async {
    final result = await DBManager.database.query(
      table,
      where: "isSaved = ?",
      whereArgs: [1],
    );

    return List.generate(
      result.length,
      (i) {
        final map = Map<String, dynamic>.from(result[i]);
        map["names"] = jsonDecode(map["names"] as String);
        return SaveableEntity(
          entity: NamesData.fromMap(map),
          isSaved: map["isSaved"] != 0,
          isSavedByParent: false,
          id: map["id"] as int,
        );
      },
    );
  }

  static Map<String, dynamic> _getNamesMap(SaveableEntity<NamesData> names) {
    final map = names.entity.toMap();
    map["isSaved"] = names.isSaved ? 1 : 0;
    map["names"] = jsonEncode(names.entity.names);
    return map;
  }
}
