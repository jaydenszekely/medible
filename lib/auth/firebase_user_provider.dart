import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class MedibleFirebaseUser {
  MedibleFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

MedibleFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<MedibleFirebaseUser> medibleFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<MedibleFirebaseUser>(
        (user) => currentUser = MedibleFirebaseUser(user));
