import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restapi_app/Models/searchMovieModel.dart';
import 'package:http/http.dart' as http;

class moviedata_provider extends ChangeNotifier {
  static String bg_image =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1200px-A_black_image.jpg?20201103073518';
  String respo = 'true';
  String dropdown_value = 'batman';
  String searchtext = 'batman';
  int page = 1;
  bool hasMore = true;

  List<Search> movies = [];

  bool isLoading = false;

  // String get bg_image => bg_image;

  void change_previous(String img) {
    bg_image = img;
    notifyListeners();
  }

  Future<void> getMovies({String? searchterm, int? page}) async {
    // var url = 'https://www.omdbapi.com/?i=tt0944947&page=6&apikey=c80d6176';
    var url =
        'https://www.omdbapi.com/?s=${searchterm ?? "batman"}&page=${page.toString()}&apikey=c80d6176';
    // var url = 'https://www.omdbapi.com/?s=avenger&apikey=c80d6176';
    isLoading = true;
    final response = await http.get(Uri.parse(url));
    isLoading = true;
    print('response waiting   ');

    if (response.statusCode == 200) {
      print('response 200');

      var data = jsonDecode(response.body);
      // print("----Data: $data");
      if (data['Response'] == "True") {
        final moviedata = searchMovieDataModelFromJson(response.body);
        if (moviedata.search != null) {
          movies.addAll(moviedata.search!);
          if (bg_image ==
              'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1200px-A_black_image.jpg?20201103073518') {
            bg_image = movies[0].poster.toString();
          }

          // print("----bddddddddd_movies: $bg_image");
        } else {
          // print("---2222222-_movies: $movies");

          hasMore = false;
        }
        respo = 'true';
      } else {
        hasMore = false;
        // print("----_33333movies: $movies");

        respo = 'false';
      }
    } else {
      print('response failed to parse');
      print('response ${response.statusCode}');

      throw Exception(
          'Failed to load album Status code ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

  void change_dropdown_value(String value) {
    dropdown_value = value;
    notifyListeners();
  }

  void change_searchtext_value(String value) {
    searchtext = value;
    notifyListeners();
  }

  void increase_page() {
    page++;
    print(page);
    notifyListeners();
  }

  void resetMovies() {
    movies = [];
    page = 1;
    hasMore = true;
    isLoading = false;
    bg_image =
        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1200px-A_black_image.jpg?20201103073518';
    notifyListeners();
  }
}
