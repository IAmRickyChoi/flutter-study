import 'dart:io';
import 'package:calendar_scheduler/model/category.dart';
import 'package:calendar_scheduler/model/schedule_with_category.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

part 'drift.g.dart';

@DriftDatabase(tables: [ScheduleTable, CategoryTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<int> createCategory(CategoryTableCompanion data) =>
      into(categoryTable).insert(data);

  Future<List<CategoryTableData>> getCategories() =>
      select(categoryTable).get();

  Future<ScheduleWithCategory> getScheduleById(int id) {
    final query = select(scheduleTable).join([
      innerJoin(
        categoryTable,
        categoryTable.id.equalsExp(scheduleTable.colorId),
      ),
    ])..where(scheduleTable.id.equals(id));

    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);

      return ScheduleWithCategory(category: category, schedule: schedule);
    }).getSingle();
  }

  Future<int> updateScheduleById(int id, ScheduleTableCompanion data) =>
      (update(scheduleTable)..where((tbl) => tbl.id.equals(id))).write(data);

  Future<List<ScheduleTableData>> getSchedules(DateTime date) =>
      (select(scheduleTable)..where((tbl) => tbl.date.equals(date))).get();

  Stream<List<ScheduleWithCategory>> streamSchedules(DateTime date) {
    final query = select(scheduleTable).join([
      innerJoin(
        categoryTable,
        categoryTable.id.equalsExp(scheduleTable.colorId),
      ),
    ])..where(scheduleTable.date.equals(date));

    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);

      return ScheduleWithCategory(category: category, schedule: schedule);
    }).watch();
  }
  // (select(scheduleTable)
  //       ..where((tbl) => tbl.date.equals(date))
  //       ..orderBy([
  //         (tbl) => OrderingTerm(
  //           expression: tbl.startTime,
  //           mode: OrderingMode.asc,
  //         ),
  //         (tbl) =>
  //             OrderingTerm(expression: tbl.endTime, mode: OrderingMode.asc),
  //       ]))
  //     .watch();

  // final selectQuery = select(scheduleTable);
  // selectQuery.where((tbl) => tbl.date.equals(date));

  // return selectQuery.get();

  Future<int> createSchedule(ScheduleTableCompanion data) =>
      into(scheduleTable).insert(data);

  Future<int> removeSchedule(int id) =>
      (delete(scheduleTable)..where((tbl) => tbl.id.equals(id))).go();

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    final cachbase = await getTemporaryDirectory();

    sqlite3.tempDirectory = cachbase.path;

    return NativeDatabase.createInBackground(file);
  });
}
