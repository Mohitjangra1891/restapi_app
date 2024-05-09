import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:restapi_app/Models/Movie_data.dart';
import 'package:restapi_app/services/httpservice.dart';

class single_movieScreen extends StatelessWidget {
  String poster;
  String movieID;

  single_movieScreen(this.poster, this.movieID);

  @override
  Widget build(BuildContext context) {
    final deviceheight = MediaQuery.of(context).size.height;
    final devicewidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: deviceheight,
        width: devicewidth,
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// background image
            background_image_widget(poster, context),
            SafeArea(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: foreground_widget(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget background_image_widget(String img, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: NetworkImage(
              img.toString(),
            ),
            fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 13),
        child: Container(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }

  Widget foreground_widget(BuildContext context) {
    return FutureBuilder<MovieDataModel?>(
      future: httpService.getMovies(movieID, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the API call is in progress, show a loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If there is an error during the API call, display an error message
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          // When data is received, display it accordingly
          MovieDataModel? movie = snapshot.data;
          return movie != null
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          // color: Colors.blue,
                          // padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          // width: MediaQuery.of(context).size.width*0.35,
                          alignment: Alignment.center,
                          child: Image.network(
                            movie.poster ??
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/A_black_image.jpg/1200px-A_black_image.jpg?20201103073518',
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(movie.title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                            // Spacer(),
                            SizedBox(width: 12),

                            Text(movie.imdbRating!,
                                style: TextStyle(
                                    fontSize: 24,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.yellowAccent.shade700)),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          "${movie.released} | Runtime:${movie.runtime}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),

                        Text(
                          "Genre: ${movie.genre}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2),

                        Text(
                          "Actors: ${movie.actors}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("${movie.plot}",
                            maxLines: 4,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                        // Add more fields as necessary
                      ],
                    ),
                  ),
                )
              : Center(child: Text("No movie data available."));
        } else {
          // If no data is received, display a message indicating no data
          return Center(child: Text("No data found"));
        }
      },
    );
  }
}
