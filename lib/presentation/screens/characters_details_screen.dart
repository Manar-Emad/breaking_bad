import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking_bad/business_logic/cubit/characters_cubit.dart';
import 'package:breaking_bad/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/characters.dart';


class CharactersDetailsScreen extends StatelessWidget {
  final Character character;
  const CharactersDetailsScreen({Key? key, required this.character})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        //  centerTitle: true,
        title: Text(
          character.nickname,
          style: const TextStyle(
            color: MyColors.myWhite,
          ), //textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value){
    return RichText(text:TextSpan(children: [
      TextSpan(text: title,style:const TextStyle(color: MyColors.myWhite,fontWeight: FontWeight.bold,fontSize: 18,)),
      TextSpan(text: value,style:const TextStyle(color: MyColors.myWhite,fontWeight: FontWeight.bold,fontSize: 16,)),
    ]) ,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget buildDivider(double endIndent){
    return Divider(color: MyColors.myYellow,height: 30, endIndent:endIndent ,thickness: 2,);
  }

  Widget checkIfQuotesLoaded(CharactersState state){
    if(state is QuotesLoaded){
      return displayRandomQuotesOrEmptySpace(state);
    }
    else{
      return const CircularProgressIndicator(color: MyColors.myYellow,);
    }
  }

  displayRandomQuotesOrEmptySpace(CharactersState state){

   /// var quotes= (state).quotes;

    var quotes ;
    if(quotes .length !=0){
      int randomQuotesIndex =Random().nextInt(quotes.length - 1);
      return Center(child: DefaultTextStyle(
        child:AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText(quotes[randomQuotesIndex].quote),
          ],
        ) ,
        style:const TextStyle(
            fontSize: 20,
            color: MyColors.myWhite,
            shadows: [
              Shadow(
                offset: Offset(0 , 0),
                blurRadius: 7,
                  color: MyColors.myYellow

              ),
            ],
        )
        ,textAlign: TextAlign.center,
      ),
      );
    }else{
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Job : ', character.occupation!.join(' / ')),
                      buildDivider(315),
                      characterInfo('Appeared in : ', character.categoryForTwoSeries),
                      buildDivider(250),
                      characterInfo('seasons: ', character.appearanceOfSeasons!.join(' / ')),
                      buildDivider(280),
                      characterInfo('Job : ', character.statusIfDeadOrAlive),
                      buildDivider(315),
                      character.betterCallSaulAppearance!.isEmpty?Container():
                      characterInfo('Better Cal Saul Seasons : ', character.betterCallSaulAppearance!.join(' / ')),
                      character.betterCallSaulAppearance!.isEmpty?Container():buildDivider(150),
                      characterInfo('Actor / Actress : ', character.name),
                      buildDivider(235),
                      const SizedBox(height: 20,),
                      BlocBuilder<CharactersCubit,CharactersState>(builder:(context,state){
                        return  checkIfQuotesLoaded(state);
                      } ),

                    ],
                  ),
                ),
                SizedBox(height: 500,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
