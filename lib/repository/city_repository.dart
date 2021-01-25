import 'package:hive/hive.dart';

class CityRepository {
  void saveCityId({int cityId}) => Hive.box<int>('cities').add(cityId);

  List<int> cityIdList() => Hive.box<int>('cities').values.toList();
}
