import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enebla_user_app/models/comment_model.dart';

class CommentService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  postUserCommentToDatabase(
      {required String commentedby,
      required String commentedto,
      required String comment}) async {
    String res = '';
    CommentModel commentModel = CommentModel(
        comment: comment, commentedby: commentedby, commentedto: commentedto);

    await _firestore
        .collection('comments')
        .doc(commentedto)
        .set(commentModel.toJson(), SetOptions(merge: true))
        .then((value) {
      res = 'comment added successfully';
    }).onError((error, stackTrace) {
      res = error.toString();
    });

    return res;
  }
}
