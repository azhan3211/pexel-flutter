import 'package:pexel/data/local/photo_entity.dart';
import 'package:pexel/objectbox.g.dart';

class ObjectBox {
  late final Store _store;
  late final Box<PhotoEntity> _photoEntity;

  ObjectBox._init(this._store);

  static Future<ObjectBox> init() async {
    final store = await openStore();
    return ObjectBox._init(store);
  }

  PhotoEntity? getPhoto(int id) => _photoEntity.get(id);

  int insertPhoto(PhotoEntity photoEntity) => _photoEntity.put(photoEntity);

  bool deletePhoto(int id) => _photoEntity.remove(id);
}