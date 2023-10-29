// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'checkout_bloc.dart';

sealed class CheckoutState {}

 class CheckoutInitial extends CheckoutState {}

 class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  List<Product> items;

  CheckoutLoaded({
    required this.items
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CheckoutLoaded &&
      listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}

 class CheckoutError extends CheckoutState {}
