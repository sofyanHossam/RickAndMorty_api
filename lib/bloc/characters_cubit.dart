import 'package:api/data/models/ModelCharacter.dart';
import 'package:api/data/repository/ChararctersRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {

  final CharactersRepository charactersRepository;
  List<ModelCharacters> characters=[];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<ModelCharacters> getAllCharacters(){
    charactersRepository.getAllChars().then((characters) {
      emit(CharactersLoaded(characters));
      this.characters=characters;
    });
    return characters;
  }
}
