import 'package:chatopea/cubit/cubit.dart';
import 'package:chatopea/models/message_model.dart';
import 'package:chatopea/models/register_model.dart';
import 'package:chatopea/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constants/components/components.dart';
import '../../../cubit/states.dart';
import '../other_profile/other_profile_screen.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel? userModel;
  ChatDetailsScreen({this.userModel});
  FocusNode inputNode = FocusNode();

  var messageController = TextEditingController();
  void clearText() {
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(
          receiverId: userModel!.uId,
        );
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, states) {},
          builder: (context, states) {
            return Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: GestureDetector(
                    onTap: (){
                      navigateTo(context, OtherProfileScreen(uId: userModel!.uId,));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(
                            '${userModel!.image}',
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          '${userModel!.name}',
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Icon(
                            Icons.more_horiz,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: (SocialCubit.get(context).loadingMessages == true)
                    ? Center(child: CircularProgressIndicator())
                    : Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                (SocialCubit.get(context).messages.isEmpty)
                                    ? Expanded(
                                      child: Center(
                                      child: Container(
                                        child: Text('No Messages'),
                                      )),
                                    )
                                    :   Flexible(
                                  child: ListView.separated(
                                    shrinkWrap: false,
                                    reverse: true,
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      var message = SocialCubit.get(context)
                                          .messages[index];
                                      if (SocialCubit.get(context)
                                              .userModel!
                                              .uId ==
                                          message.senderId) {
                                        return buildMyMessage(message);
                                      } else {
                                        return buildHiMessage(message);
                                      }
                                    },
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      height: 15,
                                    ),
                                    itemCount: SocialCubit.get(context)
                                        .messages
                                        .length,
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1,
                                        )),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0),
                                            child: TextFormField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              focusNode: inputNode,
                                              onFieldSubmitted: (String text) {
                                                SocialCubit.get(context)
                                                    .sendMessage(
                                                  receiverId: userModel!.uId,
                                                  dateTime: DateTime.now(),
                                                  text: messageController.text,
                                                );
                                                clearText();
                                              },
                                              controller: messageController,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText:
                                                      'Type your message ...',
                                                  hintStyle: TextStyle(
                                                    fontSize: 14,
                                                  )),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: defaultColor,
                                          ),
                                          height: 40,
                                          child: MaterialButton(
                                            onPressed: () {
                                              SocialCubit.get(context)
                                                  .sendMessage(
                                                receiverId: userModel!.uId,
                                                dateTime: DateTime.now(),
                                                text: messageController.text,
                                              );
                                              clearText();
                                            },
                                            child: Icon(
                                              Iconsax.send1,
                                              color: Colors.white,
                                            ),
                                            minWidth: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ));
          },
        );
      },
    );
  }

  Widget buildMyMessage(SocialMessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: defaultColor.withOpacity(.2),
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20),
                topEnd: Radius.circular(20),
                bottomStart: Radius.circular(20),
              ),
            ),
            child: Text(
              '${messageModel.text}',
              style: TextStyle(),
            )),
      );
  Widget buildHiMessage(SocialMessageModel messageModel) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(20),
                topEnd: Radius.circular(20),
                bottomEnd: Radius.circular(20),
              ),
            ),
            child: Text(
              '${messageModel.text}',
            )),
      );
}
