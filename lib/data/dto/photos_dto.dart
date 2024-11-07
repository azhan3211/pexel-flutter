class PhotosDto {
  int id;
  String photographer;
  String imageUrl;
  String imageOriginalUrl;
  String description;
  String photographerUrl;

  PhotosDto({
    this.id = 0,
    this.photographer = "",
    this.imageUrl = "",
    this.imageOriginalUrl = "",
    this.description = "",
    this.photographerUrl = ""
  });
}