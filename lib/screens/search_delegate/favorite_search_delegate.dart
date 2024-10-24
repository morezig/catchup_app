import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:catchup_app/constants.dart';
import 'package:catchup_app/controllers/favorites_controller.dart';
import 'package:catchup_app/models/product.dart';
import 'package:catchup_app/widgets/tiles/favorite_list_tile.dart';

class FavoriteSearchDelegate extends SearchDelegate {
  final FavoritesController _favoritesController = Get.find();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return resultsList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return resultsList();
  }

  Widget resultsList() {
    List<Product> results = _favoritesController.favoritesList.where((p) => (p.name.contains(query))).toList();
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: results.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        return FavoriteListTile(
          product: results.elementAt(index),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 12,
          thickness: 1,
          color: kSnowFlakeWhite,
          indent: 20,
          endIndent: 20,
        );
      },
    );
  }
}
