import 'package:equatable/equatable.dart';

class UiState extends Equatable {
  final bool isLoading;
  final String? errorMessage;

  const UiState({this.isLoading = false, this.errorMessage});

  UiState copyWith({bool? isLoading, String? errorMessage}) {
    return UiState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  factory UiState.initial() => const UiState();

  @override
  List<Object?> get props => [isLoading, errorMessage];
}
