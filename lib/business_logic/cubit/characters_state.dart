part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}
class CharactersLoaded extends CharactersState{
  final dynamic characters ;

  CharactersLoaded(this.characters);

}
class QuotesLoaded extends CharactersState{
  late final List<Quote> quotes ;
  QuotesLoaded(this.quotes);

}