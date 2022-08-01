import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failuers/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix/domain/hot_and_new/hot_and_new_services.dart';
import 'package:netflix/domain/hot_and_new/model/hot_and_new.dart';
import '../../domain/core/api_end_points.dart';

@LazySingleton(as: HotAndNewServices)
class HotAndNewImplementation implements HotAndNewServices {
  @override
  Future<Either<MainFailure, HotAndNew>> getHotAndNewMovieData() async {
    try {
      final response =
          await Dio(BaseOptions()).get(ApiEndPoints.HotAndNewMovie);
      //log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNew.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } on DioError catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, HotAndNew>> getHotAndNewTvData() async {
    try {
      final response = await Dio(BaseOptions()).get(ApiEndPoints.HotAndNewTv);
      //log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNew.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } on DioError catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
