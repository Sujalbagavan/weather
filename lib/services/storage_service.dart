import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _lastCityKey = 'last_city';
  static const String _searchHistoryKey = 'search_history';

  Future<void> saveLastCity(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastCityKey, cityName);
  }

  Future<String?> getLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastCityKey);
  }

  Future<void> addToSearchHistory(String cityName) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getSearchHistory();
    
    // Remove if already exists to avoid duplicates
    history.removeWhere((city) => city.toLowerCase() == cityName.toLowerCase());
    
    // Add to beginning of list
    history.insert(0, cityName);
    
    // Keep only last 5 searches
    if (history.length > 5) {
      history.removeRange(5, history.length);
    }
    
    await prefs.setStringList(_searchHistoryKey, history);
  }

  Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_searchHistoryKey) ?? [];
  }
}