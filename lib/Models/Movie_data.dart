// To parse this JSON data, do
//
//     final movieDataModel = movieDataModelFromJson(jsonString);

import 'dart:convert';

MovieDataModel movieDataModelFromJson(String str) =>
    MovieDataModel.fromJson(json.decode(str));

String movieDataModelToJson(MovieDataModel data) => json.encode(data.toJson());

class MovieDataModel {
  String? title;
  String? year;
  String? released;
  String? runtime;
  String? genre;
  String? actors;
  String? plot;
  String? language;
  String? country;
  String? awards;
  String? poster;
  String? imdbRating;
  String? imdbId;
  String? type;
  String? response;

  MovieDataModel({
    this.title,
    this.year,
    this.released,
    this.runtime,
    this.genre,
    this.actors,
    this.plot,
    this.language,
    this.country,
    this.awards,
    this.poster,
    this.imdbRating,
    this.imdbId,
    this.type,
    this.response,
  });

  factory MovieDataModel.fromJson(Map<String, dynamic> json) => MovieDataModel(
        title: json["Title"],
        year: json["Year"],
        released: json["Released"],
        runtime: json["Runtime"],
        genre: json["Genre"],
        actors: json["Actors"],
        plot: json["Plot"],
        language: json["Language"],
        country: json["Country"],
        awards: json["Awards"],
        poster: json["Poster"],
        imdbRating: json["imdbRating"],
        imdbId: json["imdbID"],
        type: json["Type"],
        response: json["Response"],
      );

  Map<String, dynamic> toJson() => {
        "Title": title,
        "Year": year,
        "Released": released,
        "Runtime": runtime,
        "Genre": genre,
        "Actors": actors,
        "Plot": plot,
        "Language": language,
        "Country": country,
        "Awards": awards,
        "Poster": poster,
        "imdbRating": imdbRating,
        "imdbID": imdbId,
        "Type": type,
        "Response": response,
      };
}
