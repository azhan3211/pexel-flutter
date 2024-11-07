import 'package:pexel/utils/objectbox_provider.dart';

class ObjectBoxUtils {
  static ObjectBox? _objectBox;

  static Future<ObjectBox> getInstance() async {
    return _objectBox ??= await ObjectBox.create();
  }

  static close() async {
    _objectBox?.store.close();
    _objectBox = null;
  }
}