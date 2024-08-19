import '../../config/service_locator.dart';
import '../repository/item_list_repo.dart';

class ItemListUseCase {
  Future<void> deleteDayData(String date) async {
    await sl<ItemListRepo>().deleteExpensesByDate(date);
  }
}
