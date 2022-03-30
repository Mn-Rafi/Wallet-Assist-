// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilehiveclass.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileDetailsAdapter extends TypeAdapter<ProfileDetails> {
  @override
  final int typeId = 0;

  @override
  ProfileDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileDetails(
      nameofUser: fields[0] as String,
      initialWalletBalance: fields[1] as String,
      imageUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nameofUser)
      ..writeByte(1)
      ..write(obj.initialWalletBalance)
      ..writeByte(2)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
