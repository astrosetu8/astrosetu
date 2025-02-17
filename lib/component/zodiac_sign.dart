import 'dart:io';

String getZodiacSign(String name) {
  // Mapping of syllables to zodiac signs
  Map<String, String> zodiacMap = {
    // Aries
    "Chu": "Aries", "Che": "Aries", "Cho": "Aries", "La": "Aries",
    "Lee": "Aries", "Lu": "Aries", "Le": "Aries", "Lo": "Aries", "A": "Aries",

    // Taurus
    "Ee": "Taurus", "U": "Taurus", "Aa": "Taurus", "O": "Taurus",
    "Va": "Taurus", "Vi": "Taurus", "Vu": "Taurus", "Ve": "Taurus", "Vo": "Taurus",

    // Gemini
    "Ka": "Gemini", "Kee": "Gemini", "Ku": "Gemini", "Gha": "Gemini",
    "D": "Gemini", "Chha": "Gemini", "Ke": "Gemini", "Ko": "Gemini", "Ha": "Gemini",

    // Cancer
    "Hee": "Cancer", "Hoo": "Cancer", "He": "Cancer", "Ho": "Cancer",
    "Da": "Cancer", "Dee": "Cancer", "Doo": "Cancer", "De": "Cancer", "Do": "Cancer",

    // Leo
    "Maa": "Leo", "Mee": "Leo", "Moo": "Leo", "Me": "Leo", "Mo": "Leo",
    "Ta": "Leo", "Tee": "Leo", "Too": "Leo", "Te": "Leo",

    // Virgo
    "To": "Virgo", "Pa": "Virgo", "Pee": "Virgo", "Poo": "Virgo",
    "Sha": "Virgo", "Na": "Virgo", "Tha": "Virgo", "Pe": "Virgo", "Po": "Virgo",

    // Libra
    "Ra": "Libra", "Ree": "Libra", "Ru": "Libra", "Re": "Libra",
    "Ro": "Libra", "Ta": "Libra", "Tee": "Libra", "Tu": "Libra", "Te": "Libra",

    // Scorpio
    "To": "Scorpio", "Na": "Scorpio", "Nee": "Scorpio", "Nu": "Scorpio",
    "Ne": "Scorpio", "No": "Scorpio", "Ya": "Scorpio", "Ye": "Scorpio", "Yu": "Scorpio",

    // Sagittarius
    "Ye": "Sagittarius", "Yo": "Sagittarius", "Bha": "Sagittarius", "Bhee": "Sagittarius",
    "Bhu": "Sagittarius", "Dha": "Sagittarius", "Pha": "Sagittarius", "Bhe": "Sagittarius",

    // Capricorn
    "Bho": "Capricorn", "Ja": "Capricorn", "Jee": "Capricorn", "Ju": "Capricorn",
    "Je": "Capricorn", "Jo": "Capricorn", "Kha": "Capricorn", "Khi": "Capricorn",
    "Khu": "Capricorn", "Khe": "Capricorn", "Kho": "Capricorn", "Ga": "Capricorn", "Gi": "Capricorn",

    // Aquarius
    "Goo": "Aquarius", "Ge": "Aquarius", "Go": "Aquarius", "Sa": "Aquarius",
    "See": "Aquarius", "Su": "Aquarius", "Se": "Aquarius", "So": "Aquarius", "Da": "Aquarius",

    // Pisces
    "Di": "Pisces", "Du": "Pisces", "Th": "Pisces", "Jh": "Pisces",
    "Yn": "Pisces", "De": "Pisces", "Do": "Pisces", "Cha": "Pisces", "Chi": "Pisces",
  };

  // Extract the first two letters or first syllable from the name
  for (var key in zodiacMap.keys) {
    if (name.toLowerCase().startsWith(key.toLowerCase())) {
      return zodiacMap[key]!;
    }
  }

  return "Unknown"; // If no matching zodiac sign is found
}

void main() {
  print("Enter your name:");
  String name = stdin.readLineSync()!.trim();

  String zodiacSign = getZodiacSign(name);
  print("Your zodiac sign is: $zodiacSign");
}
