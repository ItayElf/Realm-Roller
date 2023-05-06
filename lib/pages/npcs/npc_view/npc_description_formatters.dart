import 'package:randpg/entities/npcs.dart';
import 'package:randpg/enums/gender.dart';
import 'package:randpg/string_manipulations.dart';

String getNpcDescription(Npc npc) {
  final physical = npc.physicalDescription;
  final pronoun = npc.gender == Gender.male ? "he" : "she";
  final relPronoun = npc.gender == Gender.male ? "his" : "her";
  final firstName = titled(npc.name.split(" ").first);
  final hair = _getNpcHairDescription(npc);
  final beard = _getNpcBeardDescription(npc);

  return "${titledEach(npc.name)} is a ${npc.age} years old ${npc.gender.name} ${npc.race.getName()} "
      "${npc.occupation}. ${titled(pronoun)} has $hair,$beard "
      "${physical.eyes} eyes and a ${physical.skin} skin. "
      "$firstName stands at ${physical.height} cm with "
      "${article(physical.build)} build. "
      "${titled(relPronoun)} face is ${physical.face.split(" ").join(" and ")}.";
}

String getNpcPersonality(Npc npc) {
  final personality = npc.personality;
  final firstName = titled(npc.name.split(" ").first);
  final pronoun = npc.gender == Gender.male ? "he" : "she";
  final relPronoun = npc.gender == Gender.male ? "his" : "her";

  return "$firstName is ${personality.alignment.ethical.name} ${personality.alignment.moral.name}, "
      "and is often described as ${personality.descriptors.join(" and ")}. "
      "${titled(pronoun)} ${personality.traits.join(" and ")}.\n\n"
      "$firstName ${personality.quirks.join(" and ")}. ${titled(relPronoun)} goal is to ${npc.goal}.";
}

String _getNpcHairDescription(Npc npc) {
  final relPronoun = npc.gender == Gender.male ? "his" : "her";

  return npc.physicalDescription.hairStyle.type == "scales"
      ? "${npc.physicalDescription.hairStyle.length} scales on $relPronoun head"
      : "${npc.physicalDescription.hairStyle.length}, ${npc.physicalDescription.hairStyle.color} "
          "${npc.physicalDescription.hairStyle.type} hair";
}

String _getNpcBeardDescription(Npc npc) => npc.physicalDescription.beard == null
    ? ""
    : " ${npc.physicalDescription.beard!.length} ${npc.physicalDescription.beard!.type},";
