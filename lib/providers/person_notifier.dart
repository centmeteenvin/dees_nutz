import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diw/models/person.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'person_notifier.g.dart';

@Riverpod(keepAlive: true)
Stream<Person> person(PersonRef ref, String id) {
  final personNotifier = ref.read(personNotifierProvider.notifier);
  return personNotifier.getPerson(id);
}

@riverpod
Stream<List<Person>> persons(PersonsRef ref) {
  final personNotifier = ref.read(personNotifierProvider.notifier);
  return personNotifier.getAll();
}

@Riverpod(keepAlive: true)
class PersonNotifier extends _$PersonNotifier {
  final collectionRef = FirebaseFirestore.instance.collection("persons");

  @override
  void build() {
    return ;
  }

  Future<Person> createPerson({required String name, required String path}) async {
    final Person person = Person(id: const Uuid().v4(), name: name, profilePicture: path);
    await collectionRef.doc(person.id).set(person.toJson());
    return person;
  }

  Stream<List<Person>> getAll() {
    final snapshots = collectionRef.snapshots();
    final personStream = snapshots.map((snapshot) => snapshot.docs.map((doc) => Person.fromJson(doc.data())).toList());
    return personStream;
  }

  Stream<Person> getPerson(String id) {
    final snapshots = collectionRef.doc(id).snapshots();
    final personStream = snapshots.map((snapshot) => Person.fromJson(snapshot.data()!));
    return personStream;
  }

  Future<void> addShoppingList(Person person, String id) async {
    final doc = collectionRef.doc(person.id);
    final shoppingListIds = List.of(person.shoppingListIds);
    if (!shoppingListIds.contains(id)) {
      shoppingListIds.add(id);
    }
    await doc.set(person.copyWith(shoppingListIds: shoppingListIds).toJson());
  }

  Future<void> removeShoppingList(Person person, String id) async {
    final doc = collectionRef.doc(person.id);
    final shoppingListIds = List.of(person.shoppingListIds);
    shoppingListIds.remove(id);
    await doc.set(person.copyWith(shoppingListIds: shoppingListIds).toJson());
  }
}