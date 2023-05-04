import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_states.dart';
import 'package:shop_app/shared/components/componenets.dart';
import 'package:shop_app/shared/constants/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
// var model =ShopCubit.get(context).userModel;

        // nameController.text = model.data.name;
        // emailController.text = model.data.email;
        // phoneController.text = model.data.phone;

        return ShopCubit.get(context).userModel == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if (state is ShopLoadinUpdateUserState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      defaultformfield(
                        conttroller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'name must not be empty';
                          }
                          return null;
                        },
                        lable: 'Name',
                        prefx: Icons.person,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultformfield(
                        conttroller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'email must not be empty';
                          }
                          return null;
                        },
                        lable: 'Email Address',
                        prefx: Icons.email,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultformfield(
                        conttroller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'phone must not be empty';
                          }
                          return null;
                        },
                        lable: 'Phone Address',
                        prefx: Icons.phone,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            ShopCubit.get(context).updateUserData(
                              nameController.text,
                              emailController.text,
                              phoneController.text,
                            );
                          }
                        },
                        child: Text('UPDATE'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        onPressed: () {
                          singOut(context);
                        },
                        child: Text('LOGOUT'),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
