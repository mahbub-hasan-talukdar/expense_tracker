import '../entity/item_entity.dart';

abstract class GenerateReportRepo {
  Future<(List<ItemEntity>?, String?)> getDailyReport();
  Future<(List<ItemEntity>?, String?)> getMonthlyReport();
  Future<(List<ItemEntity>?, String?)> getYearlyReport();
}
