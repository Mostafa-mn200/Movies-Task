import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../business/moviesController/MoviesController.dart';
import '../../business/searchController/SearchController.dart';
import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import 'package:dio/dio.dart' as dio1;
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';

import '../model/moviesDetailsModel/MoviesDetailsResponse.dart';
import '../model/moviesModel/MoviesResponse.dart';


class WebService {
  late dio1.Dio dio;
  late dio1.BaseOptions options;
  var baseUrl = "http://api.themoviedb.org/3/";
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  final store = intMapStoreFactory.store("movies");

  WebService() {
    options = dio1.BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(milliseconds: 70 * 1000),
      receiveTimeout: Duration(milliseconds: 70 * 1000),
    );
    dio = dio1.Dio(options);
  }

  Future<void> _saveMoviesToSharedPreferences(MoviesResponse moviesResponse) async {
    final moviesJson = moviesResponse.toJson();
    await sharedPreferencesService.setString('movies', json.encode(moviesJson));
  }

  Future<MoviesResponse> _getMoviesFromSharedPreferences() async {
    final moviesJson = sharedPreferencesService.getString('movies');

    if (moviesJson != null) {
      final Map<String, dynamic> decodedJson = json.decode(moviesJson);
      return MoviesResponse.fromJson(decodedJson);
    } else {
      return MoviesResponse();
    }
  }


  void handleError(dynamic error) {
    String message = 'An error occurred';

    if (error is DioError) {
      DioError dioError = error;
      if (dioError.error is SocketException) {
        message = 'No internet connection';
      } else if (dioError.response != null) {
        if (dioError.response?.statusCode == 422) {
          dynamic responseData = dioError.response!.data['message'];

          if (responseData is List) {
            if (responseData.isNotEmpty) {
              message = responseData[0];
            }
          } else if (responseData is String) {
            message = responseData;
          }
        } else {
          message = '${dioError.response?.data['message']}';
        }
      } else if (dioError.type == DioErrorType.cancel) {
        message = 'Request was canceled';
      }
    } else if (error is SocketException) {
      message = 'No internet connection';
      // final moviesController = Get.put(MoviesController());
      // moviesController.isLoading.value=false;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  Future<MoviesResponse> getMovies(int page)async{
    final moviesController = Get.put(MoviesController());
    try {
      var Url="discover/movie?";
      var params={
        'api_key':"b09195691090fa86bc73d0bc6b8c7d8d",
        'page': page
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url, queryParameters: params,
          options: dio1.Options(
            headers: {
              "Accept":"application/json",
              "content-type": "application/json",
            },
          )
      );
      print(response);
      moviesController.resultCodeMovie=response.statusCode??0;
      if(response.statusCode==200){
        print("klkl"+MoviesResponse.fromJson(response.data).toString());
        // Save the movie list to SharedPreferences
        moviesController.internet.value=true;
        await _saveMoviesToSharedPreferences(MoviesResponse.fromJson(response.data));

        return MoviesResponse.fromJson(response.data);
      }else{
        print("klkl121"+response.statusMessage.toString());
        // Retrieve movies from SharedPreferences when there's no internet
        return _getMoviesFromSharedPreferences();
      }
    }on DioException catch(e){
      print(e.toString());
      handleError(e);
      // Retrieve movies from SharedPreferences when there's no
      moviesController.internet.value=false;
      return _getMoviesFromSharedPreferences();
    }
  }


  Future<MoviesResponse> searchMovies(int page,String word)async{
    final searchMovieController = Get.put(SearchMovieController());
    try {
      var Url="search/movie?";
      var params={
        'api_key':"b09195691090fa86bc73d0bc6b8c7d8d",
        'page': page,
        'query': word
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url, queryParameters: params,
          options: dio1.Options(
            headers: {
              "Accept":"application/json",
              "content-type": "application/json",
            },
          )
      );
      print(response);
      searchMovieController.resultCodeSearch=response.statusCode??0;
      if(response.statusCode==200){
        print("klkl"+MoviesResponse.fromJson(response.data).toString());
        return MoviesResponse.fromJson(response.data);
      }else{
        print("klkl121"+response.statusMessage.toString());
        return MoviesResponse();
      }
    }on DioException catch(e){
      print(e.toString());
      handleError(e);
      return MoviesResponse();
    }
  }

  Future<MoviesDetailsResponse> getMoviesDetails(int id)async{
    final moviesController = Get.put(MoviesController());
    try {
      var Url="movie/$id?";
      var params={
        'api_key':"b09195691090fa86bc73d0bc6b8c7d8d",
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url, queryParameters: params,
          options: dio1.Options(
            headers: {
              "Accept":"application/json",
              "content-type": "application/json",
            },
          )
      );
      print(response);
      moviesController.resultCodeMovieDetails=response.statusCode??0;
      if(response.statusCode==200){
        print("klkl"+MoviesDetailsResponse.fromJson(response.data).toString());
        return MoviesDetailsResponse.fromJson(response.data);
      }else{
        print("klkl121"+response.statusMessage.toString());
        return MoviesDetailsResponse();
      }
    }on DioException catch(e){
      print(e.toString());
      handleError(e);
      return MoviesDetailsResponse();
    }
  }
}