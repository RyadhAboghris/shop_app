import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/shop_app/favoriets_model.dart';
import '../../../layout/shop_app/cubit/shop_cubit.dart';
import '../../../layout/shop_app/cubit/shop_states.dart';
import '../../../shared/components/componenets.dart';
import '../../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is! ShopLoadingGetFavoritesState
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  itemBuilder: (context, index) {
                    buildListProduct(
                      // ShopCubit.get(context).favorietsModel.data.data[index].product,
                      context,
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: 10,
                  // itemCount: ShopCubit.get(context).favorietsModel.data.data.length,
                );
        });
  }

 
}
