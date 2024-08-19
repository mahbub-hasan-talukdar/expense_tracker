import 'package:expense_tracker/data/data_source/generate_report.dart';
import 'package:expense_tracker/domain/entity/item_entity.dart';
import 'package:expense_tracker/domain/repository/generate_report_repo.dart';

import '../model/item_summary_model.dart';

class GenerateReportRepoImp implements GenerateReportRepo {
  GenerateReportDataSource reportGenerate = GenerateReportDataSource();

  @override
  Future<(List<ItemEntity>?, String?)> getDailyReport() async {
    return await reportGenerate.readDailyItems();
  }

  @override
  Future<(List<ItemEntity>?, String?)> getMonthlyReport() async {
    return await reportGenerate.readMonthlyItems();
  }

  @override
  Future<(List<ItemEntity>?, String?)> getYearlyReport() async {
    return await reportGenerate.readYearlyItems();
  }

  @override
  Future<(List<ItemSummaryModel>?, String?)> getItemSummaryReport() async {
    return await reportGenerate.getItemSummaryReport();
  }
}
