import 'package:pexel/data/dto/photos_dto.dart';

class PhotoDto {
  int page;
  int perPage;
  List<PhotosDto> photos;

  PhotoDto({
    this.page = 1,
    this.perPage = 20,
    required this.photos
  });
}