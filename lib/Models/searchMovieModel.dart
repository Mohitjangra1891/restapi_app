// To parse this JSON data, do
//
//     final searchMovieDataModel = searchMovieDataModelFromJson(jsonString);

import 'dart:convert';

SearchMovieDataModel searchMovieDataModelFromJson(String str) =>
    SearchMovieDataModel.fromJson(json.decode(str));

String searchMovieDataModelToJson(SearchMovieDataModel data) =>
    json.encode(data.toJson());

class SearchMovieDataModel {
  List<Search>? search;
  String? totalResults;
  String? response;

  SearchMovieDataModel({
    this.search,
    this.totalResults,
    this.response,
  });

  factory SearchMovieDataModel.fromJson(Map<String, dynamic> json) =>
      SearchMovieDataModel(
        search: json["Search"] == null
            ? []
            : List<Search>.from(json["Search"]!.map((x) => Search.fromJson(x))),
        totalResults: json["totalResults"],
        response: json["Response"],
      );

  Map<String, dynamic> toJson() => {
        "Search": search == null
            ? []
            : List<dynamic>.from(search!.map((x) => x.toJson())),
        "totalResults": totalResults,
        "Response": response,
      };
}

class Search {
  String? title;
  String? year;
  String? type;
  String? poster;

  Search({
    this.title,
    this.year,
    this.type,
    this.poster,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        title: json["Title"],
        year: json["Year"],
        type: json["Type"],
        poster: json["Poster"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Year": year,
        "Type": type,
        "Poster": poster,
      };
}
//
// enum Type { MOVIE }
//
// final typeValues = EnumValues({"movie": Type.MOVIE});
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
