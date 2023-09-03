// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class Constants{
  //Colors
 static const kPrimaryColor = Colors.red;
 static const kDarkColors = Colors.black;
 static const kLightColor = Colors.white;

 //Strings
 static const API_KEY = "api_key";
  static const String INTERNET_CONNECTION_LOST_TITLE =
      "Device is not connected to internet !";
      static const String NO_DATA = 'No Data';
 
 //Server
  static const String api_key = '30481acf88ffb89f68486b89e778b6e3';
  static const String baseUrl = 'https://api.themoviedb.org/3/';
  static const String getTrendingMovies = '${baseUrl}trending/all/week';
}