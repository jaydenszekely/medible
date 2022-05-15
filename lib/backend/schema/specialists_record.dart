import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'specialists_record.g.dart';

abstract class SpecialistsRecord
    implements Built<SpecialistsRecord, SpecialistsRecordBuilder> {
  static Serializer<SpecialistsRecord> get serializer =>
      _$specialistsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'Patient')
  DocumentReference get patient;

  @nullable
  @BuiltValueField(wireName: 'Specialist_Name')
  String get specialistName;

  @nullable
  @BuiltValueField(wireName: 'Phone_Number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: 'Email_Address')
  String get emailAddress;

  @nullable
  @BuiltValueField(wireName: 'Role')
  String get role;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(SpecialistsRecordBuilder builder) => builder
    ..specialistName = ''
    ..phoneNumber = ''
    ..emailAddress = ''
    ..role = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Specialists');

  static Stream<SpecialistsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<SpecialistsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  SpecialistsRecord._();
  factory SpecialistsRecord([void Function(SpecialistsRecordBuilder) updates]) =
      _$SpecialistsRecord;

  static SpecialistsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createSpecialistsRecordData({
  DocumentReference patient,
  String specialistName,
  String phoneNumber,
  String emailAddress,
  String role,
}) =>
    serializers.toFirestore(
        SpecialistsRecord.serializer,
        SpecialistsRecord((s) => s
          ..patient = patient
          ..specialistName = specialistName
          ..phoneNumber = phoneNumber
          ..emailAddress = emailAddress
          ..role = role));
