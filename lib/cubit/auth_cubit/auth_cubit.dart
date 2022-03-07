import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:blogs_task/models/login_model.dart';
import 'package:blogs_task/models/signup_model.dart';
import 'package:blogs_task/network/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool rememberMe = false;
  void changeRememberMeSwitch(value){
    rememberMe = value;
    emit(ChangeRememberMeSwitch());
  }


  bool showPassword = true;
  IconData passwordIcon = Icons.visibility;
  void changePasswordVisibility() {
    showPassword = !showPassword;
    passwordIcon = showPassword ? Icons.visibility : Icons.visibility_off;
    emit(ChangePasswordVisibilityState());
  }

  UserCredential user;
  static String userName;
  static String userPhoto = "https://www.itdp.org/wp-content/uploads/2021/06/avatar-man-icon-profile-placeholder-260nw-1229859850-e1623694994111.jpg";
  static String userEmail;

  LoginModel loginModel;
  Future<void> logIn({String username, password}) async {
    emit(LoginLoadingState());
    DioHelper.getData(
      url: 'wp/v2/users/me',
      username: username,
      password: password
    ).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      userName = value.data["name"];
      emit(LoginSuccessState());
    }).catchError((error){
      emit(LoginErrorState());
      print(error);
    });
  }

  SignupModel signupModel;
  Future<void> signUp({String email, String username,String password}) async {
    emit(SignUpLoadingState());
    DioHelper.postData(
      url: "wp/v2/users",
      data: {
        "username" : username,
        "email": email,
        "password" : password
      }
    ).then((value){
      print(value.data);
      signupModel = SignupModel.fromJson(value.data);
      emit(SignUpSuccessState());
    }).catchError((error){
      emit(SignUpErrorState());
      print(error);
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<dynamic> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    user = await _auth.signInWithCredential(credential);
    if (user.user.displayName != null) {
      userName = user.user.displayName;
      userPhoto = user.user.photoURL;
      userEmail = user.user.email;
      emit(LoginSuccessState());
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login(permissions: [
      "email",
      "public_profile",
      "user_friends"
    ],);
    if(result.status == LoginStatus.success){
      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken.token);
      var graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture.width(800).height(800),email&access_token=${result.accessToken.token}'));
      var profile = json.decode(graphResponse.body);
      print(profile.toString());
      userName = profile["name"];
      userPhoto = profile["picture"]["data"]["url"];
      userEmail = profile["email"];
      emit(LoginSuccessState());
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }else{emit(LoginErrorState());print(result.message+"==============================");}
    return null;
  }

}
