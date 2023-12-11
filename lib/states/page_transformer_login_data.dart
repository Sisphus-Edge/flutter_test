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
  IntroItem(title: 'Writing things together is what we do best!', category: 'COLLABORATION', imageUrl: 'assets/image/login/1.png',),
  IntroItem(title: 'Occasionally wearing pants is a good idea.', category: 'CULTURE', imageUrl: 'assets/image/login/2.png',),
  IntroItem(title: 'We might have the best team spirit ever.', category: 'SPIRIT', imageUrl: 'assets/image/login/3.png',),
];