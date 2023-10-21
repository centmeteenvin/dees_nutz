import 'package:cloud_firestore/cloud_firestore.dart';
import "package:freezed_annotation/freezed_annotation.dart";
import 'package:uuid/uuid.dart';

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

class PersonService {
  final FirebaseFirestore _firebaseStorage = FirebaseFirestore.instance;


  Future<Person> createPerson({required String name, required String path}) async {
    final Person person = Person(id: const Uuid().v4(), name: name, profilePicture: path);
    await _firebaseStorage.collection("persons").doc(person.id).set(person.toJson());
    return person;
  }

  Stream<List<Person>> getAll() {
    final snapshots = _firebaseStorage.collection("persons").snapshots();
    final personStream = snapshots.map((snapshot) => snapshot.docs.map((doc) => Person.fromJson(doc.data())).toList());
    return personStream;
  }

  Stream<Person> getPerson(String id) {
    final snapshots = _firebaseStorage.collection("persons").doc(id).snapshots();
    final personStream = snapshots.map((snapshot) => Person.fromJson(snapshot.data()!));
    return personStream;
  }

  Future<void> addShoppingList(Person person, String id) async {
    final doc = _firebaseStorage.collection("persons").doc(person.id);
    final shoppingListIds = List.of(person.shoppingListIds);
    if (!shoppingListIds.contains(id)) {
      shoppingListIds.add(id);
    }
    await doc.set(person.copyWith(shoppingListIds: shoppingListIds).toJson());
  }

  void removeShoppingList(Person person, String id) async {
    final doc = _firebaseStorage.collection("persons").doc(person.id);
    final shoppingListIds = List.of(person.shoppingListIds);
    shoppingListIds.remove(id);
    await doc.set(person.copyWith(shoppingListIds: shoppingListIds).toJson());
  }
}