import 'package:chatopea/constants/components/components.dart';
import 'package:chatopea/cubit/cubit.dart';
import 'package:chatopea/cubit/states.dart';
import 'package:chatopea/models/register_model.dart';
import 'package:chatopea/modules/social_app/messages/chat_details.dart';
import 'package:chatopea/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state){},
      builder: (context , state){
        return RefreshIndicator(
          onRefresh: ()async{
            await SocialCubit.get(context).getUsers();
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Icon(Iconsax.messages,
                    color: defaultColor,
                    ),
                    SizedBox(width: 10,),
                    Text('Chats',
                    style: TextStyle(
                      color: defaultColor,
                    ),
                    ),
                  ],
                ),
              ),
            ),
            body: (SocialCubit.get(context).allUsers.isNotEmpty )?Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,),
              child: Column(
                children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.shade300,
                  ),
                ),
                  SingleChildScrollView(

                    child: ListView.separated(
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context , index) => buildChatItem(SocialCubit.get(context).allUsers[index] , context),
                      separatorBuilder: (context , index) => Padding(
                        padding: const EdgeInsetsDirectional.only(start: 16 , bottom: 20 , top: 20,),
                        child: Container(
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          height: 1,),
                      ),
                      itemCount: SocialCubit.get(context).allUsers.length ,
                    ),
                  ),
                ],
              ),
            ):Center(child: CircularProgressIndicator()),
          ),
        );
      },

    );
  }
  Widget buildChatItem(SocialUserModel model , context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(
        userModel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                '${model.image}'),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            '${model.name}',
            style: TextStyle(
              height: 1.3,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          IconButton(onPressed: (){}, icon: Icon(Iconsax.message4,
          color: defaultColor,
          ),)
        ],
      ),
    ),
  );
}