import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nelow_app/presentation/cart/cart_page.dart';
import 'package:nelow_app/presentation/home/widgets/banner_widget.dart';
import 'package:nelow_app/presentation/home/widgets/list_category_widget.dart';
import 'package:nelow_app/presentation/home/widgets/list_product_widget.dart';
import 'package:badges/badges.dart' as badges;

import '../../bloc/checkout/checkout_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentIndex = 0;
  int itemCount = 3;
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 42,
                    margin: EdgeInsets.only(top: 10, bottom: 10, right: 5),
                    child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 4,
                      child: TextFormField(
                        onFieldSubmitted: (_) {},
                        decoration: InputDecoration(
                            prefixIcon: InkWell(
                              onTap: () {},
                              child: const Padding(
                                padding: EdgeInsets.only(),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 23,
                                ),
                              ),
                            ),
                            filled: true,
                            fillColor: Color(0xFFE8D9CD),
                            contentPadding: const EdgeInsets.only(top: 30),
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide.none),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 1),
                            ),
                            hintText: "Search",
                            hintStyle: GoogleFonts.inter(
                                fontWeight: FontWeight.w500, fontSize: 15)),
                      ),
                    ),
                  ),
                ),
                BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    if (state is CheckoutLoaded) {
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              // Tambahkan aksi ketika ikon keranjang diklik
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return CartPage();
                              }));
                            },
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          if ( state.items.length >
                              0) // Ganti 'itemCount' dengan angka yang sesuai
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color:
                                      Colors.red, // Warna latar belakang angka
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 16, // Lebar minimum untuk angka
                                ),
                                child: Center(
                                  child: Text(
                                    '${state.items.length}', // Ganti dengan angka yang sesuai
                                    style: TextStyle(
                                      color: Colors.white, // Warna teks angka
                                      fontSize: 12, // Ukuran teks angka
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    }
                    // return Container();
                    return Container();
                    // const badges.Badge(
                    //   badgeStyle: badges.BadgeStyle(
                    //       elevation: 0, badgeColor: Colors.white),
                    //   // elevation: 0,
                    //   badgeContent: Text(
                    //     '0',
                    //     style: TextStyle(color: Color(0xffEE4D2D)),
                    //   ),
                    //   // badgeColor: Colors.white,
                    //   child: Icon(
                    //     Icons.shopping_cart_outlined,
                    //   ),
                    // );
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Icon(
                  Icons.chat_outlined,
                  size: 30,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'KATEGORI',
              style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF8C4303)),
            ),
            const SizedBox(height: 5),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: const Border.symmetric(
                        // horizontal: BorderSide(color: Colors.grey.withOpacity(0.5),)
                        ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2))
                    ]),
                child: const ListCategoryWidget()),
            const BannerWidget(),
            Text(
              'List Product',
              style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF8C4303)),
            ),
            const SizedBox(
              height: 5,
            ),
            const Expanded(child: ListProductWidget())
          ],
        ),
      ),

      // Bottom Nav Bar
      bottomNavigationBar: Container(
        // margin: EdgeInsets.all(displayWidth * .05),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: displayWidth * .195,
        decoration: BoxDecoration(
          color: const Color(0xFFB1A274),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          // borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: List.generate(
            5,
            (index) {
              return Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                      HapticFeedback.lightImpact();
                    });
                    // changePage(index);
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width: index == currentIndex
                            ? displayWidth * .32
                            : displayWidth * .18,
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height:
                              index == currentIndex ? displayWidth * .18 : 0,
                          width: index == currentIndex ? displayWidth * .20 : 0,
                          decoration: BoxDecoration(
                            color: index == currentIndex
                                ? const Color(0xFF8C4303)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex
                              ? displayWidth * .32
                              : displayWidth * .18,
                          alignment: Alignment.center,
                          child: BlocBuilder<CheckoutBloc, CheckoutState>(
                            builder: (context, state) {
                              if (state is CheckoutLoaded) {
                                return Stack(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      index ==
                                              2 // Pastikan indeks sesuai dengan "Store" dalam listOfIcons
                                          ? Stack(
                                              children: [
                                                Image.asset(
                                                  listOfIcons[index],
                                                  width: 30,
                                                  color: currentIndex == index
                                                      ? Colors.black
                                                      : Colors.black26,
                                                ),
                                                if (index == 2 &&
                                                    state.items.length >
                                                        0) // Menampilkan badge hanya pada ikon "Store" (indeks 2) jika itemCount lebih besar dari 0
                                                  Positioned(
                                                    right: 0,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      decoration: BoxDecoration(
                                                        color: Colors
                                                            .red, // Warna latar belakang badge
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      constraints:
                                                          const BoxConstraints(
                                                        minWidth:
                                                            16, // Lebar minimum untuk badge
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          '${state.items.length}', // Ganti dengan nilai badge yang sesuai
                                                          style:
                                                              const TextStyle(
                                                            color: Colors
                                                                .white, // Warna teks badge
                                                            fontSize:
                                                                12, // Ukuran teks badge
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            )
                                          : Image.asset(
                                              listOfIcons[index],
                                              width: 30,
                                              color: currentIndex == index
                                                  ? Colors.black
                                                  : Colors.black26,
                                            ),
                                      if (currentIndex == index)
                                        Text(
                                          listOfStrings[index],
                                          style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              );
                              }
                              return Container();
                              // const badges.Badge(
                              //   badgeStyle: badges.BadgeStyle(
                              //       elevation: 0, badgeColor: Colors.white),
                              //   // elevation: 0,
                              //   badgeContent: Text(
                              //     '0',
                              //     style: TextStyle(color: Color(0xffEE4D2D)),
                              //   ),
                              //   // badgeColor: Colors.white,
                              //   child: Icon(
                              //     Icons.shopping_cart_outlined,
                              //   ),
                              // );
                            },
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

List<String> listOfIcons = [
  'assets/icons/icon_home.png',
  'assets/icons/consult.png',
  'assets/icons/icon_store.png',
  'assets/icons/iocn_feed.png',
  'assets/icons/icon_profile.png',
];

List<String> listOfStrings = ['Home', 'Feed', 'Store', 'Message', 'Profile'];

final List<Widget> pages = [
  HomePage(),
  // FeedPage(),
  // StorePage(),
  // MessagePage(),
  // ProfilePage()
];

  // void changePage(int index) {
  //   setState(() {
  //     currentIndex = index;
  //   });
  // }
