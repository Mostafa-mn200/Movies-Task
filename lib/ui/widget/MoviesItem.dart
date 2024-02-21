import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:untitled/data/model/moviesDetailsModel/MoviesDetailsResponse.dart';

import '../../../../../conustant/my_colors.dart';
import '../../data/model/moviesModel/MoviesResponse.dart';
import '../screen/movieDetails/movie_details_screen.dart';

class MoviesItem extends StatelessWidget{
  Results? movies;
  MoviesDetailsResponse? moviesDetailsResponse;

  MoviesItem( this.movies,this.moviesDetailsResponse);

  @override
  Widget build(BuildContext context) {
    if(movies!=null){
      return GestureDetector(
        onTap: (){
          Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
            return MovieDetailsScreen(movieId: movies!.id!,);
          },));
        },
        child: Container(
          margin: EdgeInsetsDirectional.only(end: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
                child: Image.network(
                  height: 25.h,
                  width: 45.w,
                  "https://media.themoviedb.org/t/p/w220_and_h330_face/${movies?.posterPath??""}",
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) =>
                  (loadingProgress == null)
                      ? child
                      : const Center(child: CircularProgressIndicator(color: MyColors.MainColor,)),
                  errorBuilder: (context, error, stackTrace) =>
                      Center(child:  SvgPicture.asset('assets/logo_login.svg')),
                ),
              ),
              Text(movies?.originalTitle??"", style:  TextStyle(fontSize: 14.sp,
                  fontFamily: 'regular',
                  fontWeight: FontWeight.w400,
                  color:MyColors.Dark1),maxLines: 1,),
              Text(movies?.overview??"", style:  TextStyle(fontSize: 12.sp,
                  fontFamily: 'regular',
                  fontWeight: FontWeight.w400,
                  color:MyColors.Dark1),maxLines: 2,),
            ],
          ),
        ),
      );
    }else{
      return GestureDetector(
        onTap: (){
          Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
            return MovieDetailsScreen(movieId: moviesDetailsResponse!.id!,);
          },));
        },
        child: Container(
          margin: EdgeInsetsDirectional.only(end: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25.h,
                child: Image.network(
                  height: 25.h,
                  width: 45.w,
                  "https://media.themoviedb.org/t/p/w220_and_h330_face/${moviesDetailsResponse?.posterPath??""}",
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) =>
                  (loadingProgress == null)
                      ? child
                      : const Center(child: CircularProgressIndicator(color: MyColors.MainColor,)),
                  errorBuilder: (context, error, stackTrace) =>
                      Center(child:  SvgPicture.asset('assets/logo_login.svg')),
                ),
              ),
              Text(moviesDetailsResponse?.originalTitle??"", style:  TextStyle(fontSize: 14.sp,
                  fontFamily: 'regular',
                  fontWeight: FontWeight.w400,
                  color:MyColors.Dark1),maxLines: 1,),
              Text(moviesDetailsResponse?.overview??"", style:  TextStyle(fontSize: 12.sp,
                  fontFamily: 'regular',
                  fontWeight: FontWeight.w400,
                  color:MyColors.Dark1),maxLines: 2,),
            ],
          ),
        ),
      );
    }

  }

}