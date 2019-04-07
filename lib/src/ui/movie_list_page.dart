import 'package:flutter/material.dart';
import '../blocs/movie_bloc.dart';
import '../base/bloc_provider.dart';
import '../models/movie_model.dart';
import './movie_item.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';

class MovieListPage extends StatefulWidget {
  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  static const bgUrl =
      'https://user-gold-cdn.xitu.io/2019/4/6/169f2c275667fdb9?w=2400&h=1600&f=jpeg&s=457720';
  ScrollController _scrollController = ScrollController();
  bool isPerformingRequest = false;
  MovieBloc movieBloc;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!isPerformingRequest) {
          isPerformingRequest = true;
          await movieBloc.loadMore();
          isPerformingRequest = false;
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    movieBloc = BlocProvider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text('Top250'),
                expandedHeight: 200,
                floating: true,
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                backgroundColor: Colors.red,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: NetworkImage(bgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: new BackdropFilter(
                      filter: new ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                      child: new Container(
                        decoration: new BoxDecoration(
                            color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                  ),
                ),
              )
            ];
          },
          body: StreamBuilder<MovieModel>(
            stream: movieBloc.outMovie,
            initialData: MovieModel.empty(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return NotificationListener<ScrollNotification>(
                  child: new RefreshIndicator(
                    onRefresh: () async {
                      await movieBloc.refresh();
                      return null;
                    },
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 8.0),
                      itemCount: movieBloc.subjectList.length,
                      itemBuilder: (context, index) {
                        if (index == movieBloc.subjectList.length - 1) {
                          return _buildProgressIndicator();
                        } else {
                          return MovieItemLayout(movieBloc.subjectList[index]);
                        }
                      },
                    ),
                  ),
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      if (!isPerformingRequest) {
                        isPerformingRequest = true;
                        movieBloc.loadMore().then((dynamic) {
                          isPerformingRequest = false;
                        });
                      }
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoActivityIndicator(),
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text('Loadding...'),
            )
          ],
        ),
      ),
    );
  }
}
