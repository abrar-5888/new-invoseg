part of 'grocery_bloc.dart';

sealed class GroceryState {
  const GroceryState();
}

final class GroceryInitial extends GroceryState {}

class StartGroceryState extends GroceryState {
  final groceryItem;
  final userInfo;
  final groceryId;
  const StartGroceryState(this.groceryItem, this.userInfo, this.groceryId);

  // @override
  // List<Object> get props => [];
}

class loadingState extends GroceryState {
  const loadingState();
  // @override
  // List<Object> get props => [];
}
