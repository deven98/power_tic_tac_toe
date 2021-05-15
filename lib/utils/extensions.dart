import 'dart:ui';

import 'package:power_tic_tac_toe/utils/constants.dart';

extension SizeExtension on Size {
  get offset => Offset(this.width, this.height);
}
