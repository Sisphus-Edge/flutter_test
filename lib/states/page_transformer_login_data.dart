class IntroItem{

  late final String title;
  late final String category;
  late final String imageUrl;

  IntroItem({
    required this.title,
    required this.category,
    required this.imageUrl,
});
  // IntroItem(this.title, this.category, this.imageUrl);
}

final sampleItems = <IntroItem>[
  IntroItem(title: '我们因为爱而拯救的毛小孩， 到最后却拯救了我们的心', category: 'COLLABORATION', imageUrl: 'assets/image/login/1.png',),
  IntroItem(title: '我们在这里获取专业知识', category: 'PROFESSIONAL GUIDANCE', imageUrl: 'assets/image/login/2.png',),
  IntroItem(title: '我们在这里收获交流的喜悦', category: 'COMMUNITY', imageUrl: 'assets/image/login/3.png',),
];