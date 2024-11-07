import 'package:get_it/get_it.dart';
import 'package:pexel/data/repositories/photo_repository_impl.dart';
import 'package:pexel/domain/repositories/photo_repository.dart';

final getIt = GetIt.instance;

void setupRepositoryDI() {
  getIt.registerLazySingleton<PhotoRepository>(() => PhotoRepositoryImpl());
}