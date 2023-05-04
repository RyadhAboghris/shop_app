import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';

import 'package:shop_app/modules/shop_app/on_boarding/shop_on_boarding_screen.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'layout/shop_app/cubit/shop_cubit.dart';
import 'layout/shop_app/cubit/shop_states.dart';
import 'shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  Widget widget;

  DioHelper.init();

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');

  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = ShopOnBoardingScreen();
  }
  runApp(MyApp(isDark, widget));
}

class MyApp extends StatelessWidget {
  bool isDark;
  Widget startWidget;
  MyApp(this.isDark, this.startWidget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavoriets()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Shop App',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              home: Directionality(
                textDirection: TextDirection.ltr,
                child: ShopLayout(),
                // child: startWidget,
              ),
            );
          }),
    );
  }
}
