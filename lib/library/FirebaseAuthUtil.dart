import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final user = FirebaseAuth.instance.currentUser;
}
