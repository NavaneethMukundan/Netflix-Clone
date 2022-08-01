part of 'hot_and_new_bloc.dart';

@freezed
class HotAndNewState with _$HotAndNewState {
  const factory HotAndNewState({
    required List<HotAndNewData> comingSoonList,
    required List<HotAndNewData> everyoneIsWtchingList,
    required bool isLoading,
    required bool hasError,
  }) = _Initial;

  factory HotAndNewState.initial() => const HotAndNewState(
      comingSoonList: [],
      everyoneIsWtchingList: [],
      hasError: false,
      isLoading: false);
}
