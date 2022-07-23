import 'package:chatopea/cubit/states.dart';
import 'package:chatopea/models/register_model.dart';
import 'package:chatopea/modules/social_app/other_profile/other_profile_screen.dart';
import 'package:chatopea/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/components/components.dart';
import '../../../constants/constants.dart';
import '../../../cubit/cubit.dart';
import '../../../models/follow_model.dart';

class FollowersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: BlocConsumer<SocialCubit , SocialStates>(
        listener: (context , state){},
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  '${SocialCubit.get(context).userModel!.name}',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.shade300,
                        )
                    ),
                  ),
                  child: TabBar(
                    labelColor: Colors.grey,
                    indicatorColor: defaultColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Tab(
                        text: 'Followers',
                      ),
                      Tab(
                        text: 'Following',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children:  [
                ListView.builder(
                  itemBuilder: (context , index) => buildFollowItem(SocialCubit.get(context).userModel!.followers[index]  , context, index),
                  itemCount: SocialCubit.get(context).userModel!.followers.length,
                ),
                ListView.builder(
                  itemBuilder: (context , index) => buildFollowItem(SocialCubit.get(context).userModel!.following[index]  , context, index),
                  itemCount: SocialCubit.get(context).userModel!.following.length,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


Widget buildFollowItem(SocialFollowModel? followModel  , context  ,index) => GestureDetector(
  onTap: (){
      navigateTo(context, OtherProfileScreen(uId: followModel!.uId,));
  },
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              '${followModel!.image}'),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          '${followModel.name}',
          style: TextStyle(
            height: 1.3,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  ),
);