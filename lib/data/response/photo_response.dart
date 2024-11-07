import 'package:pexel/data/response/photos_response.dart';
import 'package:pexel/data/response/src_response.dart';

class PhotoResponse {
  int? totalResults;
  int? page;
  int? perPage;
  List<PhotosResponse>? photos = [];
  String? nextPage;

  PhotoResponse({
    this.totalResults,
    this.page,
    this.perPage,
    this.photos,
    this.nextPage
  });

  factory PhotoResponse.fromJson(Map<String, dynamic> json) {
    final photos = (json['photos'] as List?)?.map((item) => PhotosResponse.fromJson(item)).toList();
    return PhotoResponse(
      totalResults: json['total_results'],
      page: json['page'],
      perPage: json['per_page'],
      photos: photos ?? [],
      nextPage: json['next_page'],
    );
  }
}