import 'package:bloc/bloc.dart';
import 'package:breaking_bad/data/models/characters.dart';
import 'package:breaking_bad/data/models/qoutes.dart';
import 'package:breaking_bad/data/repostories/character_repository.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  dynamic characters=[];
  CharactersCubit(this.characterRepository) : super(CharactersInitial());


  dynamic getAllCharacters() {
    characterRepository.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }
  void getQuotes(String charName) {
    characterRepository.getCharacterQuotes(charName).then((quotes) {
      emit(QuotesLoaded(quotes));

    });
  }



}
