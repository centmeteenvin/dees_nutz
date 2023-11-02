// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemImpl _$$ItemImplFromJson(Map<String, dynamic> json) => _$ItemImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      shoppingListId: json['shoppingListId'] as String,
      participantEntries: (json['participantEntries'] as List<dynamic>)
          .map((e) => ItemParticipantEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ItemImplToJson(_$ItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'shoppingListId': instance.shoppingListId,
      'participantEntries':
          instance.participantEntries.map((e) => e.toJson()).toList(),
    };

_$ItemParticipantEntryImpl _$$ItemParticipantEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$ItemParticipantEntryImpl(
      participantId: json['participantId'] as String,
      weight: json['weight'] as int,
    );

Map<String, dynamic> _$$ItemParticipantEntryImplToJson(
        _$ItemParticipantEntryImpl instance) =>
    <String, dynamic>{
      'participantId': instance.participantId,
      'weight': instance.weight,
    };
