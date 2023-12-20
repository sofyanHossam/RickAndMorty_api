import 'package:api/data/api_service/CharacterApi.dart';
import 'package:api/data/models/ModelCharacter.dart';

class CharactersRepository{

 final CharactersApi charactersApi;

 CharactersRepository(this.charactersApi);

 Future<List<ModelCharacters>> getAllChars() async{
   final characters =await charactersApi.getAllChars();
   return characters.map((character) => ModelCharacters.fromJson(character)).toList();
 }
}