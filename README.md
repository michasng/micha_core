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

`Gap` takes up a fixed space of `16` pixels in both directions.  
When you need a little more or a little less space, just multiply or divide the Gap, like `Gap() * 2` or `Gap() / 2`.

### StyledText

Avoid accessing `ThemeData` manually to set a themed `textStyle`. Use a `StyledText` widget instead:

```dart
return StyledText.headlineMedium('Some headline');
```
