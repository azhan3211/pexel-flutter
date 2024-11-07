import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pexel/data/dto/photos_dto.dart';
import 'package:pexel/data/local/menu_items.dart';
import 'package:pexel/dependency_injection/repository_module.dart';
import 'package:pexel/domain/repositories/photo_repository.dart';
import 'package:pexel/data/menu_item.dart';
import 'package:pexel/utils/connection_utils.dart';

class MainController extends GetxController {

  final PhotoRepository photoRepository = getIt<PhotoRepository>();
  final photos = <PhotosDto>[].obs;

  final filterIcon = Icons.grid_on_outlined.obs;
  final isLoadMore = false.obs;
  final isGrid = true.obs;
  final isRefresh = false.obs;
  final isLoading = false.obs;
  final hasMore = true.obs;
  int page = 1;
  final errorMessage = "".obs;

  @override
  void onInit() {
    checkConnection();
    getPhotos();
    super.onInit();
  }

  checkConnection() async {
    if (!await ConnectionUtils.isConnected()) {
      errorMessage.value = "No Internet Connection";
    }
  }

  Future<void> getPhotos() async {
    isLoading.value = true;
    try {
      final data = await photoRepository.getPhotos(page: page);
      photos.clear();
      photos.addAll(data.photos);
      hasMore.value = photos.length == data.page * data.perPage;
      page = data.page;
    } catch (e) {
      errorMessage.value = e.toString();
    }
    isLoading.value = false;
  }

  void changeView(MenuItem menuItem) {
    isGrid.value = menuItem == MenuItems.gridView;
    filterIcon.value = menuItem.icon;
  }

  Future<void> loadMoreImages() async {
    if (!hasMore.value) return;
    isLoadMore.value = true;
    try {
      page++;
      final data = await photoRepository.getPhotos(page: page);
      photos.addAll(data.photos);
      hasMore.value = photos.length == data.page * data.perPage;
    } catch(e) {
      page--;
      errorMessage.value = e.toString();
    }
    isLoadMore.value = false;
  }

  Future<void> refreshData() async {
    isRefresh.value = true;
    try {
      page = 1;
      final data = await photoRepository.getPhotos(page: page, isRefresh: true);
      photos.clear();
      photos.addAll(data.photos);
      hasMore.value = photos.length == data.page * data.perPage;
    } catch (e) {
      errorMessage.value = e.toString();
    }
    isRefresh.value = false;
  }

}