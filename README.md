Extensions and widgets that are missing in Flutter's SDK.

## Features

- Declarative extensions to avoid loops and imperative logic.
- Useful widgets, like a `Gap` widget to avoid the use of `Padding`.

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

### Enum values byNameOrNull

In dart, you can find enum values by their names, like:

```dart
enum TestEnum { one, two, three }

TestEnum.values.byName('two');
```

But what if that value does not exist? Dart will throw an `ArgumentError`.
Use byNameOrNull to receive `null` instead:

```dart
TestEnum.values.byValueOrNull('four');
```

### Gap

We often require some small space between widgets. Flutter's widget catalog has limited options:

- Flutter's `Spacer` takes up all available space, which is often more than we want.
- Flutter's `Padding` unfortunately needs to be wrapped around widgets, adding boilerplate, while also being hard to read inside of lists.
- The best that Flutter offers is a `SizedBox` with a specified `width` or `height`.  
  However, this still has some problems: We need to set either `width` or `height`, depending on whether the `SizedBox` is placed inside a `Row` or `Column`.  
  We also need to repeat the same constant pixel size all throughout the application.

Instead, consider using a `Gap`:

```dart
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      Text('first'),
      Gap(),
      Text('second'),
    ],
  );
}
```

`Gap` takes up a fixed space in both directions.  
It takes 16 pixels by default, but can be configured using the `GapThemeData` theme extension or its constructor parameters.  
When you need a little more or less space relative to the configured theme, create a Gap with a scale factor, like `Gap(scale: 2)` or `Gap(scale: 0.5)` respectivly.
You can also multiply or devide a Gap to scale it: `Gap() * 2` or `Gap() / 2`.

### StyledText

Avoid accessing `ThemeData` manually to set a themed `textStyle`. Use a `StyledText` widget instead:

```dart
return StyledText.headlineMedium('Some headline');
```
