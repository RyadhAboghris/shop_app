





import '../../../../Models/shop_app/shop_login_model.dart';

abstract class ShopLoginStates  {}

class ShopLoginInitalState extends ShopLoginStates{}

class ShopLoginLodingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {

  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorlState extends ShopLoginStates {
  final String error;
  ShopLoginErrorlState(this.error);
}
class ShopCahngePasswordVisibilityState extends ShopLoginStates {}
