import 'package:hive/hive.dart';

part 'person.g.dart';

@HiveType(typeId:1)
class Person {
  @HiveField(0)
  final String nama;

  @HiveField(1)
  final String kode;

  @HiveField(2)
  final String jadwal;

  Person({
    required this.nama,
    required this.kode,
    required this.jadwal,
  });
}