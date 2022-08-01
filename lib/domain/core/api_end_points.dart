import 'package:netflix/core/colors/strings.dart';
import 'package:netflix/infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloads = "$kBaseUrl/trending/all/day?api_key=$apiKey";
  static const search = '$kBaseUrl/search/movie?api_key=$apiKey';

  static const HotAndNewMovie = '$kBaseUrl/discover/movie?api_key=$apiKey';
  static const HotAndNewTv = '$kBaseUrl/discover/tv?api_key=$apiKey';
}

//&language=en-US
