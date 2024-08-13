import 'package:expense_tracker/data/data_source/data_source.dart';
import 'package:expense_tracker/domain/entity/item_entity.dart';
import 'package:expense_tracker/domain/repository/repository.dart';

class RepositoryImp implements Repository {
  @override
  Future<(List<ItemEntity>?, String?)> readItems() async {
    DataSource dataSource = DataSource();
    return await dataSource.readItems();
  }
}
