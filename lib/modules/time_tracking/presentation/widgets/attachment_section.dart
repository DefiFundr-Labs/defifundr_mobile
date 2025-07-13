import 'package:flutter/material.dart';

class AttachmentSection extends StatelessWidget {
  final String? attachmentName;
  final VoidCallback onUpload;
  final VoidCallback onRemove;

  const AttachmentSection({
    Key? key,
    this.attachmentName,
    required this.onUpload,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Attachment (Optional)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.0),
        
        if (attachmentName == null)
          GestureDetector(
            onTap: onUpload,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 40.0),
              decoration: BoxDecoration(
                color: Color(0xFF6366F1).withOpacity(0.05),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Color(0xFF6366F1).withOpacity(0.2),
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Click to upload',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6366F1),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.insert_drive_file,
                  color: Color(0xFF6366F1),
                  size: 24,
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Text(
                    attachmentName!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onRemove,
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        
        if (attachmentName == null) ...[
          SizedBox(height: 8.0),
          Text(
            'Supported formats: JPG, PNG, HEIC or PDF. Use .ZIP to upload multiple files.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ],
    );
  }
}
