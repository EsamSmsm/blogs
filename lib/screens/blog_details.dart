import 'package:blogs_task/cubit/app_cubit/app_cubit.dart';
import 'package:blogs_task/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogDetailsScreen extends StatelessWidget {
  const BlogDetailsScreen({Key key, this.blogIndex}) : super(key: key);

  final int blogIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text("Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(20),
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
                  Text(
                    cubit.blogsModel[blogIndex].title.rendered,
                    style: TextStyle(
                        color: kPrimaryColor, fontWeight: FontWeight.bold,fontSize: 20),
                  ),SizedBox(height: 30,),
                  Text(
                    cubit.blogsModel[blogIndex].content.rendered,
                    style: TextStyle(
                      color: Colors.black54,fontSize: 18
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
