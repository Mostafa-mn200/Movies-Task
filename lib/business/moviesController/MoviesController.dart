import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../data/model/moviesDetailsModel/MoviesDetailsResponse.dart';
import '../../data/model/moviesModel/MoviesResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class MoviesController extends GetxController {
  Repo repo = Repo(WebService());
  var moviesResponse = MoviesResponse().obs;
  var moviesDetailsResponse = MoviesDetailsResponse().obs;
  var isLoading = false.obs;
  var isLoading2=false.obs;
  var isLoadingMore=false;
  var isVisable=false.obs;
  var resultCodeMovie = 0;
  var resultCodeMovieDetails = 0;
  int page=1;
  bool selected=false;
  final scroll=ScrollController();
  RxList<dynamic> movieList=[].obs;
  List<MoviesDetailsResponse>fav=[];
  Rx<bool> internet=true.obs;
  //List<int>favId=[];
  Set<int> favId = {};
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();

  Future<void> scrollListener()async{
    if(isLoadingMore)return;
    if(scroll.position.pixels == scroll.position.maxScrollExtent){
      isLoadingMore=true;
      page=page+1;
      await getMovies(page);
      isLoadingMore=false;
    }
  }

  getMovies(int page) async {

    if(page==1){
      isLoading.value = true;
    }else{
      isLoading2.value = true;
    }

    Results? loadingItem;

    if (moviesResponse.value.page != moviesResponse.value.totalPages) {
      loadingItem = Results(originalTitle: "loading");
      isVisable.value=true;
      movieList.add(loadingItem!);
    }

    var response = await repo.getMovies(page);

    if (response != null) {
      isVisable.value=false;
      moviesResponse.value = response;
      List<Results> newData = response.results ?? [];

      if (loadingItem != null) {
        movieList.remove(loadingItem);
      }

      if (page == 1) {
        movieList.assignAll(newData);
      } else {
        movieList.addAll(newData);
      }

      isLoading.value = false;
      isLoading2.value = false;
      return response;
    } else {
      isLoading.value = false;
      isLoading2.value = false;
      return response;
    }
  }

  getMovieDetails(int id)async{
    isLoading.value=true;
    moviesDetailsResponse.value=await repo.getMoviesDetails(id);
    if(resultCodeMovieDetails==200){
      isLoading.value = false;
    }else{
      isLoading.value = false;
    }
  }

  // Save favorites to shared preferences
  void saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favId', favId.map((id) => id.toString()).toList());
    // Convert List<MoviesDetailsResponse> to List<String> using jsonEncode
    List<String> favJsonList = fav.map((movie) => jsonEncode(movie.toJson())).toList();
    prefs.setStringList('fav', favJsonList);
  }

  // Load favorites from shared preferences
  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favIds = prefs.getStringList('favId');
    if (favIds != null) {
      favId = favIds.map((id) => int.parse(id)).toSet();
      List<String>? favJsonList = prefs.getStringList('fav');
      if (favJsonList != null) {
        fav = favJsonList
            .map((json) => MoviesDetailsResponse.fromJson(jsonDecode(json)))
            .toList();
      }
    }
  }

}