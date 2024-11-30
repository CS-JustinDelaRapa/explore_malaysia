import 'package:explore_malaysia/store/app_state.dart';
import 'package:explore_malaysia/store/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is SetLoadingAction) {
    return state.copyWith(isLoading: action.isLoading);
  }
  
  if (action is SetErrorAction) {
    return state.copyWith(error: action.error);
  }

  if (action is SetPropertiesAction) {
    return state.copyWith(properties: action.properties);
  }

  if (action is SetFilteredPropertiesAction) {
    return state.copyWith(filteredProperties: action.filteredProperties);
  }

  if (action is SetFiltersAction) {
    return state.copyWith(filters: action.filters);
  }

  if (action is SetStatisticsAction) {
    return state.copyWith(statistics: action.statistics);
  }

  return state;
}
