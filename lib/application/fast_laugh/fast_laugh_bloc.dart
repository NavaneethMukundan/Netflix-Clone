import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/downloads/i_download_repo.dart';
import 'package:netflix/domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final trailVideoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
];

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(
    IDownloadRepo _downloadService,
  ) : super(FastLaughState.initial()) {
    on<FastLaughEvent>((event, emit) async {
      // get Trending
      emit(const FastLaughState(
        videoList: [],
        isLoading: true,
        isError: false,
      ));
      final result = await _downloadService.getDownloadsImages();
      final _state = result.fold(
        (l) {
          return const FastLaughState(
            videoList: [],
            isLoading: false,
            isError: true,
          );
        },
        (resp) => FastLaughState(
          videoList: resp,
          isLoading: false,
          isError: false,
        ),
      );

      // Send to UI

      emit(_state);
    });
  }
}
