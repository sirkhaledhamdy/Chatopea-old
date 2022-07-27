import 'package:chatopea/auth_service.dart';
import 'package:chatopea/modules/social_app/home/home_screen.dart';
import 'package:chatopea/on_boarding_screen.dart';
import 'package:chatopea/styles/themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/components/components.dart';
import 'constants/constants.dart';
import 'cubit/appCubit.dart';
import 'cubit/appStates.dart';
import 'cubit/cubit.dart';
import 'firebase_options.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('on background message');
  print(message.data.toString());

  showToast(
    text: 'on background message',
    state: ToastStates.success,
  );
}


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );

 token = await FirebaseMessaging.instance.getToken();
  print(' token is :  $token');

  FirebaseMessaging.onMessage.listen((event)
  {
    print('on message');
    print(event.data.toString());

    showToast(text: 'on message', state: ToastStates.success,);
  });
  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print('on message opened app');
    print(event.data.toString());
    showToast(text: 'on message opened app', state: ToastStates.success,);
  });
  // background fcm
  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      DioHelper.init();
      await CacheHelper.init();
      bool? isDark = CacheHelper.getData(
        key: 'isDark',
      );
      final User? user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        uId = FirebaseAuth.instance.currentUser!.uid;
      }else{
        uId = '';
      }
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      runApp(MyApp(
        isDark: isDark,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}



class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp({this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
            ThemeMode.light,
            home: AuthService().handleAuthState(),
          );
        },
      ),
    );
  }
}
