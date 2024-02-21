import 'dart:io';
import '../model/moviesDetailsModel/MoviesDetailsResponse.dart';
import '../model/moviesModel/MoviesResponse.dart';
import '../web_service/WebServices.dart';

class Repo {
  WebService webService;
  Repo(this.webService);

  Future<MoviesResponse> getMovies(int page)async{
    var movies=webService.getMovies(page);
    return movies;
  }

  Future<MoviesResponse> searchMovies(int page,String word)async{
    var search=webService.searchMovies(page,word);
    return search;
  }

  Future<MoviesDetailsResponse> getMoviesDetails(int id)async{
    var moviesDetails=webService.getMoviesDetails(id);
    return moviesDetails;
  }
}