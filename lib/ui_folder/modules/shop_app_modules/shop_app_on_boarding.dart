import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled3/data_layer/cashe_helper.dart';
import 'package:untitled3/shared/componants.dart';
import 'package:untitled3/ui_folder/modules/shop_app_modules/login.dart';
class BoardingSwipScreens{
  final String image;
  final String title;
  final String body;
  BoardingSwipScreens({
    required this.image,
    required this.title,
    required this.body

  });
}


class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  static List<BoardingSwipScreens> screens=[
    BoardingSwipScreens(
        image: 'assets/images/market.png',
        title: 'OnBoarding 1 Title',
        body: 'OnBoarding 1 body'

    ),
    BoardingSwipScreens(
        image: 'assets/images/market.png',
        title: 'OnBoarding 2 Title',
        body: 'OnBoarding 2 body'

    ),
    BoardingSwipScreens(
        image: 'assets/images/market.png',
        title: 'OnBoarding 3 Title',
        body: 'OnBoarding 3 body'

    ),
  ];

  bool isLast=false;
  var pageController=PageController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
          onPressed: () {
           onSubmit();
          },
          child: const Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                itemBuilder: (context, index) => BuildPageView(screens[index]),
                itemCount: screens.length,
                onPageChanged: (index) {
                  if(index==screens.length-1){
                    setState(() {
                      isLast=true;
                    });
                  }else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.blue,
                      dotColor: Colors.grey,
                      spacing: 5,
                      dotHeight: 10,
                      dotWidth: 12),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast){
                      onSubmit();
                    }else{
                      pageController.nextPage(
                          duration: const Duration(
                            milliseconds: 600,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }

                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }






  Widget BuildPageView(BoardingSwipScreens model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
     Image(
        image: AssetImage(model.image),
      ),
      const SizedBox(height: 25,),
      Text(model.title,style: Theme.of(context).textTheme.bodyText1,),
      const SizedBox(height: 20,),
      Text(model.body,style: Theme.of(context).textTheme.bodyText2),

    ],
  );


  void onSubmit(){

    CasheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
       navigatorAndFinish(context: context, widget: Login());
      }

    });
  }
}
