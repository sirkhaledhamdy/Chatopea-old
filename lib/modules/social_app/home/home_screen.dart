import 'dart:async';

import 'package:chatopea/cubit/cubit.dart';
import 'package:chatopea/cubit/states.dart';
import 'package:chatopea/models/register_model.dart';
import 'package:chatopea/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SocialHomeLayout extends StatefulWidget {


  @override
  State<SocialHomeLayout> createState() => _SocialHomeLayoutState();
}

class _SocialHomeLayoutState extends State<SocialHomeLayout> {

  double width = 0 ;
  bool searchExpanded = false ;


  List<SocialUserModel> searchResult = [];

  fetchData()async{
    await SocialCubit.get(context).getUserData().then((_)async{
      await SocialCubit.get(context).getPosts().then((_)async{
        await SocialCubit.get(context).getUsers();
    });
    });


  }


  @override
  void initState() {
    // TODO: implement initState
    // SocialCubit.get(context).getUserData();
    //     // .then((value){
    //   SocialCubit.get(context).getPosts();
    // });
    fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        final _controller = StreamController.broadcast();
        return Scaffold(
          appBar: AppBar(
            actions: [
              AnimatedContainer(duration: Duration(milliseconds: 500),
              width: width,

              child: TextField(
                onChanged: (value){
                  print(">>>>> ##### ${cubit.allUsers}");
                  setState((){
                    searchResult =  cubit.allUsers.where((element) => element.name!.contains(value)).toList();

                    if( value == '' ){
                      setState((){
                        searchResult.clear();
                      });
                    }
                  });




                  print(">>>>>> ${searchResult.length}");
                  print(">>>>>> ${searchResult.toString()}");
                },
                decoration: InputDecoration(),
              ),),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                ),
                child: IconButton(
                  onPressed: () {
                    setState((){
                      searchExpanded = !searchExpanded ;
                      width = (searchExpanded == true) ? MediaQuery.of(context).size.width * .7 : 0 ;
                    });

                  },
                  icon: Icon( searchExpanded ? Icons.close :Iconsax.search_normal,),
                ),
              ),
              Visibility(
                 visible: !searchExpanded,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Iconsax.notification4,),
                  ),
                ),
              ),
            ],
            centerTitle: false,
            title: Visibility(
              visible: !searchExpanded,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  'assets/images/logo1.png',
                  width: 145,
                  height: 50,
                ),
              ),
            ),
          ),
          body:

         searchResult.length != 0 ? ListView.builder(itemBuilder: (_,index)=> Container(
           child: Container(
             margin: EdgeInsets.symmetric(horizontal: 65),
             child: Row(
               children: [
                 Icon(CupertinoIcons.person_crop_circle_fill,size: 20,color: defaultColor,),
                 SizedBox(width: 10,),
                 Text(searchResult[index].name ?? "")
               ],
             ),
           ),
         ),itemCount:searchResult.length ):



          cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                label: 'Feeds',
                icon: Icon(
                  Iconsax.home_1,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Chats',
                icon: Icon(
                  Iconsax.messages,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Followers',
                icon: Icon(
                  Iconsax.profile_2user,
                ),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(
                  Iconsax.profile_circle5,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}


class TheSearch extends SearchDelegate<SocialUserModel> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }

}