import 'package:flutter/material.dart';

import '../../cubit/auth_cubit/auth_cubit.dart';
import '../../screens/login_screen.dart';
import '../../screens/signup_screen.dart';
import '../constants.dart';
import '../defaults.dart';

class Label extends StatelessWidget {
  const Label({
    Key key, this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text,
            style: TextStyle(
                color: kPrimaryColor)),
      ],
    );
  }
}
class LoginTabBar extends StatelessWidget {
  const LoginTabBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          child: Column(
            children: [
              Text('Login',
                  style: TextStyle(color: Colors.black)),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 30,
                height: 7,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              )
            ],
          ),
          onPressed: () {},
        ),
        TextButton(
          child: Column(
            children: [
              Text('Signup',
                  style: TextStyle(color: Colors.black)),
              SizedBox(
                height: 5,
              ),
              // Container(
              //   width: 30,
              //   height: 7,
              //   decoration: BoxDecoration(
              //     color: kPrimaryColor,
              //     borderRadius: BorderRadius.circular(5),
              //   ),
              // )
            ],
          ),
          onPressed: () {
            navigateAndFinish(context, SignupScreen());
          },
        ),
      ],
    );
  }
}

class SignupTabBar extends StatelessWidget {
  const SignupTabBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(child: Column(
          children: [
            Text('Login',style: TextStyle(color: Colors.black)),
            SizedBox(height: 5,),
          ],
        ),onPressed: (){
          navigateAndFinish(context, LoginScreen());
        },),
        TextButton(child: Column(
          children: [
            Text('Signup',style: TextStyle(color: Colors.black)),
            SizedBox(height: 5,),
            Container(
              width: 30,
              height: 7,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(5),
              ),
            )
          ],
        ),onPressed: (){
        },),
      ],
    );
  }
}

class RememberMeSwitch extends StatelessWidget {
  const RememberMeSwitch({
    Key key,
    @required this.cubit,
  }) : super(key: key);

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Remember me next Time',
            style: TextStyle(fontSize: 12)),
        Switch(
          value: cubit.rememberMe,
          onChanged: (value) {
            cubit.changeRememberMeSwitch(value);
          },
          activeColor: kPrimaryColor,
        )
      ],
    );
  }
}

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({
    Key key,
    @required this.cubit,
  }) : super(key: key);

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'login by social media',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                cubit.signInWithGoogle();
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/google.png'))),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                cubit.signInWithFacebook();
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/facebook.png'))),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Row(
          children: [
            CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                backgroundImage: NetworkImage(AuthCubit.userPhoto)),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AuthCubit.userName??'',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      height: 1.5,
                      fontSize: 16),
                ),
                Text(
                  AuthCubit.userEmail ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      color: kPrimaryColor,
    );
  }
}




