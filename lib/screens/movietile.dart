import 'package:flutter/material.dart';
import 'package:restapi_app/Models/Movie_data.dart';
import 'package:restapi_app/Models/searchMovieModel.dart';

class movietile extends StatelessWidget {
  final height;
  final width;
  final Search Movie;

  const movietile({super.key, this.height, this.width, required this.Movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(vertical: height * 0.01),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            width: width * 0.40,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(Movie.poster!),
            )),
          ),
          movieinfo()
        ],
      ),
    );
  }

  Widget movieinfo() {
    var rank_pad = height * 0.02;
    var des_pad = height * 0.07;

    return Container(
      height: height,
      width: width * 0.55,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                // width: width * 0.56,
                child: Text(
                  Movie.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              ),
              // Text(
              //   Movie.imdbRating!,
              //   style: TextStyle(
              //     fontSize: 22,
              //     color: Colors.white,
              //   ),
              // ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, height * 0.02, 0, 0),
            child: Text(
              "Type: ${Movie.type}  | ${Movie.year.toString()} ",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, height * 0.05, 0, 0),
            // child: Text(
            //   "${Movie.plot.toString()}",
            //   maxLines: 8,
            //   overflow: TextOverflow.ellipsis,
            //   style: TextStyle(color: Colors.white70, fontSize: 13),
            // ),
          ),
        ],
      ),
    );
  }
}
