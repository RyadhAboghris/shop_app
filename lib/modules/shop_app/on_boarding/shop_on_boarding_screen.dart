import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/components/componenets.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
  });
}

class ShopOnBoardingScreen extends StatefulWidget {
  const ShopOnBoardingScreen({Key key}) : super(key: key);

  @override
  State<ShopOnBoardingScreen> createState() => _ShopOnBoardingScreenState();
}

class _ShopOnBoardingScreenState extends State<ShopOnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        image: 'assets/images/amazon.jpeg',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body'),
    BoardingModel(
        image: 'assets/images/amazon.jpeg',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body'),
    BoardingModel(
        image: 'assets/images/amazon.jpeg',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body'),
  ];

  bool isLast = false;

  void submit(){
    CacheHelper.saveData(key:'onBoarding',value:true).then((value){
      navigateAndFinish(context, ShopLoginScreen());

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(
              function: submit,
              text: 'skip',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                    count: boarding.length,
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                      submit;
                      }
                      boardController.nextPage(
                          duration: Duration(
                            microseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      );
}
