// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ShoppingListImpl _$$ShoppingListImplFromJson(Map<String, dynamic> json) =>
    _$ShoppingListImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      itemIds: (json['itemIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      participantEntries: (json['participantEntries'] as List<dynamic>)
          .map((e) =>
              ShoppingListParticipantEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
      picture: json['picture'] as String,
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$$ShoppingListImplToJson(_$ShoppingListImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'itemIds': instance.itemIds,
      'participantEntries':
          instance.participantEntries.map((e) => e.toJson()).toList(),
      'picture': instance.picture,
      'total': instance.total,
    };

_$ShoppingListParticipantEntryImpl _$$ShoppingListParticipantEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$ShoppingListParticipantEntryImpl(
      participantId: json['participantId'] as String,
      currentCost: (json['currentCost'] as num).toDouble(),
    );

Map<String, dynamic> _$$ShoppingListParticipantEntryImplToJson(
        _$ShoppingListParticipantEntryImpl instance) =>
    <String, dynamic>{
      'participantId': instance.participantId,
      'currentCost': instance.currentCost,
    };
