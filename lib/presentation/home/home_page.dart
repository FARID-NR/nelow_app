import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
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
                        onFieldSubmitted: (_){},
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
                            borderSide: BorderSide.none
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7)
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1
                            ),
                          ),
                          hintText: "Search",
                          hintStyle: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 15
                          )
                        ),
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                  color: Colors.black,  
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
    );
  }
}