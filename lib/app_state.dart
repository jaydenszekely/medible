import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/lat_lng.dart';

class FFAppState {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _FirstName = prefs.getString('ff_FirstName') ?? _FirstName;
    _LastName = prefs.getString('ff_LastName') ?? _LastName;
    _ProfilePicture = prefs.getString('ff_ProfilePicture') ?? _ProfilePicture;
  }

  SharedPreferences prefs;

  String _FirstName = 'Jayden';
  String get FirstName => _FirstName;
  set FirstName(String _value) {
    _FirstName = _value;
    prefs.setString('ff_FirstName', _value);
  }

  String _LastName = 'Szekely';
  String get LastName => _LastName;
  set LastName(String _value) {
    _LastName = _value;
    prefs.setString('ff_LastName', _value);
  }

  String UserName = 'jaydenszekely_001';

  String _ProfilePicture;
  String get ProfilePicture => _ProfilePicture;
  set ProfilePicture(String _value) {
    _ProfilePicture = _value;
    prefs.setString('ff_ProfilePicture', _value);
  }
}

LatLng _latLngFromString(String val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
