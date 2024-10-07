import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
class UpdateController extends GetxController {
 final pb = PocketBase('http://127.0.0.1:8090');
  Future<void> editproduct(String id,String name, String price,String quantity,String description ,String image) async {
    if (id.isNotEmpty) {
        final data =  <String, dynamic>{
            "name": name,
            "price": price,
            "quatity": quantity,
            "description": description,
            "image": image
        };
      final pbproduct = await pb.collection('products').getList(
        filter: 'id="${id}"',
      );
      if (pbproduct.items.isNotEmpty) {
         final record = pbproduct.items[0];
         final updatedRecord = await pb.collection('scores').update(
          record.id,
          body: data);
          print(updatedRecord);
      } else {
        print('cant find product that you want update');
      }
    } else {
      print('admin edit failed:');
    }
  }
}