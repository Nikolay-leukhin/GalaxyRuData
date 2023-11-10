import 'dart:math';

class SafeRepository{
  List<int> getRandomList(int n){
    final random = Random();

    List<int> list = [];

    for (var i = 0; i < n; i++){
      var temp = random.nextInt(77);

      while(list.contains(temp)){
        temp = random.nextInt(77);
      }

      list.add(temp);
    }
    print(list);
    return list;
  }
}