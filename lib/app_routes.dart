import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/data/repostories/character_repository.dart';
import 'package:breaking_bad/data/web_services/characters_web_services.dart';
import 'package:breaking_bad/presentation/screens/characters_details_screen.dart';
import 'package:breaking_bad/presentation/screens/charaters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/strings.dart';
import 'data/models/characters.dart';

/// ADD APP ROUTES
class AppRouter {
  late CharacterRepository characterRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    characterRepository = CharacterRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
    //   //  معني العلامة دي ( / ) جنب ال case انها ترجعني للهوم اسكرين
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider(
                create: (context) => charactersCubit,
                //CharactersCubit(characterRepository),
                child: CharactersScreen(),
              ),);
      case charactersDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => CharactersCubit(characterRepository),
              child: CharactersDetailsScreen(character: character,),
            ));

    /// if any new route founded
    // case'details_screen':
    //return MaterialPageRoute(builder:(_) =>-------------------()  );
    //   return MaterialPageRoute(builder:(_) =>اسم ال screen);
    }
  }
}
