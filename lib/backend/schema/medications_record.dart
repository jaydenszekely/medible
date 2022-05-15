import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'medications_record.g.dart';

abstract class MedicationsRecord
    implements Built<MedicationsRecord, MedicationsRecordBuilder> {
  static Serializer<MedicationsRecord> get serializer =>
      _$medicationsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'Medication_Name')
  String get medicationName;

  @nullable
  @BuiltValueField(wireName: 'Usage')
  String get usage;

  @nullable
  @BuiltValueField(wireName: 'Prescriber')
  String get prescriber;

  @nullable
  @BuiltValueField(wireName: 'Dosage')
  String get dosage;

  @nullable
  @BuiltValueField(wireName: 'Conditions')
  BuiltList<DocumentReference> get conditions;

  @nullable
  @BuiltValueField(wireName: 'User')
  DocumentReference get user;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(MedicationsRecordBuilder builder) => builder
    ..medicationName = ''
    ..usage = ''
    ..prescriber = ''
    ..dosage = ''
    ..conditions = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('medications');

  static Stream<MedicationsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<MedicationsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  MedicationsRecord._();
  factory MedicationsRecord([void Function(MedicationsRecordBuilder) updates]) =
      _$MedicationsRecord;

  static MedicationsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createMedicationsRecordData({
  String medicationName,
  String usage,
  String prescriber,
  String dosage,
  DocumentReference user,
}) =>
    serializers.toFirestore(
        MedicationsRecord.serializer,
        MedicationsRecord((m) => m
          ..medicationName = medicationName
          ..usage = usage
          ..prescriber = prescriber
          ..dosage = dosage
          ..conditions = null
          ..user = user));
