class Category {
  final String icon, title;

  Category({required this.icon, required this.title});
}

List<Category> demo_categories = [
  Category(
    icon: "assets/icons/skincare.png",
    title: "Skincare",
  ),
  Category(
    icon: "assets/icons/snack.png",
    title: "Snack",
  ),
  Category(
    icon: "assets/icons/dress.png",
    title: "Fashion",
  ),
  // Category(
  //   icon: "assets/icons/Tshirt.svg",
  //   title: "Tshirt",
  // ),
];
