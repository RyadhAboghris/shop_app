import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Models/shop_app/categoties_model.dart';
import 'package:shop_app/Models/shop_app/home_model.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/shop_states.dart';
import 'package:shop_app/shared/components/componenets.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {

if(state is ShopSuccesChangeFavoritesState){
  if(!state.model.status){
showToast(text: state.model.message, state: ToastStates.ERROR);

  }
}
if (state is ShopErrorChangeFavoritesState) {}
      },
      builder: (BuildContext context, state) {
        return ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null
            ? Center(child: CircularProgressIndicator())
            : builderWidget(ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel, context);
      },
    );
  }

  Widget builderWidget(
          HomeModel model, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: [
                Image(
                  image: NetworkImage(
                      'https://th.bing.com/th/id/OIP.2EVNHHX4D-jWbnofJsaQHAHaFj?pid=ImgDet&rs=1'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Image(
                  image: NetworkImage(
                      'https://th.bing.com/th/id/OIP.2EVNHHX4D-jWbnofJsaQHAHaFj?pid=ImgDet&rs=1'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Image(
                  image: NetworkImage(
                      'https://th.bing.com/th/id/OIP.2EVNHHX4D-jWbnofJsaQHAHaFj?pid=ImgDet&rs=1'),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
              // items: model.data.banners
              //     .map(
              //       (e) => Image(
              //         image: NetworkImage('${e.image}'),
              //         width: double.infinity,
              //         fit: BoxFit.cover,
              //       ),
              //     )
              //     .toList(),

              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem(
                          // categoriesModel.data.data[index],
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10,
                      ),
                      itemCount: 10,
                      // itemCount:categoriesModel.data.data.length,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.58,
                children: List.generate(
                  // model.data.products.length ,
                  10,
                  (index) => buildGridProduct(
                    //  model: model.data.products[index],

                    context: context,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(
// DataModel model,

          ) =>
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            // image: NetworkImage(''),
            image: NetworkImage(
                'https://th.bing.com/th/id/OIP.2EVNHHX4D-jWbnofJsaQHAHaFj?pid=ImgDet&rs=1'),
            //  image:NetworkImage(model.image),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Container(
              color: Colors.black.withOpacity(.8),
              width: 100,
              child: Text(
                // model.name,
                'Electronics',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      );

  Widget buildGridProduct({ProductModel model, context}) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  // image: NetworkImage(model.image),
                  image: NetworkImage(
                      'https://th.bing.com/th/id/OIP.2EVNHHX4D-jWbnofJsaQHAHaFj?pid=ImgDet&rs=1'),
                  width: double.infinity,
                  height: 200,
                ),
                // if(model.discount !=0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'hello Wolrd',
                    // model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '234',
                        // '${model.price.round()}'
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // if(model.discount !=0)
                      Text(
                        '234',
                        // '${model.price.round()}'
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          // ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              // ShopCubit.get(context).favorites[model.id]
                              //     ? defaultColor
                              //     :
                                  
                                   Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
