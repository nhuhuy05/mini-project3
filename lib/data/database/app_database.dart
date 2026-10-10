import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/receipt_model.dart';

/// Lớp quản lý kết nối và khởi tạo cơ sở dữ liệu cục bộ SQLite (AppDatabase) - Đã cập nhật tuần này
/// Đảm bảo tính offline 100%, an toàn và khởi tạo bảng `receipts`.
class AppDatabase {
  AppDatabase._internal();
  static final AppDatabase instance = AppDatabase._internal();

  static const String _dbName = 'bill_lens.db';
  static const int _dbVersion = 1;
  static const String tableReceipts = 'receipts';

  Database? _database;

  /// Lấy thể hiện Database (mô hình Singleton)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (kIsWeb) {
      // Môi trường Web không hỗ trợ sqflite native
      // Sử dụng in-memory database của sqflite_common_ffi nếu cần hoặc database giả lập
      return openDatabase(inMemoryDatabasePath, version: _dbVersion,
          onCreate: (db, version) async {
        await _createTables(db);
        await seedInitialData(db);
      });
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await _createTables(db);
        await seedInitialData(db);
      },
    );
  }

  /// Tạo bảng `receipts` với các trường theo đúng đặc tả Mục 13
  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableReceipts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        merchant TEXT NOT NULL,
        total REAL NOT NULL,
        date TEXT NOT NULL,
        category TEXT NOT NULL,
        imagePath TEXT NOT NULL,
        rawText TEXT NOT NULL,
        note TEXT,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  /// Chèn 4 hóa đơn mẫu ban đầu theo đúng yêu cầu Mục 23 (Test Data)
  /// Giúp người dùng và giảng viên có thể test ngay các chức năng thống kê và lịch sử
  Future<void> seedInitialData(Database db) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final sampleReceipts = [
      ReceiptModel(
        merchant: 'WINMART',
        total: 150000,
        date: today,
        category: 'Thực phẩm',
        imagePath: '',
        rawText: 'WINMART\nSua tuoi TH True Milk 45.000\nBanh mi 20.000\nNuoc 15.000\nTOTAL 150.000 VND',
        note: 'Mua đồ ăn sáng và nước uống',
        createdAt: today.add(const Duration(hours: 8, minutes: 30)),
      ),
      ReceiptModel(
        merchant: 'CIRCLE K',
        total: 85000,
        date: today.subtract(const Duration(days: 1)),
        category: 'Thực phẩm',
        imagePath: '',
        rawText: 'CIRCLE K\nSnack & Cafe\nTOTAL: 85.000 đ',
        note: 'Cà phê sáng',
        createdAt: today.subtract(const Duration(days: 1)).add(const Duration(hours: 9, minutes: 15)),
      ),
      ReceiptModel(
        merchant: 'FPT SHOP',
        total: 1200000,
        date: today.subtract(const Duration(days: 3)),
        category: 'Thiết bị',
        imagePath: '',
        rawText: 'FPT SHOP\nChuot khong day & Ban phim co\nTOTAL: 1.200.000 VND',
        note: 'Phụ kiện phục vụ làm đồ án',
        createdAt: today.subtract(const Duration(days: 3)).add(const Duration(hours: 14)),
      ),
      ReceiptModel(
        merchant: 'BOOKSTORE',
        total: 250000,
        date: today.subtract(const Duration(days: 5)),
        category: 'Nghiên cứu',
        imagePath: '',
        rawText: 'BOOKSTORE\nGiao trinh Flutter & AI on-device\nTOTAL: 250.000 VND',
        note: 'Sách chuyên khảo sinh viên',
        createdAt: today.subtract(const Duration(days: 5)).add(const Duration(hours: 16, minutes: 45)),
      ),
    ];

    for (final receipt in sampleReceipts) {
      await db.insert(tableReceipts, receipt.toMap());
    }
  }

  /// Đóng kết nối cơ sở dữ liệu khi cần
  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
