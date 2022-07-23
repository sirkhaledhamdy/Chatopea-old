import 'package:chatopea/constants/components/components.dart';
import 'package:chatopea/modules/social_app/home/home_screen.dart';
import 'package:chatopea/modules/social_app/login/cubit/states.dart';
import 'package:chatopea/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../cubit/cubit.dart';
import '../../../styles/colors.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if(state is SocialLoginErrorState){
            showToast(text: state.error, state: ToastStates.error);
          }
          if(state is SocialLoginsSuccessState)
          {
            CacheHelper.saveData(key: 'uId', value: state.uId,).then((value) {
              uId = state.uId ;
              SocialCubit.get(context).getUserData();
              navigateAndFinish(context, SocialHomeLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: secDefaultColor,
              centerTitle: true,
            ),
            backgroundColor: secDefaultColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Hero(
                        tag: 'logo',
                        child: Container(
                          child: Image.asset(
                            'assets/images/logo1.png',
                            width: 140,
                            height: 140,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          'Login Now To Communicate With Your Friends',
                          style: TextStyle(
                            fontFamily: 'Product',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          errorText: _validate
                              ? 'Please Enter Your Email Address'
                              : null,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please Enter Your Email Address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        errorText:
                            _validate ? 'Please Enter Your Password' : null,
                        suffixPressed: () {
                          SocialLoginCubit.get(context).changePassVisibility();
                        },
                        isPass: SocialLoginCubit.get(context).isPassShown,
                        controller: passwordController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                        },
                        label: 'Password',
                        prefix: Icons.lock,
                        suffix: SocialLoginCubit.get(context).suffix,
                        onSubmit: (value) {
                          emailController.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                          passwordController.text.isEmpty
                              ? _validate = true
                              : _validate = false;

                          if (formKey.currentState!.validate()) {
                            SocialLoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                  Center(
                    child: state is! SocialLoginLoadingState
                        ? defaultButton(
                      minWidth: 250,
                      sideColor: Colors.white,
                      textColor: Colors.white,
                      onPressed: () {
                        emailController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                        passwordController.text.isEmpty
                            ? _validate = true
                            : _validate = false;

                        if (formKey.currentState!.validate()) {
                          SocialLoginCubit.get(context).userLogin(
                            email: emailController.text,
                            password: passwordController.text,

                          );
                        }
                      },
                      text: 'Sign In',
                    )
                        : CircularProgressIndicator(),
                  ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Don\'t Have Account ?'),
                          TextButton(
                            onPressed: () {
                              navigateTo(
                                context,
                                SocialRegisterScreen(),
                              );
                            },
                            child: Text('Register.'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
