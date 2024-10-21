import 'package:hive_flutter/hive_flutter.dart';
 part 'book_mark_model.g.dart';
@HiveType(typeId: 1)
class BookMarkModel {
  @HiveField(0)
  String? image;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? source;
  BookMarkModel(this.description, this.image, this.source, this.title);
}
