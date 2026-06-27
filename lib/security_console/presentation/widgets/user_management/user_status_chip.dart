import 'package:digify_core/constants/app_colors.dart';
import 'package:digify_security_console/security_console/domain/models/system_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserStatusChip extends StatelessWidget {
  final SystemUserStatus status;

  const UserStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final bool isActive = status == SystemUserStatus.active;
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isActive ? AppColors.activeStatusBgLight : AppColors.redBg,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        isActive ? 'ACTIVE' : 'LOCKED',
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: isActive ? AppColors.activeStatusTextLight : AppColors.redText,
        ),
      ),
    );
  }
}
