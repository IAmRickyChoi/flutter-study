class ProjectUtils {
  final String image;
  final String title;
  final String subtitle;
  final String? androidLink;
  final String? iosLink;
  final String? webLink;

  ProjectUtils({
    required this.image,
    required this.title,
    required this.subtitle,
    this.androidLink,
    this.iosLink,
    this.webLink,
  });
}

//Work Projects
List<ProjectUtils> workProjectUtils = [
  ProjectUtils(
    image: 'assets/lovely_mint.png',
    title: 'test1',
    subtitle: 'test1',
    androidLink: 'https://www.google.com',
    iosLink: 'https://www.google.com',
  ),
  ProjectUtils(
    image: 'assets/lovely_mint.png',
    title: 'test2',
    subtitle: 'test2',
    androidLink: 'https://www.google.com',
    iosLink: 'https://www.google.com',
  ),
  ProjectUtils(
    image: 'assets/lovely_mint.png',
    title: 'test3',
    subtitle: 'test3',
    webLink: 'https://www.google.com',
    androidLink: 'https://www.google.com',
    iosLink: 'https://www.google.com',
  ),
  ProjectUtils(
    image: 'assets/lovely_mint.png',
    title: 'test4',
    subtitle: 'test4',
  ),
  ProjectUtils(
    image: 'assets/lovely_mint.png',
    title: 'test5',
    subtitle: 'test5',
  ),
];

//Hobby Projects
List<ProjectUtils> hobbyProjectUtils = [
  ProjectUtils(
    image: 'assets/lovely_mint.png',
    title: 'test6',
    subtitle: 'test6',
    androidLink: 'https://www.google.com',
    iosLink: 'https://www.google.com',
  ),
  ProjectUtils(
    image: 'assets/lovely_mint.png',
    title: 'test7',
    subtitle: 'test7',
    androidLink: 'https://www.google.com',
    iosLink: 'https://www.google.com',
  ),
  ProjectUtils(
    image: 'assets/lovely_mint.png',
    title: 'test8',
    subtitle: 'test8',
    webLink: 'https://www.google.com',
    androidLink: 'https://www.google.com',
    iosLink: 'https://www.google.com',
  ),
  ProjectUtils(
    image: 'assets/lovely_mint.png',
    title: 'test9',
    subtitle: 'test9',
  ),
];
