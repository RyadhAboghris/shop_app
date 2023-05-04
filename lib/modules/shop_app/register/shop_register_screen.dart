import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';

import 'package:shop_app/modules/shop_app/register/cubit/cubit.dart';
import 'package:shop_app/modules/shop_app/register/cubit/states.dart';
import 'package:shop_app/shared/constants/constants.dart';

import '../../../shared/components/componenets.dart';
import '../../../shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (BuildContext context, state) {
           if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              print('The message: ${state.loginModel.message}');

              print(state.loginModel.data.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token = state.loginModel.data.token;
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

          if (state is ShopRegisterErrorlState) {
            showToast(text: 'يوجد هناك خطأ ما', state: ToastStates.ERROR);
          }
        },
        builder: (BuildContext context, state) {
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
                            'REGISTER',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'register now to browse out hot offers',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                          defaultformfield(
                            conttroller: nameController,
                            type: TextInputType.name,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your name';
                              }
                            },
                            lable: 'User Name',
                            prefx: Icons.person,
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
                            suffix: ShopRegisterCubit.get(context).suffix,
                            onSubmit: (_) {},
                            isPassword:
                                ShopRegisterCubit.get(context).isPassword,
                            suffixPressed: (_) {
                              print('ok');
                              ShopRegisterCubit.get(context)
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
                          defaultformfield(
                            conttroller: phoneController,
                            type: TextInputType.phone,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return 'please enter your phone number';
                              }
                            },
                            lable: 'Phone',
                            prefx: Icons.phone,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: state is! ShopRegisterLodingState
                                  ? RaisedButton(
                                      onPressed: () {
                                        if (formKey.currentState.validate()) {
                                          ShopRegisterCubit.get(context)
                                              .userRegister(
                                            name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                            phone: phoneController.text,
                                          );
                                        }
                                      },
                                      child: Text('REGISTER'),
                                    )
                                  : CircularProgressIndicator(),
                            ),
                          ),
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
