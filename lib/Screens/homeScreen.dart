import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mellow_wave/Widgets/CustomContainer.dart';
import 'package:mellow_wave/Widgets/CustomDrawer.dart';
import 'package:mellow_wave/data/Categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  List<String> names = categories;
  List<String> images = catimages;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF57837B),
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF57837B),
        title: Text(
          '\t\t\t\t\t\tMellow Wave',
          style: GoogleFonts.montserrat(
              color: const Color(0xFFF1ECC3),
              fontWeight: FontWeight.w600,
              fontSize: 25),
        ),
        leading: IconButton(
          icon: const Icon(
            Boxicons.bx_menu,
            color: Color(0xFFF1ECC3),
            size: 27,
          ),
          onPressed: _openDrawer,
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.80, // to achieve the 2x4 column (width/height)
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return CustomContainer(
            backimage: catimages[index],
            name: categories[index],
          );
        },
      ),
    );
  }
}
