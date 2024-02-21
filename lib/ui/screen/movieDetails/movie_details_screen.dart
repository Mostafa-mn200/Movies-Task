import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;
import '../../../business/moviesController/MoviesController.dart';
import '../../../conustant/my_colors.dart';

class MovieDetailsScreen extends StatefulWidget{
  int movieId;

  MovieDetailsScreen({required this.movieId});

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailsScreen();
  }
}

class _MovieDetailsScreen extends State<MovieDetailsScreen>{
  final moviesController = Get.put(MoviesController());
  var selectedFlag=0;


  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
        moviesController.getMovieDetails(widget.movieId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => !moviesController.isLoading.value? Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Transform.rotate(
                angle:translator.activeLanguageCode=='en'? 180 *math.pi /180:0,
                child: SvgPicture.asset('assets/back.svg',))
        ),
        title: Center(
          child: Text("product_details".tr(),
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontFamily: 'medium',
                        fontWeight: FontWeight.w700,
                        color: MyColors.Dark1)),
        ),
        actions: [
          Container(
            margin: EdgeInsetsDirectional.only(end: 1.h),
            child: IconButton(
              onPressed: () {
                final movieId = moviesController.moviesDetailsResponse.value.id!;
                setState(() {
                  if (!moviesController.favId.contains(movieId)) {
                    moviesController.favId.add(movieId);
                    moviesController.fav.add(moviesController.moviesDetailsResponse.value);
                  } else {
                    moviesController.fav.removeWhere((element) => element.id == movieId);
                    moviesController.favId.remove(movieId);
                  }
                  moviesController.saveFavorites();
                });
              },
              icon: SvgPicture.asset(
                'assets/love.svg',
                color: moviesController.favId.contains(moviesController.moviesDetailsResponse.value.id)
                    ? Colors.red
                    : null, // Change color based on selected state
              ),
            ),

          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(end: 1.h,start: 1.h,top: 1.h),
              child: SizedBox(
                height: 29.h,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  height: 29.h,
                  width: 45.w,
                  "https://media.themoviedb.org/t/p/w220_and_h330_face/${moviesController.moviesDetailsResponse.value.posterPath ?? ""}",
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) =>
                      (loadingProgress == null)
                          ? child
                          : const Center(
                              child: CircularProgressIndicator(
                              color: MyColors.MainColor,
                            )),
                  errorBuilder: (context, error, stackTrace) => Center(
                      child: SvgPicture.asset('assets/logo_login.svg')),
                ),
              ),
            ),
            Container(
                    margin: EdgeInsetsDirectional.only(
                        start: 2.h, end: 2.h, top: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            moviesController.moviesDetailsResponse.value
                                    .originalTitle ??
                                "",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontFamily: 'medium',
                                fontWeight: FontWeight.w500,
                                color: MyColors.Dark1)),
                        SizedBox(height: 1.h,),
                        Text(
                            moviesController
                                    .moviesDetailsResponse.value.releaseDate ??
                                "",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'medium',
                                fontWeight: FontWeight.w400,
                                color: MyColors.Dark2)),
                        SizedBox(height: 1.h,),
                        Text(
                            moviesController
                                    .moviesDetailsResponse.value.overview ??
                                "",
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontFamily: 'light',
                                fontWeight: FontWeight.w300,
                                color: MyColors.MainTint1)),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    ):const Scaffold(body: Center(child: CircularProgressIndicator(color: MyColors.MainColor),)));
  }



}