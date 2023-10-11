// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImcAdapter extends TypeAdapter<Imc> {
  @override
  final int typeId = 0;

  @override
  Imc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Imc()
      ..peso = (fields[0] as List?)?.cast<double>()
      ..altura = fields[1] as double?
      ..nome = fields[2] as String?
      ..data = (fields[3] as List?)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, Imc obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.peso)
      ..writeByte(1)
      ..write(obj.altura)
      ..writeByte(2)
      ..write(obj.nome)
      ..writeByte(3)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImcAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
