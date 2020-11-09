import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/brew.dart';
import 'package:firebase/model/user.dart';

class DatabaseService {
  final CollectionReference brewCollection = Firestore.instance.collection('brew');
  final String uid;

  DatabaseService({this.uid});

  Future<void> updateBrew(String name, String sugar, int strength) async {
    return await brewCollection.document(uid).setData(
        {
          'name': name,
          'sugar': sugar,
          'strength': strength,
        }
    );
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_convertToListBrew);
  }

  List<Brew> _convertToListBrew(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          strength: doc.data['strength'] ?? 0,
          sugar: doc.data['sugar'] ?? '0'
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugar: snapshot.data['sugar'],
        strength: snapshot.data['strength']
    );
  }

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

}