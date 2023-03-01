import 'dart:ui';

class TextInfo {
  final Offset? offset;
  final double? scale;
  final String text;
  final Color color;

  TextInfo(
      {this.offset, this.scale = 1.0, required this.text, required this.color});

  TextInfo copyWith({
    final Offset? offset,
    final double? scale,
    final String? text,
    final Color? color,
  }) {
    return TextInfo(
      offset: offset ?? this.offset,
      scale: scale ?? this.scale,
      text: text ?? this.text,
      color: color ?? this.color,
    );
  }
}
