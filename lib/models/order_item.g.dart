// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderItemAdapter extends TypeAdapter<OrderItem> {
  @override
  final int typeId = 1;

  @override
  OrderItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderItem(
      subTotal: fields[7] as String,
      discount: fields[8] as int,
      delivery: fields[9] as String,
      total: fields[10] as String,
      deliveryFee: fields[12] as int,
      paymentDetails: fields[1] as String,
      deliveryOption: fields[2] as String,
      orderStatus: fields[3] as int,
      statusMessage: fields[4] as String,
      orderDate: fields[5] as DateTime,
      orderNumber: fields[6] as int,
      product: (fields[0] as List).cast<Product>(),
      contacts: (fields[11] as List).cast<String>(),
      productQuantity: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OrderItem obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.product)
      ..writeByte(1)
      ..write(obj.paymentDetails)
      ..writeByte(2)
      ..write(obj.deliveryOption)
      ..writeByte(3)
      ..write(obj.orderStatus)
      ..writeByte(4)
      ..write(obj.statusMessage)
      ..writeByte(5)
      ..write(obj.orderDate)
      ..writeByte(6)
      ..write(obj.orderNumber)
      ..writeByte(7)
      ..write(obj.subTotal)
      ..writeByte(8)
      ..write(obj.discount)
      ..writeByte(9)
      ..write(obj.delivery)
      ..writeByte(10)
      ..write(obj.total)
      ..writeByte(11)
      ..write(obj.contacts)
      ..writeByte(12)
      ..write(obj.deliveryFee)
      ..writeByte(13)
      ..write(obj.productQuantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
