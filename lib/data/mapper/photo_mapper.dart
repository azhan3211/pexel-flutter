import 'package:get/get.dart';
import 'package:pexel/data/dto/photo_dto.dart';
import 'package:pexel/data/dto/photos_dto.dart';
import 'package:pexel/data/local/photo_entity.dart';
import 'package:pexel/data/local/photos_entity.dart';
import 'package:pexel/data/response/photo_response.dart';
import 'package:pexel/data/response/photos_response.dart';
import 'package:pexel/main.dart';

class PhotoMapper {

  static PhotoDto photoResponseToDto(PhotoResponse response) {
    return PhotoDto(
      page: response.page ?? 0,
      perPage: response.perPage ?? 20,
      photos: response.photos?.map((data) => photosResponseToDto(data)).toList() ?? []
    );
  }

  static PhotosDto photosResponseToDto(PhotosResponse response) {
    return PhotosDto(
        id: response.id ?? 0,
        photographerUrl: response.photographerUrl ?? "",
        photographer: response.photographer ?? "",
        imageUrl: response.src?.large ?? "",
        imageOriginalUrl: response.src?.original ?? "",
        description: response.alt ?? ""
    );
  }

  static PhotoEntity photoResponseToEntity(PhotoResponse response) {
    return PhotoEntity(
      page: response.page ?? 1,
      perPage: response.perPage ?? 20,
    );
  }

  static List<PhotosEntity> photosResponseToEntity(List<PhotosResponse> response) {
    return response.map((photo) => PhotosEntity(
        id: 0,
        imageUrl: photo.src?.large ?? "",
        imageOriginalUrl: photo.src?.original ?? "",
        description: photo.alt ?? "",
        photographer: photo.photographer ?? "",
        photographerUrl: photo.photographerUrl ?? ""
    )).toList();
  }

  static List<PhotosDto> photosEntityToDto(List<PhotosEntity> photos) {
    return photos.map((photo) =>
      PhotosDto(
        id: photo.id,
        photographerUrl: photo.photographerUrl,
        photographer: photo.photographer,
        description: photo.description,
        imageOriginalUrl: photo.imageOriginalUrl,
        imageUrl: photo.imageUrl
      )
    ).toList();
  }

}