import 'package:shop_app/Models/shop_app/change_favorites_model.dart';

import '../../../Models/shop_app/shop_login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLodingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccesCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccesChangeFavoritesState extends ShopStates {
final ChangeFavoritesModel model;

  ShopSuccesChangeFavoritesState(this.model);

}

class ShopErrorChangeFavoritesState extends ShopStates {}



class ShopLoadingGetFavoritesState extends ShopStates {}


class ShopSuccesGetFavoritesState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccesUserDataState extends ShopStates {
 final ShopLoginModel logingModel;

  ShopSuccesUserDataState(this.logingModel);


}

class ShopErrorUserDataState extends ShopStates {}


class ShopLoadinUpdateUserState extends ShopStates {}

class ShopSuccesUpdateUserState extends ShopStates {
  final ShopLoginModel logingModel;

  ShopSuccesUpdateUserState(this.logingModel);
}

class ShopErrorUpdateUserState extends ShopStates {}
