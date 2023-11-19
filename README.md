Extensions and widgets that are missing in Flutter's SDK.

## Features

This package includes some extensions and widgets to help avoid imperative boilerplate by leaning on Flutter's declarative UI approach.

Other than that, the features in this package are mostly unrelated to each other.  
It is just a collection of useful things that otherwise require boilerplate, like accessing `BuildContext`, and are typically needed in many projects.

## Usage

### Separate items of collections

Need to add some items between existing items of a `List` or `Iterable`? Use `collection.separated(separator)`:

```dart
[1, 2, 3].separated(0); // [1, 0, 2, 0, 3]
```

Are these separators dependent on preceding and succeeding items? Use `collection.separatedBy((before, after) => separator)`:

```dart
[1, 2, 3].separatedBy((before, after) => before + after); // [1, 3, 2, 5, 3]
```

### Wrapper for Optional parameters

Ever needed to differentiate the value of a nullable parameter that was purposefully passed as `null` from a value that was simply omitted?  
For example `copyWith` typically replaces any value that was passed. But how sould it handle nullable parameters?

```dart
// status-quo, bad example
Foo copyWith({
  double? foo,
}) {
  return Foo(
    // The caller cannot raplce a non-null value of foo by null.
    foo: foo ?? this.foo,
  );
}
```

For this, a `Wrapper` extension was added:

```dart
Foo copyWith({
  Wrapper<double?>? foo,
}) {
  return Foo(
    // Applies any wrapped value of foo (including null).
    // Omit foo entirely and the old value is kept.
    foo: foo == null ? this.foo : foo.value,
  );
}
```

Any value can be wrapped by calling the `wrapped` getter on it:

```dart
fooInstance.copyWith(foo: 1.5.wrapped);
```

### Find enum values "byNameOrNull"

In dart, you can find enum values by their names, like:

```dart
enum TestEnum { one, two, three }

TestEnum.values.byName('two');
```

But what if that value does not exist? Dart will throw an `ArgumentError`.
Use `byNameOrNull` to receive `null` instead:

```dart
TestEnum.values.byValueOrNull('four');
```

### Gap

We often require some small space between widgets. Flutter's widget catalog has limited options:

- Flutter's [Spacer](https://api.flutter.dev/flutter/widgets/Spacer-class.html) takes up all available space, which is often more than we want.
- Flutter's [Padding](https://api.flutter.dev/flutter/widgets/Padding-class.html) unfortunately needs to be wrapped around widgets, adding boilerplate, while also being hard to read inside of lists.
- The best that Flutter offers is a [SizedBox](https://api.flutter.dev/flutter/widgets/SizedBox-class.html) with a specified `width` or `height`.  
  However, this still has some problems: We need to set either `width` or `height`, depending on whether the `SizedBox` is placed inside a `Row` or `Column`.  
  We also need to repeat the same constant pixel size all throughout the application.

Instead, consider using a `Gap`:

```dart
Column(
  children: [
    Text('first'),
    Gap(),
    Text('second'),
  ],
);
```

`Gap` takes up a fixed space in both directions.  
It takes 16 pixels by default, but can be configured using the `GapThemeData` theme extension or its constructor parameters.  
When you need a little more or less space relative to the configured theme, create a Gap with a scale factor, like `Gap(scale: 2)` or `Gap(scale: 0.5)` respectivly.
You can also add to, subtract from, multiply or devide a Gap to scale it, e.g. `Gap() * 2`.

There is also a [package named "Gap"](https://pub.dev/packages/gap), which works in a similar way, but has a few more features, which I personally don't need.

### ThemedText

Avoid accessing `ThemeData` manually to set a themed `textStyle`. Use a `ThemedText` widget instead:

```dart
ThemedText.headlineMedium('Some headline');
```

### AsyncBuilder

Using Flutter's [FutureBuilder](https://api.flutter.dev/flutter/widgets/FutureBuilder-class.html) requires a lot of imperative boilerplate.  
You need to explicitly catch loading, error and no-data states while also keeping the `Future` in state.  
If you do this: `FutureBuilder(future: load(), builder: ...);`, then FutureBuilder will call `load()` whenever your widget rebuilds.

As an alternative, `AsyncBuilder` offers a declarative API:

```dart
AsyncBuilder(
  createFuture: (context) => Future.delayed(
    const Duration(seconds: 1),
    () => 'some data',
  ),
  builder: (context, data) => Text(data),
);
```

`AsyncBuilder` only reloads when its `key` changes.
You can also customize `initialData` and change the look of loading, no-data and error states, which each have sensible defaults.

Use `AsyncBuilder.asset` to avoid explicitly getting the [`DefaultAssetBundle` from `BuildContext`](https://api.flutter.dev/flutter/widgets/DefaultAssetBundle/of.html):

```dart
AsyncBuilder.asset(
  (assetBundle) => assetBundle.loadString('assets/file.txt'),
  builder: (context, data) => Text(data),
);
```

### Spinner

`Spinner` is essentially a slightly improved [CircularProgressIndicator](https://api.flutter.dev/flutter/material/CircularProgressIndicator-class.html).  
It is always centered, can be given a fixed `size`, its `strokeWidth` is a bit more narrow and it all can be themed using `SpinnerThemeData`.  
It is also the default loading indicator used by `AsyncBuilder`.

### Link

Flutter comes with some clickable and tappable widgets, but none that look like a regular HTML `<a>` tag.  
The `Link` widget is just that. It performs an action when tapped and makes its `child: Text` look like an HTML link with an underline and that classic blue color. This style can be customized through constructor parameters or by using the `LinkThemeData` theme extension.

```dart
Link(
  onTap: () {
    // do something
  },
  child: const Text('Click me'),
),
```

### Pagination

Need improved performance when displaying many elements on screen at once? Try `Pagination`:

```dart
Pagination(
  maxPageSize: 20,
  // getPage returns a `Paginated` instance with `totalItemCount` and generic `items`
  getPage: (int pageIndex) => ...
  builder: (context, items) => ListView(
    children: [
      for (final item in items)
        ListTile(
          title: Text(item),
        ),
    ],
  ),
),
```

`Pagination` calls `getPage`, handles the `Future` and displays numbered controls below the return value of `builder`.
If needed, take external control using a `PaginationController`.
