import 'package:chatopea/cubit/states.dart';
import 'package:chatopea/modules/social_app/feeds/feeds_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../constants/components/components.dart';
import '../../../cubit/cubit.dart';
import '../home/home_screen.dart';

class NewPostScreen extends StatelessWidget {

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final f = new DateFormat('yyyy-MM-dd hh:mm').format(now);

    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state){
        if(state is SocialCreatePostSuccessState ){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
              SocialHomeLayout()), (Route<dynamic> route) => false);
        }
      },
      builder: (context , state){
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: (){
                    if(SocialCubit.get(context).postImage == null ){
                      SocialCubit.get(context).createPost(
                          dateTime: now, text: textController.text);
                    }else {
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now,
                          text: textController.text,
                      );

                    }
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                SizedBox(height: 20,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${SocialCubit.get(context).userModel!.name}',
                                style: TextStyle(
                                  height: 1.3,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                          Text(
                            '$f',

                            style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Share what you think..',
                    ),
                  ),

                ),
                SizedBox(height: 20,),
                if(SocialCubit.get(context).postImage != null)
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      height: 160,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          4.0
                        ),
                        image: DecorationImage(
                          image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(
                            CupertinoIcons.xmark_circle_fill,
                            size: 30,
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        SocialCubit.get(context).getPostImage();
                      }, child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.photo),
                          SizedBox(width: 5,),
                          Text('Add Photos'),
                        ],
                      ),),
                    ),
                  ],
                ),

              ],
            ),
          ),

        );
      },
    );
  }
}
