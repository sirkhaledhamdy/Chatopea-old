import 'package:chatopea/constants/constants.dart';
import 'package:chatopea/modules/social_app/home/home_screen.dart';
import 'package:chatopea/modules/social_app/register/register_cubit/cubit.dart';
import 'package:chatopea/modules/social_app/register/register_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/components/components.dart';
import '../../../constants/constants.dart';
import '../../../network/local/cache_helper.dart';
import '../../../styles/colors.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  bool _validate = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if(state is SocialRegisterErrorState){
            showToast(text: state.error, state: ToastStates.error);
          }

          if(state is SocialCreateUserSuccessState)
          {
            CacheHelper.saveData(key: 'uId', value: state.uId,).then((value) {
              uId = state.uId ;
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
                          height: 140,
                          width: 140,
                          child: Image(
                            image: AssetImage('assets/images/logo1.png'),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Register Now To Connect People',
                          style: TextStyle(
                            fontFamily: 'Product',
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        errorText:
                            _validate ? 'Please Enter Your Full Name' : null,
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your Full Name';
                          }
                        },
                        label: 'Full Name',
                        prefix: Icons.person,
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
                        prefix: Icons.email,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        errorText:
                            _validate ? 'Please Enter Your password' : null,
                        suffixPressed: () {
                          SocialRegisterCubit.get(context)
                              .changePassVisibility();
                        },
                        controller: passwordController,
                        isPass: SocialRegisterCubit.get(context).isPassShown,
                        type: TextInputType.visiblePassword,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your password';
                          }
                        },
                        label: 'Password',
                        prefix: Icons.lock,
                        suffix: SocialRegisterCubit.get(context).suffix,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        errorText:
                            _validate ? 'Please Enter Your Phone Number' : null,
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your Phone Number';
                          }
                        },
                        label: 'Phone Number',
                        prefix: Icons.phone,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: state is! SocialRegisterLoadingState
                            ? defaultButton(
                          minWidth: 250,
                          sideColor: secDefaultColor,
                          textColor: secDefaultColor,
                                onPressed: () {
                                  emailController.text.isEmpty
                                      ? _validate = true
                                      : _validate = false;
                                  passwordController.text.isEmpty
                                      ? _validate = true
                                      : _validate = false;

                                  if (formKey.currentState!.validate()) {
                                    SocialRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'Sign Up',
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
                          Text(
                            'By Signing up, you agree to the',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          TextButton(
                            style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(0)),
                            ),
                            onPressed: () {

                            },
                            child: Text(
                              'Terms of use & privacy policy',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              maxLines: 2,
                            ),
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
