import 'package:meta_components/meta_components.dart';
import 'package:repositories/src/category_repository/src/models/models.dart';

part 'category_repository.g.dart';

@RestApi()
abstract class CategoriesRepository {
  factory CategoriesRepository(Dio dio, {String baseUrl}) =
      _CategoriesRepository;

  @GET('/category')
  Future<List<EventCategory>> getCategories();
}
