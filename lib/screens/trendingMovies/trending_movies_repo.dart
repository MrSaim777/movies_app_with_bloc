import 'package:http/http.dart' as http;
import 'package:movies_app/utils/constants.dart';


class TrendingMoviesRepo{
  Future<http.Response> getTrendingMovies() async {
  final Map<String, String> queryParams = {
    Constants.API_KEY: Constants.api_key
  };

  final Uri uri = Uri.parse(Constants.getTrendingMovies).replace(queryParameters: queryParams);
  final http.Response response = await http.get(uri);
  return response;
}
}

