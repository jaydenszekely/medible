import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'conditions_record.g.dart';

abstract class ConditionsRecord
    implements Built<ConditionsRecord, ConditionsRecordBuilder> {
  static Serializer<ConditionsRecord> get serializer =>
      _$conditionsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'Condition_Name')
  String get conditionName;

  @nullable
  @BuiltValueField(wireName: 'Symptoms')
  BuiltList<String> get symptoms;

  @nullable
  @BuiltValueField(wireName: 'Treatment_Emergency')
  String get treatmentEmergency;

  @nullable
  @BuiltValueField(wireName: 'User')
  DocumentReference get user;

  @nullable
  @BuiltValueField(wireName: 'Video_Instructions')
  String get videoInstructions;

  @nullable
  @BuiltValueField(wireName: 'Specialists')
  BuiltList<DocumentReference> get specialists;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ConditionsRecordBuilder builder) => builder
    ..conditionName = ''
    ..symptoms = ListBuilder()
    ..treatmentEmergency = ''
    ..videoInstructions = ''
    ..specialists = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('conditions');

  static Stream<ConditionsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<ConditionsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ConditionsRecord._();
  factory ConditionsRecord([void Function(ConditionsRecordBuilder) updates]) =
      _$ConditionsRecord;

  static ConditionsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createConditionsRecordData({
  String conditionName,
  String treatmentEmergency,
  DocumentReference user,
  String videoInstructions,
}) =>
    serializers.toFirestore(
        ConditionsRecord.serializer,
        ConditionsRecord((c) => c
          ..conditionName = conditionName
          ..symptoms = null
          ..treatmentEmergency = treatmentEmergency
          ..user = user
          ..videoInstructions = videoInstructions
          ..specialists = null));
