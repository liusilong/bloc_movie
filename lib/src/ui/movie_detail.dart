import 'package:flutter/material.dart';
import '../models/movie_model.dart';

class MovieDetail extends StatefulWidget {
  final SubjectModel subjectModel;
  MovieDetail(this.subjectModel);
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.subjectModel.title),
        ),
      ),
    );
  }
}
