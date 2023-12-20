import 'package:api/bloc/characters_cubit.dart';
import 'package:api/data/api_service/CharacterApi.dart';
import 'package:api/data/models/ModelCharacter.dart';
import 'package:api/data/repository/ChararctersRepository.dart';
import 'package:api/presentation/screens/charactersDetailsScreen.dart';
import 'package:api/presentation/screens/characters_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/string.dart';

class AppRouter{

  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter(){
    charactersRepository=CharactersRepository(CharactersApi());
    charactersCubit=CharactersCubit(charactersRepository);
  }
      Route? generateRoute (RouteSettings settings){
        switch(settings.name){
          case charactersScreen:
            return MaterialPageRoute(
                builder: (_) => BlocProvider(
                create: (BuildContext context)=>charactersCubit,
                  child: CharactersScreen(),
            ),

            );

          case charactersDetailsScreen:
            final selectedItem =settings.arguments as ModelCharacters;
            return MaterialPageRoute(builder: (_) => CharactersDetailsScreen(selectedItem:selectedItem,));
        }
      }
}