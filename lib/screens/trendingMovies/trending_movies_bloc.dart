import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/utils/constants.dart';
import 'package:movies_app/screens/trendingMovies/trending_movies_model.dart';
import 'package:movies_app/screens/trendingMovies/trending_movies_repo.dart';
import '../../blocs/bloc.dart';
import '../../server/api_response.dart';


class TrendingMoviesBloc extends Bloc {
  BuildContext context;
  State<StatefulWidget> state;

  TrendingMoviesBloc(this.context, this.state);

  final TrendingMoviesRepo _repo = TrendingMoviesRepo();


  final BehaviorSubject<ApiResponse<TrendingMoviesModel>> _trendingMoviesSubject =
      BehaviorSubject<ApiResponse<TrendingMoviesModel>>();

  BehaviorSubject<ApiResponse<TrendingMoviesModel>> get trendingMoviesSubject =>_trendingMoviesSubject;


  onGetTrendingMovies() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      
      trendingMoviesSubject.add(ApiResponse.loading());

      try{
        _repo.getTrendingMovies().then((response){
          if(response.statusCode ==200){
            trendingMoviesSubject.add(ApiResponse.completed(TrendingMoviesModel.fromJson(json.decode(response.body))));
          }else{
            Fluttertoast.showToast(msg: "Something went wrong",
            backgroundColor: Constants.kDarkColors,textColor: Constants.kPrimaryColor);
          }

        }).onError((error, stackTrace){
          trendingMoviesSubject.add(ApiResponse.error(error.toString()));
          Fluttertoast.showToast(msg: "Something went wrong",
            backgroundColor: Constants.kDarkColors,textColor: Constants.kPrimaryColor);
        });
      }catch (error, stackTrace){
           log("${error.toString()}\n$stackTrace", name: "TRENDING_MOVIES_LOG");
           trendingMoviesSubject.add(ApiResponse.error(error.toString()));
      }
      // }
    } else {
      trendingMoviesSubject.add(
          ApiResponse.error(Constants.INTERNET_CONNECTION_LOST_TITLE));
          Fluttertoast.showToast(msg: Constants.INTERNET_CONNECTION_LOST_TITLE,
            backgroundColor: Constants.kDarkColors,textColor: Constants.kPrimaryColor);
    
    }
  }

  @override
  void dispose() {}
}
