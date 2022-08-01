import 'package:dartz/dartz.dart';
import 'package:netflix/domain/core/failuers/main_failure.dart';
import 'package:netflix/domain/hot_and_new/model/hot_and_new.dart';

abstract class HotAndNewServices {
  Future<Either<MainFailure, HotAndNew>> getHotAndNewMovieData();
  Future<Either<MainFailure, HotAndNew>> getHotAndNewTvData();
}
