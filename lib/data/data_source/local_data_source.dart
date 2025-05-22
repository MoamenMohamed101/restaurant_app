import 'package:restaurant_app/data/network/error_handler.dart';
import 'package:restaurant_app/data/response/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERNAL = 60 * 1000; // 1 min
const CACHE_STORES_KEY = "CACHE_STORES_KEY";
const CACHE_STORES_INTERNAL = 60 * 1000; // 1 min

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

  Future<void> saveHomeDataToCache(HomeResponse homeResponse);

  StoresDetailsResponse getStoresDataDetails();

  Future<void> saveStoresDataToCache(StoresDetailsResponse storesDetailsResponse);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERNAL)) {
      return cachedItem.data;
    }
    throw ErrorHandler.handel(DataSource.CACHE_ERROR);
  }

  @override
  Future<void> saveHomeDataToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }

  @override
  void clearCache() => cacheMap.clear();

  @override
  void removeFromCache(String key) => cacheMap.remove(key);

  @override
  StoresDetailsResponse getStoresDataDetails() {
    CachedItem? cachedItem = cacheMap[CACHE_STORES_KEY];
    if (cachedItem != null && cachedItem.isValid(CACHE_STORES_INTERNAL)) {
      return cachedItem.data;
    }else {
      throw ErrorHandler.handel(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveStoresDataToCache(StoresDetailsResponse storesDetailsResponse) async{
    cacheMap[CACHE_STORES_KEY] = CachedItem(storesDetailsResponse);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isExpired = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    return isExpired;
  }
}