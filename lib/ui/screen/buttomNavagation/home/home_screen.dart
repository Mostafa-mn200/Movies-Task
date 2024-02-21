
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/ui/screen/buttomNavagation/fav/fav_screen.dart';

import '../../../../business/moviesController/MoviesController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget/MoviesItem.dart';
import '../buttom_navagation_page.dart';


class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen>{
  int currentIndex = 0;
  final moviesController = Get.put(MoviesController());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    moviesController.loadFavorites();
    moviesController.page=1;
    moviesController.getMovies(moviesController.page);
    moviesController.scroll.addListener(moviesController.scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            color: Colors.white,
            backgroundColor: MyColors.MainColor,
            strokeWidth: 4.0,
            onRefresh: () async {
              moviesController.page=1;
              moviesController.getMovies(moviesController.page);
            },
            child:Obx(() => !moviesController.isLoading.value? Container(
              margin:  EdgeInsetsDirectional.only(start: 2.h,end: 2.h,top: 2.h),
              child:Column(
                children: [
                      appCustomBar(),
                      SizedBox(height: 2.h,),
                  Obx(() => !moviesController.isLoading2.value
                      ?  Expanded(child: moviesList()): moviesController.page==1?
                  const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                            color: MyColors.MainColor,
                          ))):Expanded(child: moviesList())),
                      SizedBox(height: 1.h,),
                  Center(
                    child: Obx(() =>
                        Visibility(
                            visible: moviesController.isVisable.value,
                            child: const CircularProgressIndicator(color: MyColors.MainColor,)
                        )),
                  ),
                  SizedBox(height: 1.h,),
                ],
              ),
            )
                :const Center(child: CircularProgressIndicator(color: MyColors.MainColor,))),
      ),)
    );
  }

  Widget appCustomBar(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("home".tr(), style:  TextStyle(fontSize: 14.sp,
            fontFamily: 'medium',
            fontWeight: FontWeight.w700,
            color:MyColors.Dark1)),
        const Spacer(),
        GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, "/search_screen",);
            },
            child: SvgPicture.asset('assets/search.svg')),
      ],
    );
  }

  Widget moviesList(){
    if(moviesController.movieList.isNotEmpty){
      if(moviesController.internet==true) {
        return GridView.builder(
            controller: moviesController.scroll,
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (6 / 10),
              crossAxisSpacing: 20,
              mainAxisSpacing: 8,
            ),
            itemCount: moviesController.movieList.length,
            itemBuilder: (context, int index) {
              return MoviesItem(
                  moviesController.movieList[index],
                  null
              ); //FlashSale2();
            });
      }else{
        return GridView.builder(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: (6 / 10),
              crossAxisSpacing: 20,
              mainAxisSpacing: 8,
            ),
            itemCount: moviesController.movieList.length,
            itemBuilder: (context, int index) {
              return MoviesItem(
                  moviesController.movieList[index],
                  null
              ); //FlashSale2();
            });
      }
    }else{
      return empty();
    }
  }
}
class empty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 20.h,),
            SvgPicture.asset('assets/no_orders.svg'),
            SizedBox(height: 1.h,),
            Text('there_are_no_movies'.tr(),
              style: TextStyle(fontSize: 14.sp,
                  fontFamily: 'bold',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h,),
            Text('movies_will_appear_hear'.tr(),
              style: TextStyle(fontSize: 12.sp,
                  fontFamily: 'bold',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}