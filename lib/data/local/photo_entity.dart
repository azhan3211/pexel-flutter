import 'dart:ffi';

import 'package:objectbox/objectbox.dart';
import 'package:pexel/data/local/photos_entity.dart';

@Entity()
class PhotoEntity {
  @Id()
  int id;
  int page;
  int perPage;

  PhotoEntity({
    this.id = 0,
    this.page = 1,
    this.perPage = 20
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'page': page,
      'perPage': perPage
    };
  }
}