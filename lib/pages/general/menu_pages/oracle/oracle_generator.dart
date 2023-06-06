import 'package:randpg/generators.dart';

enum OracleOdds {
  almostCertain,
  likely,
  equallyLikely,
  unlikely,
  smallChance,
}

class OracleGenerator implements IGenerator<String> {
  late int _seed;
  final OracleOdds odds;

  static const oddsToThresholds = {
    OracleOdds.almostCertain: 10,
    OracleOdds.likely: 25,
    OracleOdds.equallyLikely: 50,
    OracleOdds.unlikely: 75,
    OracleOdds.smallChance: 90,
  };

  OracleGenerator(this.odds) {
    _seed = SeedGenerator.generate();
  }

  @override
  String generate() {
    final threshold = oddsToThresholds[odds]!;

    final diceResultGenerator = NumberGenerator(1, 101);
    diceResultGenerator.seed(_seed);
    final diceResult = diceResultGenerator.generate();

    String result = diceResult > threshold ? "yes" : "no";

    if (diceResult ~/ 10 == diceResult % 10) {
      result = "exceptional $result";
    }

    return result;
  }

  @override
  void seed(int seed) {
    _seed = seed;
  }
}
