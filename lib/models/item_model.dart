// هذا الكلاس يمثل كل عنصر تفاعلي داخل الصفحة (حرف، كلمة، صورة، صوت)

class ItemModel {
  final String id;
  final String type;
  final String content;
  final String imagePath;
  final String audioPath;
  // إحداثيات التموضع المئوية (من 0.0 إلى 1.0)
  final double top;
  final double left;
  final double width;

  ItemModel({
    required this.id,
    required this.type,
    required this.content,
    required this.imagePath,
    required this.audioPath,
    this.top = 0.0,
    this.left = 0.0,
    this.width = 0.3,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      content: json['content'] ?? '',
      imagePath: json['imagePath'] ?? '',
      audioPath: json['audioPath'] ?? '',
      top: (json['top'] as num?)?.toDouble() ?? 0.0,
      left: (json['left'] as num?)?.toDouble() ?? 0.0,
      width: (json['width'] as num?)?.toDouble() ?? 0.3,
    );
  }
}
