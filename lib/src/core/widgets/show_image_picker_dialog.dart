import 'package:flutter/material.dart';

Future<void> showImagePickerDialog(
  BuildContext context,
  VoidCallback onCameraTap,
   VoidCallback onFileTap,
) async {
  return showDialog(
    context: context,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Select Option",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Camera
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () {
                  Navigator.of(context).pop();
                  onCameraTap();
                },
              ),

              // Gallery
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.of(context).pop();
                  onFileTap();
                },
              ),

            ],
          ),
        ),
      );
    },
  );
}
