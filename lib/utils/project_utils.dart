class ProjectUtils {
  String projectName;
  String projectDescription;
  String projectImage;
  String projectAndroidLink;
  String projectIosLink;
  String projectWebLink;

  ProjectUtils({
    required this.projectName,
    required this.projectDescription,
    required this.projectImage,
    required this.projectAndroidLink,
    required this.projectIosLink,
    required this.projectWebLink,
  });
}

List<ProjectUtils> getProjects() {
  return [
    ProjectUtils(
      projectName: 'Exchanger 101',
      projectDescription:
          'Exchanger101 is a secure mobile platform that lets users in Nigeria instantly convert gift cards and cryptocurrencies like Bitcoin and USDT to cash at competitive rates. Available on Android and iOS, it offers real-time rates, zero withdrawal fees, and 24/7 support, delivering a fast and seamless exchange experience.',
      projectImage: 'assets/images/flutter_app.png',
      projectAndroidLink:
          'https://play.google.com/store/apps/details?id=com.exchanger101.app&hl=en',
      projectIosLink: 'https://apps.apple.com/ng/app/exchanger101/id1586118217',
      projectWebLink: 'https://exchanger101.com/',
    ),
    ProjectUtils(
      projectName: 'Astrotwig',
      projectDescription:
          'A responsive web application using modern web technologies.',
      projectImage: 'assets/images/web_app.png',
      projectAndroidLink: '',
      projectIosLink: '',
      projectWebLink: 'https://example.com/web-app',
    ),
  ];
}
