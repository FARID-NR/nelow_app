part of 'checkout_bloc.dart';

@immutable
sealed class CheckoutEvent {}

class AddToCartEvent extends CheckoutEvent {
  final Product product;

  AddToCartEvent({
    required this.product
  });
}

class RemoveFromCartEvent extends CheckoutEvent {
  final Product product;

  RemoveFromCartEvent({
    required this.product
  });
}

class ResetFromCartEvent extends CheckoutEvent {
  final Product product;

  ResetFromCartEvent({required this.product});
}

