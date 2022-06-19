import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:blackshop/models/Category.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/CategoryModels.dart';
import '../../../providers/CategoryProvider.dart';
import '../../../providers/DetailCategoryProvider.dart';

class Categories extends StatefulWidget {
// final CategoryModels category;
  // Categories(this.category);
  // const Categories({
  //   Key? key,
  // }) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    print({categoryProvider.category, "sembarang"});
    return SizedBox(
      height: 84,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categoryProvider.category.length,
        itemBuilder: (context, index) => CategoryCard(
          icon: "https://cdd9-180-253-162-136.ap.ngrok.io/storage/kategori/" +
              categoryProvider.category[index].image.toString(),
          // title: categoryProvider.category[index].name.toString(),
          title: categoryProvider.category[index].name.toString(),
          press: () async {
            // print(sharedPreferences.getInt("id").toString());
            await Provider.of<DetailCategoryProvider>(context, listen: false)
                .getListCategory(slug: categoryProvider.category[index].slug);
            Navigator.pushNamed(context, '/skincare_product');
          },
        ),
        separatorBuilder: (context, index) =>
            const SizedBox(width: defaultPadding),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String icon, title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press,
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: defaultPadding / 2, horizontal: defaultPadding / 4),
        child: Column(
          children: [
            Container(width: 27, height: 38, child: Image.network(icon)),
            const SizedBox(height: defaultPadding / 2),
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
