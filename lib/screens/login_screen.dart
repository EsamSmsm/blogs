import 'package:blogs_task/cubit/auth_cubit/auth_cubit.dart';
import 'package:blogs_task/screens/home_screen.dart';
import 'package:blogs_task/screens/signup_screen.dart';
import 'package:blogs_task/shared/constants.dart';
import 'package:blogs_task/shared/widgets/custom_text_form_field.dart';
import 'package:blogs_task/shared/defaults.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/widgets/components.dart';
import '../shared/widgets/custom_button.dart';
import 'login_screen.dart';


TextEditingController usernameController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              navigateAndFinish(context, HomeScreen());
            } else if (state is LoginErrorState) {
              showToast(text: 'Failed Login', color: Colors.red);
            }
          },
          builder: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.18,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/vector1.png'))),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LoginTabBar(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 22),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(35))),
                    child: Form(
                      key: logInFormKey,
                      child: Column(
                        children: [
                          Label(text: 'Username'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            hintText: 'your username ',
                            controller: usernameController,
                            validateMessage: 'Enter Your userName',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Label(text: 'Password'),
                          SizedBox(
                            height: 10,
                          ),
                          CustomPasswordFormField(
                            hintText: 'your password ',
                            controller: passwordController,
                            validateMessage: 'Enter Password',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          RememberMeSwitch(cubit: cubit),
                          SizedBox(
                            height: 20,
                          ),
                          state is LoginLoadingState?
                          CircularProgressIndicator(
                            color: kPrimaryColor,
                          )
                              :CustomButton(
                            text: 'Start Shopping',
                            onTap: (){
                              if(logInFormKey.currentState.validate()){
                                cubit.logIn(
                                    username: usernameController.text,
                                    password: passwordController.text
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SocialLoginRow(cubit: cubit),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'lost your password?',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                              'By logging in. you are agreeing to'
                              'Terms & conditions and Privacy policy',
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}



