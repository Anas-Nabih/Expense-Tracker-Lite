import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

part 'receipt.g.dart';

@HiveType(typeId: 1)
class Receipt {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final Uint8List image;

  Receipt({
    required this.name,
    required this.image,
  });
}
