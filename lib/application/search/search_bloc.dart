import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failuers/main_failure.dart';
import 'package:netflix/domain/downloads/i_download_repo.dart';
import 'package:netflix/domain/search/model/search_response/search_response.dart';
import 'package:netflix/domain/search/search_services.dart';

import '../../domain/downloads/models/downloads.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IDownloadRepo _downloadServices;
  final SearchServices _searchServices;
  SearchBloc(this._downloadServices, this._searchServices)
      : super(SearchState.initial()) {
    // ideal state
    on<initialize>((event, emit) async {
      if (state.idleList.isNotEmpty) {
        emit(SearchState(
          searchResultList: [],
          idleList: state.idleList,
          isLoading: false,
          isError: false,
        ));
        return;
      }
      emit(const SearchState(
        searchResultList: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      // get trending
      final _result = await _downloadServices.getDownloadsImages();
      final _state = _result.fold(
        (MainFailure f) {
          return const SearchState(
            searchResultList: [],
            idleList: [],
            isLoading: false,
            isError: true,
          );
        },
        (List<Downloads> list) {
          return SearchState(
            searchResultList: [],
            idleList: list,
            isLoading: false,
            isError: false,
          );
        },
      );
      // show to UI
      emit(_state);
    });

    // search state
    on<searchMovie>((event, emit) async {
      // call search movie API
      log('Searching for ${event.movieQuery}');
      emit(const SearchState(
        searchResultList: [],
        idleList: [],
        isLoading: true,
        isError: false,
      ));
      final _result =
          await _searchServices.searchMovies(movieQuery: event.movieQuery);
      final _state = _result.fold(
        (MainFailure f) {
          return const SearchState(
            searchResultList: [],
            idleList: [],
            isLoading: false,
            isError: true,
          );
        },
        (SearchResponse r) {
          return SearchState(
            searchResultList: r.results,
            idleList: [],
            isLoading: false,
            isError: false,
          );
        },
      );
      // show to UI
    });
  }
}
