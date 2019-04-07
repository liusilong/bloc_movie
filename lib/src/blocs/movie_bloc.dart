import 'dart:async';
import '../models/movie_model.dart';
import '../base/bloc_provider.dart';
import '../resources/repository.dart';

class MovieBloc implements BlocBase {
  final int count = 10;
  List<SubjectModel> subjectList = [];

  StreamController<MovieModel> _movieController =
      StreamController<MovieModel>.broadcast();
  Sink<MovieModel> get _inMovie => _movieController.sink;
  Stream<MovieModel> get outMovie => _movieController.stream;

  MovieBloc() {
    _init();
  }

  void _init() {
    _fetchMovie(start: 0);
  }

  Future refresh() async {
    subjectList.clear();
    _fetchMovie(start: 0);
  }

  // 加载更多，start 为起始点，每次加载 5 条
  Future loadMore() async {
    await _fetchMovie(start: subjectList.length);
    return null;
  }

  // 拉取数据
  Future _fetchMovie({int start}) async {
    MovieModel movieModel = await repository.fetchAllMovies(start, count);
    subjectList.addAll(movieModel.subjects);
    _inMovie.add(movieModel);
  }

  @override
  void dispose() {
    _movieController.close();
  }
}
