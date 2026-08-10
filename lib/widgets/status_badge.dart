import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../models/visitor_model.dart';

class StatusBadge extends StatelessWidget {
  final VisitorStatus status;
  final bool compact;

  const StatusBadge({
    super.key,
    required this.status,
    this.compact = false,
  });

  Color get _color {
    switch (status) {
      case VisitorStatus.pending:
        return AppColors.warning;
      case VisitorStatus.approved:
        return AppColors.success;
      case VisitorStatus.denied:
        return AppColors.error;
      case VisitorStatus.checkedOut:
        return AppColors.info;
      case VisitorStatus.preRegistered:
        return AppColors.accent;
    }
  }

  IconData get _icon {
    switch (status) {
      case VisitorStatus.pending:
        return Icons.hourglass_empty_rounded;
      case VisitorStatus.approved:
        return Icons.check_circle_rounded;
      case VisitorStatus.denied:
        return Icons.cancel_rounded;
      case VisitorStatus.checkedOut:
        return Icons.logout_rounded;
      case VisitorStatus.preRegistered:
        return Icons.qr_code_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final label = _getLabel();
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 3 : 6,
      ),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        border: Border.all(color: _color.withOpacity(0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, color: _color, size: compact ? 12 : 14),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: _color,
              fontSize: compact ? 11 : 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  String _getLabel() {
    switch (status) {
      case VisitorStatus.pending:
        return 'Pending';
      case VisitorStatus.approved:
        return 'Approved';
      case VisitorStatus.denied:
        return 'Denied';
      case VisitorStatus.checkedOut:
        return 'Checked Out';
      case VisitorStatus.preRegistered:
        return 'Pre-Registered';
    }
  }
}
