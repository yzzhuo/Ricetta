import 'package:firebase_storage/firebase_storage.dart';
import 'package:Ricetta/models/category.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryCard extends StatelessWidget {
  final RecipeCategory category;
  const CategoryCard({super.key, required this.category});

  Future<String> getImageUrl(String imagePath) async {
    String imageUrl =
        await FirebaseStorage.instance.refFromURL(imagePath).getDownloadURL();
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.push('/category/cid1');
        },
        child: Container(
          width: double.infinity,
          height: 74,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Text(category.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ))),
              SizedBox(
                width: 76,
                child: FutureBuilder(
                  future: getImageUrl(category.image),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return Image.network(snapshot.data!);
                    } else if (snapshot.error != null) {
                      // Handle errors
                      return const Icon(Icons.error);
                    } else {
                      // Placeholder for loading state
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
