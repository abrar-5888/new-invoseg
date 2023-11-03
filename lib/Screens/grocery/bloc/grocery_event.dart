part of 'grocery_bloc.dart';

sealed class GroceryEvent {
  const GroceryEvent();

  // @override
  // List<Object> get props => [];
}

class StartGroceryEvent extends GroceryEvent {
  const StartGroceryEvent();
  // @override
  // List<Object> get props => [];
}

class FinalEvent extends GroceryEvent {
  const FinalEvent();
  // @override
  // List<Object> get props => [];
}
