import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:instagram/utils/util_functions.dart';
import 'package:instagram/resources/firestore_access.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreAccess().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        if (context.mounted) {
          showSnackBar(
            context,
            'Posted!',
          );
        }
        clearImage();
      } else {
        if (context.mounted) {
          showSnackBar(context, res);
        }
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
