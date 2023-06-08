import 'ITEM_MODEL.dart';

class DataStore{
  static List<ItemModel> itemModels = [];

  static void initData(){
    itemModels.add(ItemModel('','',''));

  }

  static List<ItemModel> getData(){
  return itemModels;

  }
}