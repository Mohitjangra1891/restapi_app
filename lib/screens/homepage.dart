import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restapi_app/Models/searchMovieModel.dart';
import 'package:restapi_app/const/constants.dart';
import 'package:restapi_app/providers/moviedata_provider.dart';
import 'package:restapi_app/screens/movietile.dart';
import 'package:restapi_app/screens/single_movieScreen.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var devicewidth;
  var deviceheight;

  @override
  void initState() {
    // TODO: implement initState
    context.read<moviedata_provider>().getMovies(page: 1);
    super.initState();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    deviceheight = MediaQuery.of(context).size.height;
    devicewidth = MediaQuery.of(context).size.width;

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
            background_image_widget(),
            foreground_widget(context),
          ],
        ),
      ),
    );
  }

  Widget background_image_widget() {
    return Container(
      height: deviceheight,
      width: devicewidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: NetworkImage(
              moviedata_provider.bg_image,
            ),
            fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    );
  }

  Widget foreground_widget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: deviceheight * 0.03),
      width: devicewidth * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          searchBox(context),
          Container(
            height: deviceheight * 0.83,
            padding: EdgeInsets.symmetric(vertical: deviceheight * 0.01),
            child: movielist(),
          )
        ],
      ),
    );
  }

  Widget searchBox(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black45,
      ),
      height: deviceheight * 0.08,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: deviceheight * 0.05,
            width: devicewidth * 0.50,
            child: TextFormField(
              controller: searchController,
              onFieldSubmitted: (value) {
                context
                    .read<moviedata_provider>()
                    .change_searchtext_value(value);

                context.read<moviedata_provider>().resetMovies();
                context
                    .read<moviedata_provider>()
                    .getMovies(searchterm: value.toString(), page: 1);
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  fillColor: Colors.white24,
                  filled: false,
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  prefix: Icon(
                    Icons.search,
                    color: Colors.white24,
                  ),
                  hintStyle: TextStyle(color: Colors.white54),
                  hintText: 'Search....'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton(
                dropdownColor: Colors.black38,
                value: context
                    .watch<moviedata_provider>()
                    .dropdown_value
                    .toString(),
                icon: Icon(
                  Icons.menu,
                  color: Colors.white24,
                ),
                underline: Container(
                  height: 1,
                  color: Colors.white24,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'batman',
                    child: Text(
                      popular,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'flash',
                    child: Text(
                      upcoming,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                onChanged: (value) {
                  context
                      .read<moviedata_provider>()
                      .change_dropdown_value(value.toString());
                  context.read<moviedata_provider>().resetMovies();

                  context
                      .read<moviedata_provider>()
                      .getMovies(searchterm: value.toString(), page: 1);

                  context
                      .read<moviedata_provider>()
                      .change_searchtext_value(value.toString());
                }),
          )
        ],
      ),
    );
  }
}

class movielist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceheight = MediaQuery.of(context).size.height;
    final devicewidth = MediaQuery.of(context).size.width;

    return Consumer<moviedata_provider>(
        builder: (context, movieProvider, child) {
      print('comsume calleeeeeeeeee');
      return NotificationListener(
        onNotification: (_onscrollNotificatin) {
          if (_onscrollNotificatin is ScrollEndNotification) {
            final before = _onscrollNotificatin.metrics.extentBefore;
            final max = _onscrollNotificatin.metrics.maxScrollExtent;
            if (before == max) {
              if (movieProvider.hasMore) {
                movieProvider.increase_page();

                movieProvider.getMovies(
                    searchterm: movieProvider.searchtext,
                    page: movieProvider.page);
                return true;
              }

              return false;
            }
            return false;
          }
          return false;
        },
        child: movieProvider.movies.isNotEmpty
            ? ListView.builder(
                itemCount: movieProvider.movies.length +
                    (movieProvider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < movieProvider.movies.length) {
                    Search movie = movieProvider.movies[index];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: deviceheight * 0.01),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => single_movieScreen(
                                      movie.poster!, movie.title!)));
                        },
                        child: movietile(
                          Movie: movie,
                          height: devicewidth * 0.35,
                          width: devicewidth * 0.85,
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              )
            : movieProvider.isLoading
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Text('No data found',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w400)),
                  ),
      );
    }

        // return Consumer<moviedata_provider>(
        //     builder: (context, movieProvider, child) {
        //   return FutureBuilder<SearchMovieDataModel?>(
        //       future: httpService.getMovies(
        //           searchterm: movieProvider.searchtext, page: movieProvider.page),
        //       builder: (context, AsyncSnapshot<SearchMovieDataModel?> snapshot) {
        //         if (snapshot.connectionState == ConnectionState.waiting) {
        //           return Center(child: CircularProgressIndicator());
        //         } else if (snapshot.hasError) {
        //           return Center(
        //               child: Text('Error: ${snapshot.error}',
        //                   style: TextStyle(
        //                       fontSize: 22,
        //                       color: Colors.white,
        //                       fontWeight: FontWeight.w400)));
        //         } else if (snapshot.hasData) {
        //           final moviedata = snapshot.data!;
        //
        //           return NotificationListener(
        //             onNotification: (_onscrollNotificatin) {
        //               if (_onscrollNotificatin is ScrollEndNotification) {
        //                 final before = _onscrollNotificatin.metrics.extentBefore;
        //                 final max = _onscrollNotificatin.metrics.maxScrollExtent;
        //                 if (before == max) {
        //                   movieProvider.increase_page();
        //                   return true;
        //                 }
        //                 return false;
        //               }
        //               return false;
        //             },
        //             child: ListView.builder(
        //               itemCount: moviedata.search?.length,
        //               itemBuilder: (context, index) {
        //                 Search movie = moviedata.search![index];
        //                 return Padding(
        //                   padding:
        //                       EdgeInsets.symmetric(vertical: deviceheight * 0.01),
        //                   child: GestureDetector(
        //                     child: movietile(
        //                       Movie: movie,
        //                       height: devicewidth * 0.35,
        //                       width: devicewidth * 0.85,
        //                     ),
        //                   ),
        //                 );
        //               },
        //             ),
        //           );
        //         } else {
        //           print('snapshot has no data');
        //           print('${snapshot.data}');
        //           return Center(
        //             child: Text('No data found',
        //                 style: TextStyle(
        //                     fontSize: 22,
        //                     color: Colors.white,
        //                     fontWeight: FontWeight.w400)),
        //           );
        //         }
        //       });
        // });
        );
  }
}
