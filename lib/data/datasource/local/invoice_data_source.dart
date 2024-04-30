import 'package:invoice/data/datasource/db_helper.dart';
import 'package:invoice/domain/models/invoice_list.dart';
import 'package:invoice/domain/models/item.dart';
import 'package:sqflite/sqlite_api.dart';

class InvoiceDataSource {
  Future<bool?> insertInvoiceData(Invoice invoice) async {
    final Database db = DatabaseHelper.database!;
    final invoiceMap = invoice.toJson();

    await db.insert(
      invoiceTableName,
      invoiceMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return null;
  }

  Future<bool?> insertItemData(Item item) async {
    final Database db = DatabaseHelper.database!;
    final itemMap = item.toJson();

    // Insert a row into the table.
    await db.insert(
      itemTableName,
      itemMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // getInvoice();
    // getItem();
    //print("item insert ");
    return null;
  }



  Future<List<Invoice>?> getInvoice(int uid ) async {
    List<Invoice> invoices = [];
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result =
      await dbClient.rawQuery('''select * from $invoiceTableName WHERE $id="$uid";''');
      for (var res in result) {
        invoices.add(Invoice.fromJson(res));
      }
      return invoices;
    }
    return null;
  }

  Future<List<Item>?> getItem() async {
    List<Item> items = [];
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result =
          await dbClient.rawQuery("select * from $itemTableName ");
      for (var res in result) {
        items.add(Item.fromJson(res));
      }
      return items;
    }
    return null;
  }

  Future<void> deleteInvoiceById(String inId) async {
    final Database db = DatabaseHelper.database!;

    await db.delete(
      invoiceTableName,
      where: "invoiceId = ?",
      whereArgs: [inId],
    );
  }

  Future<void> updateInvoice(Invoice editInvoice, String iId) async {
    final Database db = DatabaseHelper.database!;

    await db.update(
      invoiceTableName,
      editInvoice.toJson(),
      where: "invoiceId = ?",
      whereArgs: [iId],
    );
  }

  Future<List<Invoice>?> getUpdatedInvoice(String iId) async {
    List<Invoice> invoices = [];
    Database? dbClient = DatabaseHelper.database;
    if (dbClient != null) {
      List<Map<String, dynamic>> result = await dbClient.rawQuery(
          "select * from $invoiceTableName where $invoiceId == $iId ");
      for (var res in result) {
        invoices.add(Invoice.fromJson(res));
      }
      return invoices;
    }
    return null;
  }
}
