import 'dart:convert';
import 'dart:io';

import 'package:pexel/data/dto/photo_dto.dart';
import 'package:pexel/data/local/photo_entity.dart';
import 'package:pexel/data/local/photos_entity.dart';
import 'package:pexel/data/mapper/photo_mapper.dart';
import 'package:pexel/data/response/photo_response.dart';
import 'package:pexel/data/response/photos_response.dart';
import 'package:pexel/domain/repositories/photo_repository.dart';
import 'package:http/http.dart' as http;
import 'package:objectbox/objectbox.dart';
import 'package:pexel/utils/connection_utils.dart';
import 'package:pexel/utils/object_box_utils.dart';

class PhotoRepositoryImpl extends PhotoRepository {

  static var host = "api.pexels.com";
  static var apiKey = "tQqCMBJtSc5B1O5aIMdyA40JkEPCCPWywKdB0TF9VmGDn2tNdGQGjATW";

  Future<http.Response> getRequest({
    int page = 1,
    int perPage = 20
  }) {
    final uri = Uri.https(host, "/v1/curated", {
      "per_page": perPage.toString(),
      "page": page.toString()
    });
    return http.get(
        uri,
        headers: {
          "Authorization": apiKey,
        }
    ); 
  }

  Future<PhotoDto> _getLocalPhoto(PhotoEntity photoEntity) async {
    Box<PhotosEntity> photos = (await ObjectBoxUtils.getInstance()).store.box<PhotosEntity>();
    final data = photos.getAll();
    await ObjectBoxUtils.close();
    return PhotoDto(
        page: photoEntity.page,
        perPage: photoEntity.perPage,
        photos: PhotoMapper.photosEntityToDto(data)
    );
  }

  Future<void> _insertPhotosEntity(
      List<PhotosResponse> response,
      bool isNew
  ) async {
    Box<PhotosEntity> photos = (await ObjectBoxUtils.getInstance()).store.box<PhotosEntity>();
    if (isNew) photos.removeAll();
    final photosEntity = PhotoMapper.photosResponseToEntity(response);
    for (final photo in photosEntity) {
      photos.put(photo);
    }
  }

  Future<void> removeAllPhotos() async {
    Box<PhotosEntity> photos = (await ObjectBoxUtils.getInstance()).store.box<
        PhotosEntity>();
    photos.removeAll();
  }

  Future<void> _insertData(PhotoResponse response) async {
    Box<PhotoEntity> photoEntity = (await ObjectBoxUtils.getInstance()).store.box<PhotoEntity>();
    var localData = photoEntity.get(1);
    if (localData != null) {
      localData.page = response.page ?? 1;
      await _insertPhotosEntity(response.photos ?? [], false);
    } else {
      localData = PhotoMapper.photoResponseToEntity(response);
      await _insertPhotosEntity(response.photos ?? [], true);
    }
    photoEntity.put(localData);
    await ObjectBoxUtils.close();
  }
  
  @override
  Future<PhotoDto> getPhotos({
    int page = 1,
    int perPage = 20,
    bool isRefresh = false
  }) async {
    Box<PhotoEntity> photoEntity = (await ObjectBoxUtils.getInstance()).store.box<PhotoEntity>();
    final data = photoEntity.get(1);
    if (isRefresh) removeAllPhotos();
    if (data != null && !isRefresh && data.page >= page) {
      return _getLocalPhoto(data);
    }

    if (await ConnectionUtils.isConnected()) {
      try {
        final response = await getRequest(page: page, perPage: perPage);
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          final data = PhotoResponse.fromJson(jsonData);
          await _insertData(data);
          return PhotoMapper.photoResponseToDto(data);
        }
        throw HttpException(response.body);
      } catch (e) {
        throw HttpException(e.toString());
      }
    } else {
      throw Exception("No Internet Connection");
    }
  }

}