import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/shop_app/categoties_model.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_states.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
              itemBuilder: (context, index) => buildCatItem(
                // ShopCubit.get(context).categoriesModel.data.data[index],
                ),
              separatorBuilder: (context, index) => Divider(),
              itemCount: 10,
            // itemCount: ShopCubit.get(context).categoriesModel.data.data.length,
              
              
              );
        });
  }

  Widget buildCatItem(
    // DataModel model,
    ) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('https://th.bing.com/th/id/OIP.2EVNHHX4D-jWbnofJsaQHAHaFj?pid=ImgDet&rs=1'),
              // image: NetworkImage(model.image),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              // model.name,
              'Title',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
