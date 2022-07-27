import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatopea/constants/components/components.dart';
import 'package:chatopea/models/comment_model.dart';
import 'package:chatopea/models/post_model.dart';
import 'package:chatopea/modules/social_app/post/new_post.dart';
import 'package:chatopea/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../constants/constants.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import 'package:iconsax/iconsax.dart';

import '../other_profile/other_profile_screen.dart';



class FeedsScreen extends StatelessWidget {


  FocusNode inputNode = FocusNode();
  void clearText() {
    commentController.clear();
  }
  var commentController = TextEditingController();
  DateTime nowTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
      },
      builder: (context, state) {

        return
          SocialCubit.get(context).posts.isNotEmpty

              ? RefreshIndicator(
            onRefresh: ()async{
              await SocialCubit.get(context).getPosts();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      onTap: () {
                        navigateTo(context, NewPostScreen());
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                          },
                          icon:Icon(Iconsax.edit),
                          color: defaultColor,
                        ),
                        hintText: 'Share what you think..',
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.grey, width: 1.0),
                          borderRadius:
                          BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.purple, width: 1.0),
                          borderRadius:
                          BorderRadius.all(Radius.circular(32.0)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.all(15),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                          "https://img.freepik.com/free-photo/metaverse-concept-collage-design_23-2149419859.jpg",
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                          fit: BoxFit.cover,
                          height: 200,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'AI Cool Designs!',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => bulidPostItem(SocialCubit.get(context).posts[index] , context, index , commentController,nowTime , clearText , inputNode),
                    itemCount: SocialCubit.get(context).posts.length,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
              : Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}

Widget bulidPostItem(SocialPostModel model , context , index , commentController,nowTime , clearText , inputNode) => Card(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
  margin: EdgeInsets.all(15),
  elevation: 8,
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
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (String){
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






