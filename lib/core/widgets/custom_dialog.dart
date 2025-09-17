import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Enum to define dialog types
enum DialogType { success, error }

class CustomDialog extends StatefulWidget {
  final DialogType type; // Success or Error
  final String title; // e.g., "Login Successful" or "Login Failed"
  final String message; // Detailed message
  final VoidCallback? onOkPressed; // Optional callback for OK button

  const CustomDialog({
    super.key,
    required this.type,
    required this.title,
    required this.message,
    this.onOkPressed,
  });

  @override
  CustomDialogState createState() => CustomDialogState();
}

class CustomDialogState extends State<CustomDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Set up animation for pop-in effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine icon and color based on dialog type
    final isSuccess = widget.type == DialogType.success;
    final icon = isSuccess ? Icons.check_circle : Icons.error;
    final iconColor = isSuccess ? Colors.green : Colors.red;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r), // Rounded corners
        ),
        elevation: 8,
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Fit content
            children: [
              // Icon (checkmark for success, error for failure)
              Icon(
                icon,
                size: 48.sp,
                color: iconColor,
              ),
              SizedBox(height: 16.h),
              // Title
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 8.h),
              // Message
              Text(
                widget.message,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              // OK Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  widget.onOkPressed?.call(); // Trigger optional callback
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                ),
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}