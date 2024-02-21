import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';


import '../../../../business/moviesController/MoviesController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget/MoviesItem.dart';

class FavScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FavScreen();
  }
}

class _FavScreen extends State<FavScreen>{
  final moviesController = Get.put(MoviesController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("favourite".tr(), style:  TextStyle(fontSize: 14.sp,
            fontFamily: 'medium',
            fontWeight: FontWeight.w700,
            color:MyColors.Dark1)),
      ),
      body: SafeArea(
        child: Container(
          margin:  EdgeInsetsDirectional.only(start: 2.h,end: 2.h,top: 2.h),
          child:SingleChildScrollView(
            child: Column(
              children: [
                moviesList(),
                SizedBox(height: 1.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget moviesList(){
    if(moviesController.fav.isNotEmpty){
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
          itemCount: moviesController.fav.length,
          itemBuilder: (context, int index) {
            return MoviesItem(
              null,
              moviesController.fav[index],
            );//FlashSale2();
          });
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
            Text('there_are_no_fav_movies'.tr(),
              style: TextStyle(fontSize: 14.sp,
                  fontFamily: 'bold',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h,),
            Text('fav_movies_will_appear_hear'.tr(),
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