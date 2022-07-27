import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatopea/constants/components/components.dart';
import 'package:chatopea/modules/social_app/home/home_screen.dart';
import 'package:chatopea/modules/social_app/login/cubit/cubit.dart';
import 'package:chatopea/modules/social_app/login/cubit/states.dart';
import 'package:chatopea/modules/social_app/login/login_screen.dart';
import 'package:chatopea/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constants/constants.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../network/local/cache_helper.dart';
import '../../../on_boarding_screen.dart';

class EditProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        logOut() {
          FirebaseAuth.instance.signOut();
          CacheHelper.removeData(key: 'uId',).then((value) {
            uId = '' ;
          });

          navigateAndFinish(context, SocialHomeScreen());
        }
        var profileImage = SocialCubit.get(context).profileImage;
        var userModel = SocialCubit.get(context).userModel;
        var nameController = TextEditingController();
        var titleController = TextEditingController();
        var bioController = TextEditingController();
        var phoneController = TextEditingController();

        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: 'Update Your Profile',
              actions: [
                IconButton(
                  onPressed: () {
                    SocialCubit.get(context).updateUserData(
                      name: nameController.text == "" ? null :nameController.text,
                      phone: phoneController.text == "" ? null :phoneController.text,
                      bio: bioController.text== "" ? null :bioController.text,
                      title: titleController.text== "" ? null :titleController.text,
                    );
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.check),
                ),
              ]),
          body: SingleChildScrollView(
            child: Padding(
              padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(state is SocialUSerUpdateLoadingState)
                    Container(
                      height: 10,
                      width: double.infinity,
                      child: LinearProgressIndicator(),),
                  Text('See information about your account , update your information like name , profile picture , etc ... or delete your account.',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400
                    ),

                  ),
                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileImage == null
                                      ? CachedNetworkImageProvider(
                                      '${userModel!.image}')
                                      : FileImage(profileImage) as ImageProvider,
                                ),
                                IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getImage();
                                  },
                                  icon: CircleAvatar(
                                      radius: 60,
                                      backgroundColor: Colors.grey.shade200,
                                      child: Icon(
                                        CupertinoIcons.camera_viewfinder,
                                        size: 30,
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            if(SocialCubit.get(context).profileImage != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  defaultButton(
                                    onPressed: () {

                                      SocialCubit.get(context).uploadImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                        title: titleController.text,
                                      );
                                    },
                                    text: 'Upload',
                                    textColor: secDefaultColor,
                                    minWidth: 100,
                                  ),
                                  SizedBox(height: 10,),
                                  if(state is SocialUSerUpdateLoadingState)
                                    Container(
                                        width: 100,
                                        child: LinearProgressIndicator()),
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.zero,
                              child: defaultFormField(
                                hint: userModel!.name != null
                                    ? '${userModel.name}'
                                    : 'Enter Your Name',
                                controller: nameController,
                                type: TextInputType.text,
                                validate: () {},
                                label: 'Name',
                                prefix: Icons.person_outline,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.zero,
                              child: defaultFormField(
                                hint: userModel.title != null
                                    ? '${userModel.title}'
                                    : 'Enter Your title',
                                controller: titleController,
                                type: TextInputType.text,
                                validate: () {},
                                label: 'title',
                                prefix: Icons.work_outline,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.zero,
                              child: defaultFormField(
                                hint: userModel.bio != null ? '${userModel.bio}' : 'Enter Your Bio',
                                controller: bioController,
                                type: TextInputType.text,
                                validate: () {},
                                label: 'Bio',
                                prefix: Icons.info_outline,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: EdgeInsets.zero,
                              child: defaultFormField(
                                hint: userModel.phone != null
                                    ? '${userModel.phone}'
                                    : 'Enter Your Name',
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: () {},
                                label: 'Phone',
                                prefix: Icons.info_outline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Center(
                    child: Container(

                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Iconsax.profile_delete4,
                              size: 40,
                            ),
                            title:  Text('Delete Your Account',
                              style: TextStyle(
                                color: defaultColor,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text('Find out how  you can delete your account',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            onTap: (){},
                            trailing: Icon(CupertinoIcons.forward),

                          ),
                          TextButton(onPressed: (){
                            logOut();
                          }, child: Text('Logout',
                            style: TextStyle(color: Colors.red.shade800),),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



