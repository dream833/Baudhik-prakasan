import '../data/app_image.dart';

class Categories {
  final String title;
  final String imageUrl;

  Categories({
    required this.title,
    required this.imageUrl,
  });

  static List<Categories> categories = [
    Categories(title: "Current News", imageUrl: AppImage.newspaper.toString()),
    Categories(title: "Online Quiz", imageUrl: AppImage.quize.toString()),
    Categories(title: "Books", imageUrl: AppImage.book1.toString()),
    Categories(title: "E-Books", imageUrl: AppImage.ebook.toString()),
    Categories(
        title: "PET Online Courses", imageUrl: AppImage.courses.toString()),
    Categories(
        title: "Video Lectures", imageUrl: AppImage.video_lecture.toString()),
    Categories(title: "PYQ Test", imageUrl: AppImage.pyq.toString()),
    Categories(
        title: "Solved Paper PDF", imageUrl: AppImage.solved_pdf.toString()),
    Categories(title: "Errata", imageUrl: AppImage.errata.toString()),
    Categories(title: "Scan and Check", imageUrl: AppImage.scan.toString()),
  ];
}
