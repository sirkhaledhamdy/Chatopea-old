import 'dart:io';

import 'package:bloc/bloc.dart';

import '../cubit/cubit.dart';
import '../modules/social_app/login/login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components/components.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}


String ?token = '';
String ?uId = '';


void signOut(context) {

  CacheHelper.removeData(key:'uId');
  navigateAndFinish(
    context,
    SocialLoginScreen(),
  );
  SocialCubit.get(context).currentIndex=0;
  SocialCubit.get(context).allUsers=[];
  SocialCubit.get(context).posts=[];
  SocialCubit.get(context).postId=[];
  SocialCubit.get(context).userPosts=[];
}


String getOS(){
  return Platform.operatingSystem;
}

