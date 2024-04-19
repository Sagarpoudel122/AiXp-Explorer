import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterState {
  final bool isNotification;
  final bool isPayload;
  final bool isFilterApplied;

  FilterState({
    required this.isNotification,
    required this.isPayload,
    required this.isFilterApplied,
  });

  FilterState.initial()
      : isNotification = true,
        isPayload = true,
        isFilterApplied = false;

  FilterState copyWith({
    bool? isNotification,
    bool? isPayload,
    bool? isFilterApplied,
  }) {
    return FilterState(
      isNotification: isNotification ?? this.isNotification,
      isPayload: isPayload ?? this.isPayload,
      isFilterApplied: isFilterApplied ?? this.isFilterApplied,
    );
  }
}

class FilterProvider extends StateNotifier<FilterState> {
  FilterProvider() : super(FilterState.initial());

  // Step 2: Replace methods to update the state
  void changeFilter({
    bool? isNotification,
    bool? isPayload,
  }) {
    state = state.copyWith(
      isNotification: isNotification ?? state.isNotification,
      isPayload: isPayload ?? state.isPayload,
      isFilterApplied: !(isNotification ?? state.isNotification) ||
          !(isPayload ?? state.isPayload),
    );
  }

  void clearFilter() {
    state = FilterState.initial();
  }
}

// Step 3: Create a StateNotifierProvider
final filterProvider =
    StateNotifierProvider<FilterProvider, FilterState>((ref) {
  return FilterProvider();
});
