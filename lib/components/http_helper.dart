import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/movie.dart';

class HttpHelper{
  final String urlKey = 'api_key=abc1319c16cf2229b90c2d0cefdc357c';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';

  Future<String> getUpcoming() async{
    final Uri upcoming = Uri.parse(urlBase + urlUpcoming + urlKey + urlLanguage);

    http.Response result = await http.get(upcoming);
    if(result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      return responseBody;
    }else{
      return '{}';
    }
  }

  Future<List> getUpComingAsList() async {
    final Uri upcoming =
    Uri.parse(urlBase + urlUpcoming + urlKey + urlLanguage);
    http.Response result = await http.get(upcoming);
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponseBody = json.decode(result.body); //1
      final movieObjects = jsonResponseBody['results']; //2
      List movies = movieObjects.map((json) => Movie.fromJson(json)).toList();
      return movies;
    } else {
      return [];
    }
  }
}