// Mocks generated by Mockito 5.4.2 from annotations
// in juling_apps/test/Provider/provider_asset_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:juling_apps/model/model.dart' as _i5;
import 'package:juling_apps/model/model_maintenance.dart' as _i6;
import 'package:juling_apps/service/firebase_service.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeFirebaseFirestore_0 extends _i1.SmartFake
    implements _i2.FirebaseFirestore {
  _FakeFirebaseFirestore_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FirebaseService].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseService extends _i1.Mock implements _i3.FirebaseService {
  MockFirebaseService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FirebaseFirestore get firestore => (super.noSuchMethod(
        Invocation.getter(#firestore),
        returnValue: _FakeFirebaseFirestore_0(
          this,
          Invocation.getter(#firestore),
        ),
      ) as _i2.FirebaseFirestore);

  @override
  _i4.Future<void> addData(_i5.InspectionData? data) => (super.noSuchMethod(
        Invocation.method(
          #addData,
          [data],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> addDataMaintenance(_i6.MaintenanceData? data) =>
      (super.noSuchMethod(
        Invocation.method(
          #addDataMaintenance,
          [data],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> updateData(
    String? docId,
    _i5.InspectionData? newData,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateData,
          [
            docId,
            newData,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> updateDataMaintenance(
    String? docId,
    _i6.MaintenanceData? newData,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateDataMaintenance,
          [
            docId,
            newData,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> countGT(
    _i2.Timestamp? dateStart,
    _i2.Timestamp? dateEnd,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #countGT,
          [
            dateStart,
            dateEnd,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> countMP(
    _i2.Timestamp? dateStart,
    _i2.Timestamp? dateEnd,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #countMP,
          [
            dateStart,
            dateEnd,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> countO(
    _i2.Timestamp? dateStart,
    _i2.Timestamp? dateEnd,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #countO,
          [
            dateStart,
            dateEnd,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> countC(
    _i2.Timestamp? dateStart,
    _i2.Timestamp? dateEnd,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #countC,
          [
            dateStart,
            dateEnd,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> countPC(
    _i2.Timestamp? dateStart,
    _i2.Timestamp? dateEnd,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #countPC,
          [
            dateStart,
            dateEnd,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> countNU(
    _i2.Timestamp? dateStart,
    _i2.Timestamp? dateEnd,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #countNU,
          [
            dateStart,
            dateEnd,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> countNNU(
    _i2.Timestamp? dateStart,
    _i2.Timestamp? dateEnd,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #countNNU,
          [
            dateStart,
            dateEnd,
          ],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> countT() => (super.noSuchMethod(
        Invocation.method(
          #countT,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
