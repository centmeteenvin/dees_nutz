import "package:freezed_annotation/freezed_annotation.dart";

part 'person.freezed.dart';
part 'person.g.dart';

@freezed
class Person with _$Person {
  
factory Person({
    required String id,
    required String name,
    required String profilePicture,
    @Default([]) List<String> shoppingListIds,
  }) = _Person;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}