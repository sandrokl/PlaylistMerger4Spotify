import 'package:drift/drift.dart';
import 'package:playlistmerger4spotify/database/database.dart';
import 'package:playlistmerger4spotify/database/models/merging_results.dart';

part 'merging_results_dao.g.dart';

@DriftAccessor(tables: [MergingResults])
class MergingResultsDao extends DatabaseAccessor<AppDatabase> with _$MergingResultsDaoMixin {
  MergingResultsDao(AppDatabase db) : super(db);

  Future<void> insert(MergingResult mr) async {
    await into(mergingResults).insert(mr);
  }

  Future<List<MergingResult>> getAll({int? limit, bool? mostRecentFirst}) async {
    var query = select(mergingResults);
    if (limit != null) query.limit(limit);
    if (mostRecentFirst != null) query.orderBy([(p) => OrderingTerm(expression: p.runDate, mode: OrderingMode.desc)]);
    return query.get();
  }

  Future<List<MergingResult>> getByPlaylistId(String playlistId) async {
    return (select(mergingResults)..where((tbl) => tbl.playlistId.equals(playlistId))).get();
  }

  Future<void> cleanOldRecords(int olderThanInDays) async {
    final cutDate = DateTime.now().add(Duration(days: olderThanInDays * -1));
    await (delete(mergingResults)..where((tbl) => tbl.runDate.isSmallerThanValue(cutDate))).go();
  }

  Future<MergingResult?> getLastSuccessfulUpdate(String id) async {
    return (select(mergingResults)
          ..where((tbl) => tbl.playlistId.equals(id) & tbl.successed.equals(true))
          ..orderBy([(p) => OrderingTerm(expression: p.runDate, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
  }
}
