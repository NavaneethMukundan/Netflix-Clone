import 'package:dartz/dartz.dart';
import 'package:netflix/domain/core/failuers/main_failure.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';

abstract class IDownloadRepo {
  Future<Either<MainFailure, List<Downloads>>> getDownloadsImages();
}
