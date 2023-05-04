import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/shop_app/categoties_model.dart';
import 'package:shop_app/Models/shop_app/change_favorites_model.dart';
import 'package:shop_app/Models/shop_app/favoriets_model.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_states.dart';
import 'package:shop_app/modules/shop_app/cateogries/cateogries_screen.dart';
import 'package:shop_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../Models/shop_app/home_model.dart';
import '../../../Models/shop_app/shop_login_model.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../shared/constants/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(ShopLodingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      print(homeModel.data.banners[0].image);

      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.in_favorites,
        });
        print(favorites.toString());
      });

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      print(homeModel.data.banners[0].image);

      emit(ShopSuccesCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavoriets();
      }

      emit(ShopSuccesChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId];

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavorietsModel favorietsModel;
  void getFavoriets() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favorietsModel = FavorietsModel.fromJson(value.data);
      print(value.data.toString());
      print(homeModel.data.banners[0].image);

      emit(ShopSuccesGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(value.data.toString());
      print(userModel.data.name);

      emit(ShopSuccesUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData(
    @required String name,
    @required String email,
    @required String phone,
  ) {
    emit(ShopLoadinUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROGILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      print(value.data.toString());
      print(userModel.data.name);

      emit(ShopSuccesUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
