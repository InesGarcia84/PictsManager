// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LibraryStruct extends FFFirebaseStruct {
  LibraryStruct({
    int? id,
    String? name,
    List<int>? imageIds,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _id = id,
        _name = name,
        _imageIds = imageIds,
        super(firestoreUtilData);

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;
  void incrementId(int amount) => _id = id + amount;
  bool hasId() => _id != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;
  bool hasName() => _name != null;

  // "imageIds" field.
  List<int>? _imageIds;
  List<int> get imageIds => _imageIds ?? const [];
  set imageIds(List<int>? val) => _imageIds = val;
  void updateImageIds(Function(List<int>) updateFn) =>
      updateFn(_imageIds ??= []);
  bool hasImageIds() => _imageIds != null;

  static LibraryStruct fromMap(Map<String, dynamic> data) => LibraryStruct(
        id: castToType<int>(data['id']),
        name: data['name'] as String?,
        imageIds: getDataList(data['imageIds']),
      );

  static LibraryStruct? maybeFromMap(dynamic data) =>
      data is Map ? LibraryStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'name': _name,
        'imageIds': _imageIds,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'imageIds': serializeParam(
          _imageIds,
          ParamType.int,
          true,
        ),
      }.withoutNulls;

  static LibraryStruct fromSerializableMap(Map<String, dynamic> data) =>
      LibraryStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        imageIds: deserializeParam<int>(
          data['imageIds'],
          ParamType.int,
          true,
        ),
      );

  @override
  String toString() => 'LibraryStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is LibraryStruct &&
        id == other.id &&
        name == other.name &&
        listEquality.equals(imageIds, other.imageIds);
  }

  @override
  int get hashCode => const ListEquality().hash([id, name, imageIds]);
}

LibraryStruct createLibraryStruct({
  int? id,
  String? name,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    LibraryStruct(
      id: id,
      name: name,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

LibraryStruct? updateLibraryStruct(
  LibraryStruct? library, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    library
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addLibraryStructData(
  Map<String, dynamic> firestoreData,
  LibraryStruct? library,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (library == null) {
    return;
  }
  if (library.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && library.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final libraryData = getLibraryFirestoreData(library, forFieldValue);
  final nestedData = libraryData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = library.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getLibraryFirestoreData(
  LibraryStruct? library, [
  bool forFieldValue = false,
]) {
  if (library == null) {
    return {};
  }
  final firestoreData = mapToFirestore(library.toMap());

  // Add any Firestore field values
  library.firestoreUtilData.fieldValues.forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getLibraryListFirestoreData(
  List<LibraryStruct>? librarys,
) =>
    librarys?.map((e) => getLibraryFirestoreData(e, true)).toList() ?? [];
