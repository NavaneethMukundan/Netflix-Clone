import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/api_end_points.dart';
import 'package:netflix/domain/core/failuers/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix/domain/downloads/i_download_repo.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';

@LazySingleton(as: IDownloadRepo)
class DownloadRepository extends IDownloadRepo {
  @override
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImages() async {
    try {
      final response = await Dio(BaseOptions()).get(ApiEndPoints.downloads);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final downloadsList = (response.data['results'] as List).map((e) {
          return Downloads.fromJson(e);
        }).toList();
        print(downloadsList);
        return Right(downloadsList);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.clientFailure());
    }
  }
}
