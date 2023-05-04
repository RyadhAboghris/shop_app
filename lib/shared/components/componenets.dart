import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/colors.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        // navigateTo(context,WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${article['utlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
    );

Widget articleBuilder(list, context, {isSearch = false}) {
  return list.length > 0
      ? (isSearch ? Container() : Center(child: CircularProgressIndicator()))
      : ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: 10,
        );
}

Widget defaultformfield({
  @required TextInputType type,
  @required TextEditingController conttroller,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required IconData prefx,
  @required Function validate,
  @required String lable,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      enabled: isClickable,
      controller: conttroller,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: lable,
        icon: Icon(prefx),
        suffix: IconButton(
          icon: Icon(suffix),
          onPressed: () {
            suffixPressed();
          },
        ),
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(onPressed: function, child: Text(text.toUpperCase()));

void showToast({@required String text, @required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.WARNING:
      {
        color = Colors.orange;
        break;
      }
    case ToastStates.SUCCESS:
      {
        color = Colors.green;
        break;
      }

    case ToastStates.ERROR:
      {
        color = Colors.red;
        break;
      }
  }
  return color;
}


Widget buildListProduct(

        //  model,
        context,
        {bool isOldPrice=true}) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      // image: NetworkImage(model.image),
                      image: NetworkImage(
                          'https://th.bing.com/th/id/OIP.2EVNHHX4D-jWbnofJsaQHAHaFj?pid=ImgDet&rs=1'),

                      width: 120,
                      height: 120,
                    ),
                    // if(model.discount !=0 && isOldPrice)
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
                SizedBox(
                  width: 20,
                ),
                Expanded(
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
                      Spacer(),
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
                          // if(model.discount !=0 && isOldPrice)
                          Text(
                            '234',
                            // '${model.oldPrice.round()}'
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
                )
              ],
            ),
          ],
        ),
      ),
    );
