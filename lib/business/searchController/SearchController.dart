
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/model/moviesModel/MoviesResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class SearchMovieController extends GetxController {
  Repo repo = Repo(WebService());
  var moviesResponse = MoviesResponse().obs;
  var isLoading = false.obs;
  RxList<dynamic> moviesSearchList=[].obs;
  var isLoadingMore=false;
  var isLoading2=false.obs;
  var resultCodeSearch = 0;
  int page=1;
  final scroll=ScrollController();
  TextEditingController searchTxtController = TextEditingController();


  Future<void> scrollListener()async{
    if(isLoadingMore)return;
    if(scroll.position.pixels == scroll.position.maxScrollExtent){
      isLoadingMore=true;
      page=page+1;
      await searchMovies(page,"");
      isLoadingMore=false;
    }
  }

  searchMovies(int page,String word) async {

    if(page==1){
      isLoading.value = true;
    }else{
      isLoading2.value = true;
    }

    Results? loadingItem;

    if (moviesResponse.value.page != moviesResponse.value.totalPages) {
      loadingItem = Results(originalTitle: "loading");
      moviesSearchList.add(loadingItem!);
    }

    var response = await repo.searchMovies(page,word);

    if (response != null) {
      moviesResponse.value = response;
      List<Results> newData = response.results ?? [];

      if (loadingItem != null) {
        moviesSearchList.remove(loadingItem);
      }

      if (page == 1) {
        moviesSearchList.assignAll(newData);
      } else {
        moviesSearchList.addAll(newData);
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
}