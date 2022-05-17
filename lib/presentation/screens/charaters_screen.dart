import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/constants/colors.dart';
import 'package:breaking_bad/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  dynamic allCharacters;
  dynamic searchedForCharacters;
  bool isSearching = false;
  final searchTextController = TextEditingController();

  Widget buildSearchFeild() {
    return TextFormField(
      controller: searchTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character ...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter) {
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacter) {
    searchedForCharacters = allCharacters!
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> builAppBarAction() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon:const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        )
      ];
    } else {
      return [
        IconButton(
          onPressed:startSearch,
          icon:const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }
  void startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching=true;
    });
  }

  void stopSearching(){
    clearSearch();
    setState(() {
      isSearching=false;
    });
  }

  void clearSearch(){
    setState(() {
      searchTextController.clear();
    });
  }

  @override
  void initState() {
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget BuildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadeedListWidget();
      } else {
        return ShowLoadingIndicator();
      }
    });
  }

  Widget ShowLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadeedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            BuildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget BuildCharactersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 2,
            childAspectRatio: 2 / 3,
            // المسافة بين ال grids
            mainAxisSpacing: 1,
            crossAxisSpacing: 1),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: searchTextController .text.isEmpty? allCharacters!.length :searchedForCharacters!.length,
        padding: EdgeInsets.zero,

        ///TODO not done
        itemBuilder: (context, index) {
          return CharacterItem(
            character: searchTextController .text.isEmpty? allCharacters![index] :searchedForCharacters![index],
          );
        });
  }

  Widget BuildAppBarTitle(){
    return   const Text(
      'characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  Widget buildNoInternetWidget(){
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const SizedBox(height: 20,),
            const Text('Can\'t Connect ..Check Internet ',style: TextStyle(color: MyColors.myGrey),),
            Image.asset('assets/images/undraw_server_down_s4lk.png'),

          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: isSearching?const BackButton(color: MyColors.myGrey,):Container(),
        title: isSearching ? buildSearchFeild() :BuildAppBarTitle(),
        actions: builAppBarAction(),
      ),
      body:OfflineBuilder(
      connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
    ) {
        final bool connected = connectivity != ConnectivityResult.none;
        if(connected){
          return BuildBlocWidget();
        }
        else{
          return buildNoInternetWidget();
        }
      },
      child: ShowLoadingIndicator(),
      ),

    );
  }
}
