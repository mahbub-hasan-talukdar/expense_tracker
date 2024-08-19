import 'package:expense_tracker/domain/entity/item_entity.dart';
import 'package:expense_tracker/domain/repository/generate_report_repo.dart';

import '../entity/item_summary_entity.dart';

class GenerateReportUseCase {
  GenerateReportRepo generateReportRepo;
  GenerateReportUseCase(this.generateReportRepo);
  Future<(List<ItemEntity>?, String?)> getDailyReport() async {
    return await generateReportRepo.getDailyReport();
  }

  Future<(List<ItemEntity>?, String?)> getMonthlyReport() async {
    return await generateReportRepo.getMonthlyReport();
  }

  Future<(List<ItemEntity>?, String?)> getYearlyReport() async {
    return await generateReportRepo.getYearlyReport();
  }

  Future<(List<ItemSummaryEntity>?, String?)> getItemSummaryReport() async {
    return await generateReportRepo.getItemSummaryReport();
  }
}
