import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import './movie_detail.dart';

class MovieItemLayout extends StatelessWidget {
  final SubjectModel subject;
  MovieItemLayout(this.subject);
  @override
  Widget build(BuildContext context) {
    // 演员列表
    var avatars = List.generate(
      subject.casts.length,
      (index) => Container(
            margin: EdgeInsets.only(left: 8.0),
            child: CircleAvatar(
                backgroundColor: Colors.white10,
                backgroundImage: NetworkImage(subject.casts[index].avatar)),
          ),
    );
    return GestureDetector(
      child: Card(
        child: Container(
          margin: EdgeInsets.all(4.0),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.network(subject.cover,
                    width: 100.0, height: 150.0, fit: BoxFit.fill),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8.0),
                  height: 150.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // 电影名称
                      Text(
                        subject.title,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        '豆瓣评分: ${subject.rating}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text('类型: ${subject.genres.join("、")}'),
                      Text('导演: ${subject.directors[0].name}'),
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: <Widget>[
                            Text('主演'),
                            Row(
                              children: avatars,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _openDetailPage(context, subject);
      },
    );
  }

  _openDetailPage(BuildContext context, SubjectModel subject) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MovieDetail(subject);
    }));
  }
}
