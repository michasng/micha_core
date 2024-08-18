import 'package:flutter/widgets.dart';
import 'package:micha_core/src/async/spinner.dart';

typedef BuilderCallback<T> = Widget Function(
  BuildContext context,
  T data,
);

class AsyncBuilder<T> extends StatefulWidget {
  final Future<T> Function(BuildContext context) createFuture;
  final BuilderCallback<T> builder;
  final T? initialData;
  final BuilderCallback<Object>? errorBuilder;
  final Widget? loading;
  final Widget? noData;

  const AsyncBuilder({
    super.key,
    required this.createFuture,
    required this.builder,
    this.initialData,
    this.errorBuilder,
    this.loading,
    this.noData,
  });

  factory AsyncBuilder.asset(
    Future<T> Function(AssetBundle assetBundle) loadAsset, {
    required BuilderCallback<T> builder,
    T? initialData,
    BuilderCallback<Object>? errorBuilder,
    Widget? loading,
    Widget? noData,
  }) {
    return AsyncBuilder<T>(
      createFuture: (context) => loadAsset(DefaultAssetBundle.of(context)),
      builder: builder,
      initialData: initialData,
      errorBuilder: errorBuilder,
      loading: loading,
      noData: noData,
    );
  }

  @override
  State<AsyncBuilder<T>> createState() => _AsyncBuilderState<T>();
}

class _AsyncBuilderState<T> extends State<AsyncBuilder<T>> {
  late Future<T> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = widget.createFuture(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: _loadFuture,
      initialData: widget.initialData,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return widget.loading ?? const Spinner();
        }

        final error = snapshot.error;
        if (error != null) {
          return widget.errorBuilder?.call(context, error) ??
              Text(error.toString());
        }

        final data = snapshot.data;
        if (data == null) {
          return widget.noData ?? Container();
        }
        return widget.builder(context, data);
      },
    );
  }
}
