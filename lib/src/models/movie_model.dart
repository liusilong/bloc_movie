class MovieModel {
  String title;
  int count;
  int start;
  int total;
  List<SubjectModel> subjects;

  MovieModel({this.title, this.count, this.start, this.total, this.subjects});
  MovieModel.empty() {
    this.title = '';
    this.count = 0;
    this.start = 0;
    this.total = 0;
    this.subjects = [];
  }
  factory MovieModel.fromJson(Map<String, dynamic> map) {
    final originSubjectList = map['subjects'] as List;
    List<SubjectModel> subjectList = [];
    if (originSubjectList.length > 0) {
      subjectList = originSubjectList
          .map((value) => SubjectModel.fromJson(value))
          .toList();
    }
    return MovieModel(
        title: map['title'],
        count: map['count'],
        total: map['total'],
        start: map['start'],
        subjects: subjectList);
  }
}

/// 电影实体
class SubjectModel {
  String title; // 电影名称
  double rating; // 评分
  List<String> genres; // 电影类型
  List<CastModel> casts; // 演员列表
  List<DirectorModel> directors; // 导演列表
  String cover; // 封面
  String alt; // 简介
  String id;

  SubjectModel(
      {this.title,
      this.rating,
      this.genres,
      this.casts,
      this.directors,
      this.cover,
      this.alt,
      this.id});

  factory SubjectModel.fromJson(Map<String, dynamic> map) {
    // 类型
    List<String> genresList = List<String>.from(map['genres']);

    // 演员
    final originCastList = map['casts'] as List;
    List<CastModel> castList =
        originCastList.map((value) => CastModel.fromJson(value)).toList();

    // 导演
    final originDirectorList = map['directors'] as List;
    List<DirectorModel> directorList = originDirectorList
        .map((value) => DirectorModel.fromJson(value))
        .toList();

    return SubjectModel(
        title: map['title'],
        rating: map['rating']['average'] * 1.0, // int to double
        genres: genresList,
        casts: castList,
        directors: directorList,
        cover: map['images']['medium'],
        alt: map['alt'],
        id: map['id']);
  }
}

/// 演员
class CastModel {
  static final String defaultAvatar = "https://user-gold-cdn.xitu.io/2019/4/7/169f5ec4ae950bb3?w=200&h=200&f=png&s=3363";
  String alt; // 简介
  String avatar; // 图像
  String name; // 名称
  String id; // ID

  CastModel({this.alt, this.avatar, this.name, this.id});

  factory CastModel.fromJson(Map<String, dynamic> map) {
    return CastModel(
        alt: map['alt'],
        avatar: map['avatars'] != null ? map['avatars']['small'] : defaultAvatar,
        name: map['name'],
        id: map['id']);
  }
}

/// 导演
class DirectorModel {
  String alt;
  String avatar;
  String name;
  String id;

  DirectorModel({this.alt, this.avatar, this.name, this.id});

  factory DirectorModel.fromJson(Map<String, dynamic> map) {
    return DirectorModel(
        alt: map['alt'],
        avatar: map['avatars']['medium'],
        name: map['name'],
        id: map['id']);
  }
}
