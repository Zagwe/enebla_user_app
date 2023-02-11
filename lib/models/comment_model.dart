import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String commentedby;
  final String commentedto;
  final String comment;

  CommentModel(
      {required this.comment,
      required this.commentedby,
      required this.commentedto});

  Map<String, dynamic> toJson() {
    return {
      commentedby: {
        'comment': comment,
        'commentedto': commentedto,
        'commentedby': commentedby
      }
    };
  }

  factory CommentModel.fromMap(Map) {
    return CommentModel(
        comment: Map['comment'],
        commentedby: Map['commentedby'],
        commentedto: Map['commentedto']);
  }
}
