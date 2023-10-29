import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nelow_app/presentation/home/home_page.dart';

import '../../bloc/checkout/checkout_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int page = 2;
  double bottomBarWidht = 42;
  double bottomBarBorderWidth = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
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
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              if (state is CheckoutLoaded) {
                final uniqueItem = state.items.toSet().length;
                final dataSet = state.items.toSet();
                return Expanded(
                    child: ListView.builder(
                  itemCount: uniqueItem,
                  itemBuilder: (context, index) {
                    final currencyFormater =
                        NumberFormat.currency(locale: 'id', symbol: 'Rp. ');
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFD7D0B9),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            image: NetworkImage(dataSet
                                                .elementAt(index)
                                                .attributes!
                                                .image!))),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            '${dataSet.elementAt(index).attributes!.name}',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          currencyFormater
                                              .format(dataSet
                                                  .elementAt(index)
                                                  .attributes!
                                                  .price)
                                              .replaceAll(',00', ''),
                                          style:
                                              GoogleFonts.inter(fontSize: 15),
                                        ),
                                        const Text(
                                          'In Stock',
                                          style: TextStyle(
                                            color: Colors.teal,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context.read<CheckoutBloc>().add(
                                              AddToCartEvent(
                                                  product: dataSet
                                                      .elementAt(index)));
                                        },
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          size: 20,
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 2),
                                        child: BlocBuilder<CheckoutBloc,
                                            CheckoutState>(
                                          builder: (context, state) {
                                            if (state is CheckoutLoaded) {
                                              final countItem = state.items
                                                .where((element) => element.id == dataSet.elementAt(index).id).length;
                                              return Text(
                                                '${countItem}',
                                                style: GoogleFonts.inter(
                                                    fontWeight: FontWeight.w500),
                                              );
                                            }
                                            return Text(
                                              '0',
                                              style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500),
                                            );
                                          },
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context.read<CheckoutBloc>().add(
                                              RemoveFromCartEvent(
                                                  product: dataSet
                                                      .elementAt(index)));
                                        },
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          size: 20,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 12),
                              GestureDetector(
                                onTap: () {
                                  // final product = dataSet.elementAt(index);
                                  context.read<CheckoutBloc>().add(ResetFromCartEvent(product: dataSet.elementAt(index)));
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/button_remove.png',
                                      width: 10,
                                      height: 12,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Remove',
                                      style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ));
              }
              return Center(
                child: Text('Masukkan Barang'),
              );
            },
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 130,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.02), // Warna bayangan dan tingkat kejernihan
            blurRadius: 1, // Besarnya blur bayangan
            offset: const Offset(
                0, -1), // Posisi bayangan (0,-5 akan membuat bayangan di atas)
          ),
        ]),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: GoogleFonts.inter(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  BlocBuilder<CheckoutBloc, CheckoutState>(
                    builder: (context, state) {
                      if (state is CheckoutLoaded) {
                        final total = state.items.fold(
                            0, (sum, item) => sum + item.attributes!.price!);
                        final currencyFormater =
                            NumberFormat.currency(locale: 'id', symbol: 'Rp. ');
                        return Text(
                          currencyFormater.format(total).replaceAll(',00', ''),
                          style: GoogleFonts.inter(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        );
                      }
                      return Text(
                        'Kalkulasi',
                        style: GoogleFonts.inter(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: ElevatedButton(
                onPressed: () async {
                  // final isLogin = await
                  
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color(0xFF8C4303)),
                child: Text(
                  'Checkout',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
