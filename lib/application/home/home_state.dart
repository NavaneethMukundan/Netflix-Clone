part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required String stateId,
    required List<HotAndNewData> pastYearMovieList,
    required List<HotAndNewData> trendingMovieList,
    required List<HotAndNewData> tensDramsMovieList,
    required List<HotAndNewData> southIndianMovieList,
    required List<HotAndNewData> trendingTvList,
    required bool isLoading,
    required bool hasError,
  }) = _Initial;

  factory HomeState.inital() => const HomeState(
      stateId: '0',
      pastYearMovieList: [],
      trendingMovieList: [],
      tensDramsMovieList: [],
      southIndianMovieList: [],
      trendingTvList: [],
      isLoading: false,
      hasError: false);
}
