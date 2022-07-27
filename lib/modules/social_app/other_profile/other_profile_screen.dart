import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatopea/constants/components/components.dart';
import 'package:chatopea/cubit/states.dart';
import 'package:chatopea/modules/social_app/edit_profile/edit_profile.dart';
import 'package:chatopea/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../constants/constants.dart';
import '../../../cubit/cubit.dart';
import '../../../models/comment_model.dart';
import '../../../models/post_model.dart';
import '../../../models/register_model.dart';
import '../messages/chat_details.dart';
import '../post/new_post.dart';

class OtherProfileScreen extends StatefulWidget {
  String? uId;
  OtherProfileScreen({required this.uId});


  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  void clearText() {
    commentController.clear();
  }
  var commentController = TextEditingController();
  DateTime nowTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    // SocialCubit.get(context).getUserData();
    //     // .then((value){
    //   SocialCubit.get(context).getPosts();
    // });
    SocialCubit.get(context).getAnyUserData(widget.uId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context , state){},
      builder: (context , state){
        var userModel = SocialCubit.get(context).otherUserModel;
        var myModel = SocialCubit.get(context).userModel;

        return
          userModel == null ? Container(): Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CircleAvatar(
                            radius: 63,
                            backgroundImage: CachedNetworkImageProvider(
                                '${userModel.image}'
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${userModel.name}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${userModel.title}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${userModel.bio}',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              if(userModel.uId != uId)
                              Row(
                                children: [
                                  (SocialCubit.get(context).otherUserModel!.followers.where((element) => element.uId == myModel!.uId).isEmpty) ?MaterialButton(
                                    height: 50,
                                    minWidth: 100,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 0.0,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      SocialCubit.get(context).followAndUnfollow();
                                    },
                                    color: defaultColor,
                                    child:  Text(
                                      'Follow',
                                    ),
                                  ) : MaterialButton(
                                    height: 50,
                                    minWidth: 100,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                        side: BorderSide(
                                          color: defaultColor,
                                          width: 1,
                                        )
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 2.0,
                                    textColor: defaultColor,
                                    onPressed: () {
                                      SocialCubit.get(context).followAndUnfollow();
                                    },
                                    color: secDefaultColor,
                                    child:  Text(
                                      'Unfollow',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding:EdgeInsets.zero,
                                    width: 60,
                                    height: 50,
                                    child: MaterialButton(
                                        minWidth: 40,
                                        color: defaultColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(200.0),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        elevation: 0,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          navigateTo(context, ChatDetailsScreen(
                                            userModel: userModel,
                                          ));
                                        },

                                        child: Icon(Iconsax.messages_14)
                                    ),
                                  ),
                                ],
                              ),
                              if(userModel.uId == uId)
                                Container(
                                  width: 200,
                                  child: Row(
                                  children: [
                                  MaterialButton(
                                  textColor: secDefaultColor,
                                  color: defaultColor,
                                  height: 50,
                                  shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                  color: defaultColor ,
                                  ),
                                  borderRadius:BorderRadius.circular(30.0),
                                  ),
                                  onPressed: (){
                                  navigateTo(context, NewPostScreen());
                                  },
                                  child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                  children: [
                                  Icon(Iconsax.edit,
                                  color: secDefaultColor,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('New Post')
                                  ],
                                  ),
                                  ),
                                  ),
                                  ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '${SocialCubit.get(context).userPosts.length}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Posts',
                                  style:Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '${userModel.followers.length}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Followers',
                                  style:Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '${userModel.following.length}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Following',
                                  style:Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),

                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 1,
              ),
            ),
            SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context , index) => bulidPostItem(
                    (SocialCubit.get(context).userPosts[index]) , context, index , commentController,nowTime , clearText ,
                ),
                itemCount: SocialCubit.get(context).userPosts.length,
              ),
            ),
                ],
              ),
            ),
          );
      },
    );
  }
}


Widget bulidPostItem(SocialPostModel model , context , index , commentController,nowTime , clearText ) => Container(
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
    boxShadow: [ // so here your custom shadow goes:
      BoxShadow(
        color: Colors.black.withAlpha(40), // the color of a shadow, you can adjust it
        spreadRadius: -9, //also play with this two values to achieve your ideal result
        blurRadius: 7,
        offset: Offset(0, -1), // changes position of shadow, negative value on y-axis makes it appering only on the top of a container
      ),
    ],
  ),
  child:   Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    margin: EdgeInsets.all(15),
    elevation: 0,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              navigateTo(context, OtherProfileScreen(uId: model.uId,));
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.image}'),
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
                            '${model.name}',
                            style: TextStyle(
                              height: 1.3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Iconsax.verify5,
                            color: Colors.lightBlue,
                            size: 15,
                          ),
                        ],
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd hh:mm').format(model.dateTime!),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
          ),
          Text(
            '${model.text}',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 10,
              top: 5,
            ),
            child: Container(
              width: double.infinity,
            ),
          ),
          if(model.postImage != '')
            Container(
              padding: EdgeInsets.zero,
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    '${model.postImage}',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ), //imagepost
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.heart,
                            size: 16,
                            color: defaultColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${model.likes!.length} likes",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Scaffold.of(context).showBottomSheet<void>(
                            (BuildContext context) {
                          return Container(
                            height: double.infinity,
                            color: Colors.transparent,
                            child: SingleChildScrollView(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ListView.separated(
                                      separatorBuilder: (context , index) => SizedBox(height: 5,),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context , index) => buildCommentItem(
                                        context: context,
                                        index: index,
                                        model: model.comments![index],
                                      ),
                                      itemCount: model.comments!.length,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            CupertinoIcons.text_bubble,
                            size: 16,
                            color: defaultColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${model.comments!.length} Comments',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey.shade300,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).userModel!.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        onSubmitted: (String){
                          SocialCubit.get(context).commentPost(
                            SocialCubit.get(context).postId[index],
                            model,
                            index,
                            nowTime,
                            model.image,
                            commentController.text,
                          );
                          clearText();

                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: commentController,
                        decoration: InputDecoration(
                          errorText: commentController == null ? 'Value Can\'t Be Empty' : null,
                          contentPadding: EdgeInsets.all(10),
                          isDense: true,
                          hintText: 'Write a comment',
                          hintStyle: TextStyle(
                            fontSize: 14,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        SocialCubit.get(context).commentPost(
                          SocialCubit.get(context).postId[index],
                          model,
                          index,
                          model.dateTime,
                          model.image,
                          commentController.text,
                        );
                        clearText();

                      },
                      child: Icon(

                        Iconsax.send1,
                        size: 18,
                      ),
                    )

                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index],model,index);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      CupertinoIcons.heart_fill,
                      size: 16,
                      color: (model.likes!.where((element) => element == uId).isEmpty) ? Colors.grey : defaultColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);

Widget buildCommentItem({ SocialCommentModel? model , context ,  index }) => Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
  margin: EdgeInsets.all(15),
  elevation: 5,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('${model!.imageUser}'),
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
                        '${model.name}',
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
                    DateFormat('yyyy-MM-dd hh:mm').format(model.dateTime!),
                    style: Theme.of(context).textTheme.caption!.copyWith(
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
                size: 16,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
        ),
        Text(
          '${model.comment}',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(
            bottom: 10,
            top: 5,
          ),
          child: Container(
            width: double.infinity,
          ),
        ), //imagepost
      ],
    ),
  ),
);