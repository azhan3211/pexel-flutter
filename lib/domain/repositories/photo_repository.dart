import 'package:pexel/data/dto/photo_dto.dart';

abstract class PhotoRepository {
  Future<PhotoDto> getPhotos({int page = 1, int perPage = 20, bool isRefresh = false});
}