import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';

class RecipeCategoryNotifier extends StateNotifier<List<RecipeCategory>> {
  RecipeCategoryNotifier() : super([]) {
    _fetchRecipeCategories();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _fetchRecipeCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    final categories = snapshot.docs
        .map((doc) => RecipeCategory.fromFirestore(doc.data(), doc.id))
        .toList();
    state = categories;
  }

  // void addNote(String content) async {
  //   if (userId == '') {
  //     return;
  //   }

  //   final noteData =
  //       Note(id: '', content: content, userId: userId).toFirestore();

  //   final noteRef = await _firestore.collection('notes').add(noteData);
  //   final note = Note.fromFirestore(noteData, noteRef.id);
  //   state = [...state, note];
  // }

  // void deleteNote(String id) async {
  //   await _firestore.collection('notes').doc(id).delete();
  //   state = state.where((note) => note.id != id).toList();
  // }
}

final recipeCategoriesProvider =
    StateNotifierProvider<RecipeCategoryNotifier, List<RecipeCategory>>((ref) {
  return RecipeCategoryNotifier();
});
