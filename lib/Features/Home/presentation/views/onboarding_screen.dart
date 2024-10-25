import 'package:flutter/material.dart';
import 'package:shop_app/Core/cache_helper.dart';
import 'package:shop_app/Core/components.dart';
import 'package:shop_app/Features/Home/data/models/boarding_model.dart';
import 'package:shop_app/Features/Home/presentation/views/widgets/boarding_item.dart';
import 'package:shop_app/Features/Login/presentation/views/shop_login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controller =PageController();

  List<BoardingModel> board =[
    BoardingModel(
      image:'assets/images/shop.jpg',
      title: 'On board 1 title',
      body: 'On board 1 body'
    ),
    BoardingModel(
        image:'assets/images/shop.jpg',
        title: 'On board 2 title',
        body: 'On board 2 body'
    ),
    BoardingModel(
        image:'assets/images/shop.jpg',
        title: 'On board 3 title',
        body: 'On board 3 body'
    ),
  ];
  bool isLast=false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value!) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: const Text('SKIP'),
            onPressed: (){
              submit();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                physics: const BouncingScrollPhysics(),
                  onPageChanged: (index){
                    if(index ==board.length-1){
                      setState(() {
                        isLast =true;
                      });
                    }else{
                      setState(() {
                        isLast=false;
                      });

                    }
                  },
                  itemBuilder:(context,index)=> buildBoardingItem(board[index]),
                  itemCount: board.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: board.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    dotWidth: 10.0,
                    spacing: 5,
                    activeDotColor: Colors.deepOrange,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onPressed: (){
                    if(isLast){
                      submit();
                    }else {
                      controller.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
