import 'package:chatopea/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constants/constants.dart';
import 'modules/social_app/home/home_screen.dart';

class AuthService {

  handleAuthState(){
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ( context , snapshot){
          if(snapshot.hasData){
            return SocialHomeLayout();
          }else{
            return SocialHomeScreen();
          }
        });
  }




  signOuts(){
    FirebaseAuth.instance.signOut();
  }
  
}

