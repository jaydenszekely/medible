import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'emergency_contacts_record.g.dart';

abstract class EmergencyContactsRecord
    implements Built<EmergencyContactsRecord, EmergencyContactsRecordBuilder> {
  static Serializer<EmergencyContactsRecord> get serializer =>
      _$emergencyContactsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'User')
  DocumentReference get user;

  @nullable
  @BuiltValueField(wireName: 'Contact_Mobile')
  String get contactMobile;

  @nullable
  @BuiltValueField(wireName: 'Contact_Email')
  String get contactEmail;

  @nullable
  @BuiltValueField(wireName: 'Contact_Name')
  String get contactName;

  @nullable
  @BuiltValueField(wireName: 'Relation')
  String get relation;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(EmergencyContactsRecordBuilder builder) =>
      builder
        ..contactMobile = ''
        ..contactEmail = ''
        ..contactName = ''
        ..relation = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('EmergencyContacts');

  static Stream<EmergencyContactsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<EmergencyContactsRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  EmergencyContactsRecord._();
  factory EmergencyContactsRecord(
          [void Function(EmergencyContactsRecordBuilder) updates]) =
      _$EmergencyContactsRecord;

  static EmergencyContactsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createEmergencyContactsRecordData({
  DocumentReference user,
  String contactMobile,
  String contactEmail,
  String contactName,
  String relation,
}) =>
    serializers.toFirestore(
        EmergencyContactsRecord.serializer,
        EmergencyContactsRecord((e) => e
          ..user = user
          ..contactMobile = contactMobile
          ..contactEmail = contactEmail
          ..contactName = contactName
          ..relation = relation));
