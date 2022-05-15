import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: 'first_name')
  String get firstName;

  @nullable
  @BuiltValueField(wireName: 'last_name')
  String get lastName;

  @nullable
  @BuiltValueField(wireName: 'middle_name')
  String get middleName;

  @nullable
  @BuiltValueField(wireName: 'date_of_birth')
  String get dateOfBirth;

  @nullable
  @BuiltValueField(wireName: 'Street_Address')
  String get streetAddress;

  @nullable
  @BuiltValueField(wireName: 'Suburb')
  String get suburb;

  @nullable
  @BuiltValueField(wireName: 'town_city')
  String get townCity;

  @nullable
  @BuiltValueField(wireName: 'state_region_prov')
  String get stateRegionProv;

  @nullable
  @BuiltValueField(wireName: 'Country')
  String get country;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..email = ''
    ..displayName = ''
    ..photoUrl = ''
    ..uid = ''
    ..phoneNumber = ''
    ..firstName = ''
    ..lastName = ''
    ..middleName = ''
    ..dateOfBirth = ''
    ..streetAddress = ''
    ..suburb = ''
    ..townCity = ''
    ..stateRegionProv = ''
    ..country = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUsersRecordData({
  String email,
  String displayName,
  String photoUrl,
  String uid,
  DateTime createdTime,
  String phoneNumber,
  String firstName,
  String lastName,
  String middleName,
  String dateOfBirth,
  String streetAddress,
  String suburb,
  String townCity,
  String stateRegionProv,
  String country,
}) =>
    serializers.toFirestore(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..email = email
          ..displayName = displayName
          ..photoUrl = photoUrl
          ..uid = uid
          ..createdTime = createdTime
          ..phoneNumber = phoneNumber
          ..firstName = firstName
          ..lastName = lastName
          ..middleName = middleName
          ..dateOfBirth = dateOfBirth
          ..streetAddress = streetAddress
          ..suburb = suburb
          ..townCity = townCity
          ..stateRegionProv = stateRegionProv
          ..country = country));
