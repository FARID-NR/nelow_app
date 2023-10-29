import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nelow_app/bloc/checkout/checkout_bloc.dart';
import 'package:nelow_app/bloc/get_products/get_products_bloc.dart';
import 'package:nelow_app/data/models/responses/list_product_response_model.dart';

class ListProductWidget extends StatefulWidget {
  const ListProductWidget({super.key});

  @override
  State<ListProductWidget> createState() => _ListProductWidgetState();
}

class _ListProductWidgetState extends State<ListProductWidget> {
  @override
  void initState() {
    context.read<GetProductsBloc>().add(DoGetProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProductsBloc, GetProductsState>(
      builder: (context, state) {
        if (state is GetProductsError) {
          return Center(
            child: Text('Data Error'),
          );
        }

        if (state is GetProductsLoaded) {
          if (state.data.data!.isEmpty) {
            return const Center(
              child: Text('Data Tidak Ada'),
            );
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.63),
            itemBuilder: (context, index) {
              final Product product = state.data.data![index];
              String formattedPrice =
                  NumberFormat.currency(locale: 'id', symbol: 'Rp ')
                      .format(product.attributes!.price);
              // formattedPrice = formattedPrice.replaceAll(',00', '');
              return Card(
                elevation: 2,
                shadowColor: const Color(0xFFA65D03),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: product.attributes!.image!,
                      child: SizedBox(
                          width: 150,
                          height: 110,
                          child: Image.network(product.attributes!.image!)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      formattedPrice.replaceAll(',00', ''),
                      style: GoogleFonts.inter(
                          color: Color(0xFFA65D03),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        '${product.attributes!.name!}',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(
                      height: 2,
                      color: Color(0xFFA65D03),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.read<CheckoutBloc>().add(
                                        RemoveFromCartEvent(product: product));
                                  },
                                  child: Icon(
                                    Icons.add_shopping_cart,
                                    size: 20,
                                    color: Color(0xFFA65D03),
                                  ),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  'Beli',
                                  style: TextStyle(
                                      color: const Color(0xFFA65D03),
                                      fontSize: 16),
                                )
                              ],
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.read<CheckoutBloc>().add(
                                        RemoveFromCartEvent(product: product));
                                  },
                                  child: Icon(
                                    Icons.remove_circle_outline,
                                    size: 20,
                                    color: Color(0xFFA65D03),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: BlocBuilder<CheckoutBloc, CheckoutState>(
                                    builder: (context, state) {
                                      if (state is CheckoutLoaded) {
                                        final countItem = state.items
                                              .where((element) => 
                                                  element.id == product.id)
                                              .length;
                                         return Text('$countItem'); 
                                      }
                                      return Text('0');
                                    },
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context
                                        .read<CheckoutBloc>()
                                        .add(AddToCartEvent(product: product));
                                  },
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    size: 20,
                                    color: Color(0xFFA65D03),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            itemCount: state.data.data!.length,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
