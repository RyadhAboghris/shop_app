






import '../../../../Models/shop_app/shop_login_model.dart';
import 'cubit.dart';

abstract class ShopRegisterStates  {}

class ShopRegisterInitalState extends ShopRegisterStates{}

class ShopRegisterLodingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {

  final   ShopLoginModel loginModel;


  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorlState extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorlState(this.error);
}
class ShopRegisterCahngePasswordVisibilityState extends ShopRegisterStates {}
