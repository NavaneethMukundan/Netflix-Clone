import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:netflix/domain/core/failuers/main_failure.dart';
import 'package:netflix/domain/downloads/i_download_repo.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';
part 'downloads_event.dart';
part 'downloads_state.dart';
part 'downloads_bloc.freezed.dart';

@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadState> {
  final IDownloadRepo _downloadsRepo;
  DownloadsBloc(this._downloadsRepo) : super(DownloadState.inital()) {
    on<_GetDownloadsImage>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          downloadsFailureOrSuccess: none(),
        ),
      );
      final Either<MainFailure, List<Downloads>> downloadsOption =
          await _downloadsRepo.getDownloadsImages();
      log(downloadsOption.toString());
      emit(downloadsOption.fold(
          (failure) => state.copyWith(
              isLoading: false,
              downloadsFailureOrSuccess: Some(
                left(failure),
              )),
          (success) => state.copyWith(
              isLoading: false,
              downloads: success,
              downloadsFailureOrSuccess: some(Right(success)))));
    });
  }
}
