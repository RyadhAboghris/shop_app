import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/shop_app/shop_login_model.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';

import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/end_points.dart';








class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitalState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(ShopLoginLodingState());
print(email);
    print(password);

    
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
      
    ).then((value) {

      print(value.data);
     loginModel= ShopLoginModel.fromJson(value.data);
   
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {

      print(error.toString());

      emit(ShopLoginErrorlState(error.toString()));
      print('ol');

     
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;

    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopCahngePasswordVisibilityState());
  }
}
