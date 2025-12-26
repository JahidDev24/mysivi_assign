// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_history_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatHistoryItemAdapter extends TypeAdapter<ChatHistoryItem> {
  @override
  final int typeId = 0;

  @override
  ChatHistoryItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatHistoryItem(
      userName: fields[0] as String,
      lastMessage: fields[1] as String,
      timestamp: fields[2] as DateTime,
      unreadCount: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChatHistoryItem obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.lastMessage)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.unreadCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatHistoryItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
