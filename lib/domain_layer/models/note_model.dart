import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  //Cannot be empty
  // can be empty
  late int id;
  final int createTimestamp;

  final String title;
  final String content;
  final int updateTimestamp;

  NoteModel(
      {required this.title,
      required this.content,
      required this.createTimestamp,
      required this.updateTimestamp});

  NoteModel.withIdConstructor(
      {required this.id,
      required this.createTimestamp,
      required this.title,
      required this.content,
      required this.updateTimestamp});

  NoteModel.fromMap(Map<String, dynamic> map)
      : id = map['_id'],
        title = map['title'],
        content = map['content'],
        createTimestamp = map['createTimestamp'],
        updateTimestamp = map['updateTimestamp'];

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'createTimestamp': createTimestamp,
      'updateTimestamp': updateTimestamp
    };
  }

  Map<String, dynamic> toMapWithId() {
    return {
      '_id': id,
      'title': title,
      'content': content,
      'createTimestamp': createTimestamp,
      'updateTimestamp': updateTimestamp
    };
  }

  @override
  List<Object> get props =>
      [id, createTimestamp, updateTimestamp, content, title];
}
