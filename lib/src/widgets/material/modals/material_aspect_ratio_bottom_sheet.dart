import 'package:croppy/src/src.dart';
import 'package:flutter/material.dart';

class MaterialAspectRatioBottomSheet extends StatelessWidget {
  const MaterialAspectRatioBottomSheet({
    super.key,
    required this.controller,
  });

  final MaterialCroppableImageController controller;

  String _convertAspectRatioFuncString(CropAspectRatio? aspectRatio) {
    if (aspectRatio == null) {
      return '';
    }
    final width = aspectRatio.width;
    final height = aspectRatio.height;
    final ratio = width / height;
    var resStr = '';
    if (ratio == 4 / 3) {
      resStr = '朋友圈配图常用尺寸';
    }
    if (ratio == 3 / 4) {
      resStr = '小红书图文尺寸，推荐超精绘模式绘图。';
    }
    if (ratio == 1) {
      resStr = '社交头像尺寸，推荐精绘绘图。';
    }
    if (ratio == 16 / 9) {
      resStr = '电脑壁纸尺寸，推荐超精绘模式绘图。';
    }
    if (ratio == 9 / 16) {
      resStr = '快手视频图文尺寸，推荐超精绘模式绘图。';
    }
    if (ratio == 9 / 20) {
      resStr = '手机壁纸尺寸，推荐超精绘模式绘图。';
    }
    return resStr;
  }

  String _convertAspectRatioToString(
    BuildContext context,
    CropAspectRatio? aspectRatio,
  ) {
    final l10n = CroppyLocalizations.of(context)!;

    if (aspectRatio == null) {
      return l10n.materialFreeformAspectRatioLabel;
    }

    final width = aspectRatio.width;
    final height = aspectRatio.height;

    final imageSize = controller.data.imageSize;

    if ((width == imageSize.width && height == imageSize.height) ||
        (width == imageSize.height && height == imageSize.width)) {
      return l10n.materialOriginalAspectRatioLabel;
    }

    if (aspectRatio.isSquare) {
      return l10n.materialSquareAspectRatioLabel;
    }

    return l10n.getAspectRatioLabel(width, height);
  }

  List<CropAspectRatio?> get aspectRatiosToDisplay {
    final aspectRatios = controller.allowedAspectRatios;
    final cleanedAspectRatios = <CropAspectRatio?>[];

    for (final ar in aspectRatios) {
      if (ar == null) {
        cleanedAspectRatios.add(ar);
        continue;
      }

      // final complement = ar.complement;

      // if (aspectRatios.contains(complement)) {
      //   final isHorizontal = ar.isHorizontal;

      //   if (isHorizontal && !cleanedAspectRatios.contains(ar)) {
      //     cleanedAspectRatios.add(ar);
      //   } else if (!isHorizontal && !cleanedAspectRatios.contains(complement)) {
      //     cleanedAspectRatios.add(complement);
      //   }
      // } else {
      //   cleanedAspectRatios.add(ar);
      // }
      cleanedAspectRatios.add(ar);
    }

    return cleanedAspectRatios;
  }

  bool get canFlipToComplement {
    final currentAspectRatio = controller.currentAspectRatio;

    if (currentAspectRatio == null) {
      return false;
    }

    if (currentAspectRatio.isSquare) {
      return false;
    }

    final complement = currentAspectRatio.complement;
    return controller.allowedAspectRatios.contains(complement);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = CroppyLocalizations.of(context)!;
    final aspectRatio = controller.currentAspectRatio;

    return SingleChildScrollView(
      child: Column(
        children: [
          ...aspectRatiosToDisplay.map(
            (v) => ListTile(
              selectedColor: const Color(0xff8974FF),
              title: Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(
                      _convertAspectRatioToString(context, v),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    child: AspectRatio(
                      aspectRatio: v!.width / v!.height,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            color: v == aspectRatio
                                ? const Color(0xff8974ff)
                                : const Color(0xff666666),
                            borderRadius: BorderRadius.circular(2),
                            border: Border.all(color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(width: 50),
                  Expanded(
                      child: Text(
                    _convertAspectRatioFuncString(v),
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 12),
                  ))
                ],
              ),
              selected: v == aspectRatio,
              onTap: () {
                controller.currentAspectRatio = v;
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
