// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isarService)
final isarServiceProvider = IsarServiceProvider._();

final class IsarServiceProvider
    extends $FunctionalProvider<IsarService, IsarService, IsarService>
    with $Provider<IsarService> {
  IsarServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isarServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isarServiceHash();

  @$internal
  @override
  $ProviderElement<IsarService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IsarService create(Ref ref) {
    return isarService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IsarService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IsarService>(value),
    );
  }
}

String _$isarServiceHash() => r'bd23397f4fb112635770a0bb777762d6a9fa3661';

@ProviderFor(TodoList)
final todoListProvider = TodoListProvider._();

final class TodoListProvider
    extends $StreamNotifierProvider<TodoList, List<Todo>> {
  TodoListProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'todoListProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$todoListHash();

  @$internal
  @override
  TodoList create() => TodoList();
}

String _$todoListHash() => r'19329f6bcbab7538641878bb7bab1d7bac7a1147';

abstract class _$TodoList extends $StreamNotifier<List<Todo>> {
  Stream<List<Todo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Todo>>, List<Todo>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Todo>>, List<Todo>>,
        AsyncValue<List<Todo>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
