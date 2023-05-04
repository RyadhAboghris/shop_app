import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/shop_app/login/cubit/cubit.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import '../../../shared/components/componenets.dart';
import '../../../shared/constants/constants.dart';

import '../register/shop_register_screen.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  ShopLoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (BuildContext context, ShopLoginStates state) {

          
          if (state is ShopLoginSuccessState) {

            if (state.loginModel.status) {
              print('The message: ${state.loginModel.message}');

              print(state.loginModel.data.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token =state.loginModel.data.token;
                navigateAndFinish(context, ShopLayout());
                showToast(
                    text: state.loginModel.message, state: ToastStates.SUCCESS);
              });
            } else {
              print('The message: ${state.loginModel.message}');

              showToast(
                  text: state.loginModel.message, state: ToastStates.ERROR);
            }
          }

          if(state is ShopLoginErrorlState){
            showToast(text: 'يوجد هناك خطأ ما', state: ToastStates.ERROR);
          }


        },
        builder: (BuildContext context, ShopLoginStates state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'login now to browse out hot offers',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          defaultformfield(
                            conttroller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your email adderss';
                              }
                            },
                            lable: 'Email Address',
                            prefx: Icons.email_outlined,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultformfield(
                            conttroller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: ShopLoginCubit.get(context).suffix,
                            onSubmit: (_) {
                              if (formKey.currentState.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            suffixPressed: (_) {
                              print('ok');
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'password is too short';
                              }
                            },
                            lable: 'Password',
                            prefx: Icons.lock_outlined,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: state is! ShopLoginLodingState
                                  ? RaisedButton(
                                      onPressed: () {
                                        if (formKey.currentState.validate()) {
                                     
                                          ShopLoginCubit.get(context).userLogin(
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      },
                                      child: Text('LOGIN'),
                                    )
                                  : CircularProgressIndicator(),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                              ),
                              defaultTextButton(
                                function: () =>
                                    navigateTo(context, ShopRegisterScreen()),
                                text: 'registry',
                              ),
                            ],
                          )
                        ]),
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
