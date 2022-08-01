import 'package:dartz/dartz.dart';
import 'package:netflix/domain/core/failuers/main_failure.dart';
import 'package:netflix/domain/search/model/search_response/search_response.dart';

abstract class SearchServices {
  Future<Either<MainFailure, SearchResponse>> searchMovies({
    required String movieQuery,
  });
}
