import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nelow_app/common/global_variables.dart';

class ListCategoryWidget extends StatelessWidget {
  const ListCategoryWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    GlobalVariables.categoryImages[index]['image']!,
                    fit: BoxFit.cover,
                    height: 42,
                    width: 42,
                  ),
                ),
              ),
              Text(
                GlobalVariables.categoryImages[index]['title']!,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400
                ),
              )
            ],
          );
        },
      ),
    );
  }
}