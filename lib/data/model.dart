class Model {
  final int id;
  final String imagePath;
  final String name;

  Model({
    required this.id,
    required this.imagePath,
    required this.name,
  });
}

List<Model> navBtn = [
  Model(id: 0, imagePath: "assets/images/REQ2.png", name: 'الطلبات'),
  Model(id: 1, imagePath: "assets/images/announ.png", name: 'الإعلانات'),
  Model(id: 2, imagePath: "assets/images/route.png", name: 'أستلام الطفل'),
  Model(id: 3, imagePath: "assets/images/delegate.png", name: 'قائمة المفوضين'),
  Model(
    id: 4,
    imagePath: "assets/images/homepage.png",
    name: 'الرئيسية',
  ),
];
