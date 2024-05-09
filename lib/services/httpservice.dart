import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:restapi_app/Models/Movie_data.dart';
import 'package:restapi_app/Models/searchMovieModel.dart';
import 'package:http/http.dart' as http;
import 'package:restapi_app/providers/moviedata_provider.dart';

class httpService {
  static Future<MovieDataModel> getMovies(
      String title, BuildContext context) async {
    // var url = 'https://www.omdbapi.com/?i=tt0944947&page=6&apikey=c80d6176';
    var url = 'https://www.omdbapi.com/?t=$title&apikey=c80d6176';
    // var url = 'https://www.omdbapi.com/?s=avenger&apikey=c80d6176';

    final response = await http.get(Uri.parse(url));
    print('response waiting ');

    if (response.statusCode == 200) {
      // print('response 200');

      var data = jsonDecode(response.body);
      // print("Data: $data");
      if (data['Response'] == "True") {
        var movie = MovieDataModel.fromJson(jsonDecode(response.body));
        // print('${movie.poster}');
        context.read<moviedata_provider>().change_previous(movie.poster ??
            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1200px-A_black_image.jpg?20201103073518');
        return movie;
      } else {
        throw Exception('Failed -- response -== false --');
      }
    } else {
      print('response failed to parse');
      print('response ${response.statusCode}');

      throw Exception(
          'Failed to load album Status code ${response.statusCode}');
    }
  }
}
