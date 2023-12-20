import 'package:api/bloc/characters_cubit.dart';
import 'package:api/constants/MyColors.dart';
import 'package:api/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../data/models/ModelCharacter.dart';

class CharactersScreen extends StatefulWidget {
  // const CharactersScreen({super.key});
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState()=> _CharactersScreenState();

}

class _CharactersScreenState  extends State<CharactersScreen>{
  late List<ModelCharacters> allCharacters ;
  late List<ModelCharacters> searchedCharactersList ;

  bool isSearching =false;

  final _searchTextController =TextEditingController();

  Widget buildSearchField(){
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: InputDecoration(
        hintText: "find characters",
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey,fontSize: 18),

      ) ,
      style: TextStyle(color: MyColors.myGrey,fontSize: 18),
      onChanged: (searchedCharacters){
        addSearchedItemToSearchedList(searchedCharacters);
      },


    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
              BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget bulidBlocWidget() {
    return BlocBuilder<CharactersCubit,CharactersState>(
      builder: (context,state){
      if(state is CharactersLoaded){
        allCharacters=(state).characters;
        print(allCharacters[0].name+"sofiaaaaaaan");
        return buildLoadedListWidgets();
      }else{
        print("sofiaaaaaaan");
        return showLoadingIndicator();

      }
    },
    );
  }
  Widget _buildAppBarTitle(){
    return Text("Charactersss",style: TextStyle(color: MyColors.myGrey),
    );
  }
  Widget showLoadingIndicator(){
    return Center(child: CircularProgressIndicator(
      color: MyColors.myYellow,
    ),
    );
  }
  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList()
          ],
        ),
      ),
    );
  }
  Widget  buildCharactersList() {
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 2/3,
      crossAxisSpacing: 1,
      mainAxisSpacing: 1,
    ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty? allCharacters.length:searchedCharactersList.length,
        itemBuilder: (ctx,index){
      return CharacterItem(character:_searchTextController.text.isEmpty? allCharacters[index]:searchedCharactersList[index],);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: isSearching? BackButton(color: MyColors.myGrey,):Container(),
        title: isSearching?  buildSearchField():_buildAppBarTitle(),
        actions: _buildAppBar(),
        ),
      body:
      OfflineBuilder(
      connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
          )
          {
            final bool connected = connectivity != ConnectivityResult.none;
            if(connected){
              return bulidBlocWidget();
            }else{

              return buildNoInternetWidget();
            }
          }
          ,
        child: Center(child: showLoadingIndicator(),),
      )

       //
    );
  }

  List<Widget> _buildAppBar(){
    if(isSearching){
      return[
        IconButton(onPressed: (){
          _clearSearch();
          Navigator.pop(context);
        }, icon: Icon(Icons.clear,color: MyColors.myGrey,))
      ];
    }else{
      return [
        IconButton(onPressed:(){_startSearch();}

        , icon: Icon(Icons.search,color: MyColors.myGrey,))
      ];
    }
  }
  void addSearchedItemToSearchedList(String searchedCharacters) {
    searchedCharactersList=allCharacters.where((character) => character.name.toLowerCase().contains(searchedCharacters)).toList();

    setState(() {

    });
  }
  void _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      isSearching=true;
    });
  }

  void _stopSearch() {
    _clearSearch();
    setState(() {
      isSearching=false;
    });

  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: MyColors.myWhite,
        child: Column(
          children: [
            SizedBox(height:20 ,),
            Text("no internet connection",
              style: TextStyle(color: MyColors.myGrey,fontSize: 22),
            ),
            Image.asset('assets/images/no_internet.png'),
          ],
        ),
      ),
    );
  }

}

