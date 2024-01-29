import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotel_webview/src/home/data/models/book_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BookModel> books = [];

  /// book 채우는 역할
  @override
  void initState() {
    super.initState();
    prepareBookList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.grey,
                alignment: Alignment.center,
                child: _buildBookList(context, books),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void prepareBookList() {
    for (var i = 0; i < 5; i++) {
      final bookName = 'Book $i';
      final imageUrl = 'https://source.unsplash.com/random/800x800?sig=$i';
      final book = BookModel(bookName, imageUrl);
      books.add(book);
    }
  }

  Widget _buildBookList(BuildContext context, List<BookModel> books) {
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: books.length,
          // itemBuilder -> Card 부분
          itemBuilder: (context, index, realIndex) {
            return buildBookCard(books[index]);
          },
          options: CarouselOptions(
            height: height,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            initialPage: 1,
            viewportFraction: .9,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            enlargeFactor: 0.2,
          ),
        ),
      ],
    );
  }

  Widget buildBookCard(BookModel book) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(3),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(1)),
        child: Stack(
          children: [
            Image.network(
              book.imageUrl,
              fit: BoxFit.fitHeight,
              height: height,
              width: width,
            ),
            Positioned(
              left: 32,
              bottom: 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '6월에 어디 가지?',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '양평 이쁜 카페 어때?!',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '6시간 낭만 여행',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 130,
              right: 50,
              child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.black54),
                      SizedBox(width: 3),
                      Text(
                        '구독',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
