// lib/models/block_unblock_response_model.dart

class BlockUnblockResponse {
  final bool? success;
  final String? message;
  final bool? blocked;

  BlockUnblockResponse({
    this.success,
    this.message,
    this.blocked,
  });

  factory BlockUnblockResponse.fromJson(Map<String, dynamic> json) {
    return BlockUnblockResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      blocked: json['blocked'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'blocked': blocked,
    };
  }
}