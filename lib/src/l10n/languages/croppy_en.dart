import 'package:croppy/src/l10n/croppy_localizations.dart';

class CroppyLocalizationsEn extends CroppyLocalizations {
  CroppyLocalizationsEn() : super('en');

  @override
  String get cancelLabel => '取消';

  @override
  String get cupertinoFreeformAspectRatioLabel => 'FREEFORM';

  @override
  String get cupertinoOriginalAspectRatioLabel => 'ORIGINAL';

  @override
  String get cupertinoResetLabel => '重置';

  @override
  String get cupertinoSquareAspectRatioLabel => '1:1';

  @override
  String get doneLabel => '确定';

  @override
  String get materialFreeformAspectRatioLabel => 'Free';

  @override
  String materialGetFlipLabel(LocalizationDirection direction) =>
      'Flip to ${direction == LocalizationDirection.vertical ? 'vertical' : 'horizontal'}';

  @override
  String get materialOriginalAspectRatioLabel => 'Original';

  @override
  String get materialResetLabel => '重置';

  @override
  String get materialSquareAspectRatioLabel => '1:1';

  @override
  String get saveLabel => '保存';
}
