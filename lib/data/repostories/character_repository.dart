import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/data/models/qoutes.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';
import '../web_services/characters_web_services.dart';

class CharacterRepository {
// عاوزة اباصي الدااتا الموجودة ف ال webSevicse هنا عشان ابعتها للموديل
// هعمل منها اوبجكت
  final CharactersWebServices charactersWebServices;
// هعمل منه كونستراكتور
  CharacterRepository(this.charactersWebServices);
//List<Character>
  Future<dynamic> getAllCharacters() async {
    final characters = await charactersWebServices.getAllCharacters();
    return characters.map((character) => character.fromjson(character))
        .toList();
  }
  Future<List<Quote>> getCharacterQuotes(String charName) async {
    final quotes = await charactersWebServices.getCharacterQuotes(charName);
    return quotes.map((charQuotes) => quotes.fromjson(charQuotes))
        .toList();
  }
}
