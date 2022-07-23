import 'dart:async';

import 'package:chatopea/cubit/cubit.dart';
import 'package:chatopea/cubit/states.dart';
import 'package:chatopea/models/register_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class SocialHomeLayout extends StatefulWidget {


  @override
  State<SocialHomeLayout> createState() => _SocialHomeLayoutState();
}

class _SocialHomeLayoutState extends State<SocialHomeLayout> {


  fetchData()async{
   await SocialCubit.get(context).getUserData().then((_)async{
     await SocialCubit.get(context).getPosts();
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                ),
                child: IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Iconsax.search_normal,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Iconsax.notification4,),
                ),
              ),
            ],
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Image.asset(
                'assets/images/logo1.png',
                width: 145,
                height: 50,
              ),
            ),
          ),
          body: cubit.screens[cubit.currentIndex],
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

