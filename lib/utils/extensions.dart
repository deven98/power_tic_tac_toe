import 'dart:ui';

extension SizeExtension on Size {
  get offset => Offset(this.width, this.height);
}
