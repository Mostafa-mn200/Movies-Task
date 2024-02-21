import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../conustant/my_colors.dart';
import '../../data/model/moviesModel/MoviesResponse.dart';
import '../screen/movieDetails/movie_details_screen.dart';


class SearchItem extends StatelessWidget{
  Results? movies;

  SearchItem({required this.movies});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
          return MovieDetailsScreen(movieId: movies!.id!,);
        },));
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(bottom: 1.h),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    height: 15.h,
                    width: 22.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image:  DecorationImage(
                            image: NetworkImage("https://media.themoviedb.org/t/p/w220_and_h330_face/${movies?.posterPath??""}"),
                            fit: BoxFit.fill))),
                SizedBox(width: 1.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 25.h,
                      child: Text(movies?.originalTitle??"", style:  TextStyle(fontSize: 14.sp,
                          fontFamily: 'regular',
                          fontWeight: FontWeight.w400,
                          color:MyColors.MainColor)),
                    ),

                    SizedBox(
                      width: 25.h,
                      child: Text(movies?.overview??"", style:  TextStyle(fontSize: 12.sp,
                          fontFamily: 'regular',
                          fontWeight: FontWeight.w400,
                          color:MyColors.Dark1),maxLines: 2,),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 1.h,),
            SvgPicture.asset('assets/saperator.svg',width: MediaQuery.of(context).size.width,)
          ],
        ),
      ),
    );
  }

}