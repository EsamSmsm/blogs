import 'package:blogs_task/cubit/app_cubit/app_cubit.dart';
import 'package:blogs_task/screens/blog_details.dart';
import 'package:blogs_task/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../cubit/auth_cubit/auth_cubit.dart';
import '../shared/constants.dart';
import '../shared/widgets/components.dart';
import '../shared/defaults.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        title: Text('Blogs'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await logOut(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          UserInfoCard(),
          Expanded(
            child: BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                AppCubit cubit = AppCubit.get(context);
                return cubit.blogsModel==null?
                Center(child: SpinKitFadingCircle(color: kPrimaryColor),)
                :ListView.separated(
                    itemCount: cubit.blogsModel.length,
                    padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: (){
                        navigateTo(context, BlogDetailsScreen(blogIndex: index,));
                      },
                      child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height * 0.22,
                                decoration: BoxDecoration(color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(cubit.blogsModel[index].title.rendered,style: TextStyle(color: Colors.black54,
                              fontWeight: FontWeight.bold),)
                            ],
                          ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }


}
