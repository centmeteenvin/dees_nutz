import 'package:diw/models/person.dart';
import 'package:diw/providers/person_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentSelectedPersonProviderId = StateProvider<String?>((ref) {
  return null;
});

final currentSelectedPersonProvider = FutureProvider<Person?>((ref) async {
  final currentSelectedPersonId = ref.watch(currentSelectedPersonProviderId);
  if (currentSelectedPersonId == null) return null;
  return await ref.watch(personProvider(currentSelectedPersonId).future);
});