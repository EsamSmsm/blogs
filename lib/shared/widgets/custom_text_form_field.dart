import 'package:blogs_task/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit/auth_cubit.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key key,
    this.hintText,
    this.icon,
    this.controller,
    this.keyboardType = TextInputType.text, this.validateMessage,
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final String validateMessage;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        keyboardType: keyboardType,
        validator: (value) {
          if (value.isEmpty) {
            return validateMessage;
          } else {
            return null;
          }
        },
        controller: controller,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
          filled: true,
          fillColor: kBGColor,
          isDense: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
              borderRadius: BorderRadius.circular(5)),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}

class CustomPasswordFormField extends StatelessWidget {
  const CustomPasswordFormField({
    Key key,
    this.controller,
    this.hintText = 'password', this.validateMessage,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String validateMessage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Container(
            //height: 50,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: TextFormField(
              controller: controller,
              validator: (value) {
                if (value.isEmpty) {
                  return validateMessage;
                } else {
                  return null;
                }
              },
              cursorColor: Colors.black,
              keyboardType: TextInputType.visiblePassword,
              obscureText: cubit.showPassword,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                suffixIcon: IconButton(
                  icon: Icon(
                    cubit.passwordIcon,
                    color: Color(0xff9a8f84),
                    size: 22,
                  ),
                  onPressed: () {
                    cubit.changePasswordVisibility();
                  },
                ),
                filled: true,
                fillColor: kBGColor,
                isDense: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColor),
                    borderRadius: BorderRadius.circular(5)),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          );
        },
      ),
    );
  }
}
