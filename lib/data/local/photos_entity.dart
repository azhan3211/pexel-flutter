import 'package:objectbox/objectbox.dart';

@Entity()
class PhotosEntity {
  @Id()
  int id;
  String photographer;
  String imageUrl;
  String imageOriginalUrl;
  String description;
  String photographerUrl;

  PhotosEntity({
    this.id = 0,
    this.photographer = "",
    this.imageUrl = "",
    this.imageOriginalUrl = "",
    this.description = "",
    this.photographerUrl = ""
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photographer': photographer,
      'imageUrl': imageUrl,
      'imageOriginalUrl': imageOriginalUrl,
      'description': description,
      'photographerUrl': photographerUrl,
    };
  }
}