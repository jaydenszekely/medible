import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'allergies_record.g.dart';

abstract class AllergiesRecord
    implements Built<AllergiesRecord, AllergiesRecordBuilder> {
  static Serializer<AllergiesRecord> get serializer =>
      _$allergiesRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'User')
  DocumentReference get user;

  @nullable
  @BuiltValueField(wireName: 'Allergy_Name')
  String get allergyName;

  @nullable
  @BuiltValueField(wireName: 'Symptoms')
  BuiltList<String> get symptoms;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(AllergiesRecordBuilder builder) => builder
    ..allergyName = ''
    ..symptoms = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Allergies');

  static Stream<AllergiesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<AllergiesRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  AllergiesRecord._();
  factory AllergiesRecord([void Function(AllergiesRecordBuilder) updates]) =
      _$AllergiesRecord;

  static AllergiesRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createAllergiesRecordData({
  DocumentReference user,
  String allergyName,
}) =>
    serializers.toFirestore(
        AllergiesRecord.serializer,
        AllergiesRecord((a) => a
          ..user = user
          ..allergyName = allergyName
          ..symptoms = null));
