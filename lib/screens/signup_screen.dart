import 'package:blogs_task/cubit/auth_cubit/auth_cubit.dart';
import 'package:blogs_task/shared/constants.dart';
import 'package:blogs_task/shared/widgets/custom_text_form_field.dart';
import 'package:blogs_task/shared/defaults.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/widgets/components.dart';
import '../shared/widgets/custom_button.dart';
import 'home_screen.dart';
import 'login_screen.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    TextEditingController usernameController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();
    TextEditingController confirmPasswordController = new TextEditingController();
    return Scaffold(
      backgroundColor: kBGColor,
      body: BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            if(state is SignUpSuccessState){
              cubit.logIn(username: usernameController.text,password: passwordController.text);
            }
            if (state is LoginSuccessState) {
              navigateAndFinish(context, HomeScreen());
            } else if (state is LoginErrorState|| state is SignUpErrorState) {
              showToast(text: 'Failed Register', color: Colors.red);
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
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/vector2.png'))),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Column(
                    children: [
                      SignupTabBar(),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 40, horizontal: 22),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(35))),
                        child: Form(
                          key: signUpFormKey,
                          child: Column(
                            children: [
                              Label(text: 'Email Address'),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                hintText: 'your email address ',
                                controller: emailController,
                                validateMessage: 'Enter your email',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 10,),
                              Label(text: 'Username'),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                hintText: 'your Username ',
                                validateMessage: 'Enter your username',
                                controller: usernameController,
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
                                validateMessage: 'Enter your password',
                                controller: passwordController,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Label(text: 'Confirm Password'),
                              SizedBox(
                                height: 10,
                              ),
                              CustomPasswordFormField(
                                hintText: 'confirm password ',
                                validateMessage: 'Enter your password',
                                controller: confirmPasswordController,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              state is SignUpLoadingState?
                              CircularProgressIndicator(
                                color: kPrimaryColor,
                              )
                                  :CustomButton(
                                text: 'Start Shopping',
                                onTap: (){
                                  if(signUpFormKey.currentState.validate()){
                                    if(passwordController.text==confirmPasswordController.text){
                                      cubit.signUp(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          username: usernameController.text
                                      );
                                    }else {showToast(text: "Password doesn't identical" , color: Colors.red);}
                                  }
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Have account!',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  TextButton(onPressed: (){
                                    navigateAndFinish(context, LoginScreen());
                                  }, child: Text('Login here'))
                                ],
                              ),
                              SizedBox(height: 30,),
                              Text(
                                  'By logging in. you are agreeing to'
                                      'Terms & conditions and Privacy policy',textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ],
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

