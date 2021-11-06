import 'dart:io';

String readJson(String name) {
  var currentDirectory = Directory.current.toString().replaceAll('\'', '');
  var lastDirectory =
      currentDirectory.split('/')[currentDirectory.split('/').length - 1];
  if (lastDirectory == 'test') {
    return File('$name').readAsStringSync();
  } else {
    return File('test/$name').readAsStringSync();
  }
}
