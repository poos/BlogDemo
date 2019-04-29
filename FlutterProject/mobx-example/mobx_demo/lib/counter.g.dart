// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

mixin _$Counter on _Counter, Store {
  final _$valueAtom = Atom(name: '_Counter.value');

  @override
  int get value {
    _$valueAtom.reportObserved();
    return super.value;
  }

  @override
  set value(int value) {
    super.value = value;
    _$valueAtom.reportChanged();
  }

  final _$_CounterActionController = ActionController(name: '_Counter');

  @override
  void increment() {
    final _$prevDerivation = _$_CounterActionController.startAction();
    try {
      return super.increment();
    } finally {
      _$_CounterActionController.endAction(_$prevDerivation);
    }
  }
}
