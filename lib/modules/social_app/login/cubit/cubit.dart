import 'package:chatopea/modules/social_app/login/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());



  static SocialLoginCubit get(context) => BlocProvider.of(context);



  void userLogin({
    required String email,
    required String password,
  }) async{

    emit(SocialLoginLoadingState());

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      emit(SocialLoginsSuccessState(value.user!.uid));
    }).catchError((error){
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });

  }



  signInWithGoogle()async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);

  }





  IconData suffix = Icons.visibility;
  bool isPassShown = true;

  void changePassVisibility ()
  {
    isPassShown = !isPassShown;
    suffix = isPassShown == true ? Icons.visibility: Icons.visibility_off;
    emit(SocialchangePassVisibilityState());
  }


}
