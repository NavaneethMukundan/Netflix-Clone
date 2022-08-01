import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failuers/main_failure.dart';
import 'package:netflix/domain/hot_and_new/hot_and_new_services.dart';
import 'package:netflix/domain/hot_and_new/model/hot_and_new.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewServices _hotAndNewServices;
  HotAndNewBloc(this._hotAndNewServices) : super(HotAndNewState.initial()) {
    // get Hot And New Movie Data
    on<LoadDataInComingSoon>((event, emit) async {
      // send loading to ui

      emit(
        const HotAndNewState(
            comingSoonList: [],
            everyoneIsWtchingList: [],
            isLoading: true,
            hasError: false),
      );
      //get data from remote
      _hotAndNewServices.getHotAndNewMovieData();

      final _result = await _hotAndNewServices.getHotAndNewMovieData();
      // data to state
      final _newState = _result.fold((MainFailure failure) {
        return const HotAndNewState(
          comingSoonList: [],
          everyoneIsWtchingList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNew resp) {
        return HotAndNewState(
          comingSoonList: resp.results,
          everyoneIsWtchingList: state.everyoneIsWtchingList,
          isLoading: false,
          hasError: false,
        );
      });
      emit(_newState);
    });
    // get Hot And New tv Data
    on<LoadDataInEveryOneiSWatching>((event, emit) async {
      emit(
        const HotAndNewState(
            comingSoonList: [],
            everyoneIsWtchingList: [],
            isLoading: true,
            hasError: false),
      );
      //get data from remote
      _hotAndNewServices.getHotAndNewMovieData();

      final _result = await _hotAndNewServices.getHotAndNewTvData();
      // data to state
      final _newState = _result.fold((MainFailure failure) {
        return const HotAndNewState(
          comingSoonList: [],
          everyoneIsWtchingList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNew resp) {
        return HotAndNewState(
          comingSoonList: state.comingSoonList,
          everyoneIsWtchingList: resp.results,
          isLoading: false,
          hasError: false,
        );
      });
      emit(_newState);
    });
  }
}
