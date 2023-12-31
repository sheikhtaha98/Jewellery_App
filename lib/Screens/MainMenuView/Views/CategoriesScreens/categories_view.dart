import 'package:flutter/material.dart';
import 'package:ui_project/DataBases/Categories.dart';
import 'package:ui_project/Screens/MainMenuView/Views/CategoriesScreens/CategoryFirstContainer/firstContainer_Category.dart';

import 'Rest_of_the_CategoryScreen/productGrid_view.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FirstCategoryContainer(),
            Expanded(
              child: Products(
                Categories: Categories.category,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
