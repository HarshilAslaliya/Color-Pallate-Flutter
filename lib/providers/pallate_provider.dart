import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../modals/colorpallate.dart';

class PaletteProvider with ChangeNotifier{

  Random random = Random();

  ColorPalette palette = ColorPalette(
    index: 0,
    codeList: ["FFF8BBD0", "FFF48FB1", "FFF06292", "FFEC4071", "FFE91E63", "FFAD1457", "FF880E4F"],
    colorList: [
      const Color(0xfff8bbd0),
      const Color(0xfff48fb1),
      const Color(0xfff06292),
      const Color(0xffec4071),
      const Color(0xffe91e63),
      const Color(0xffad1457),
      const Color(0xff880e4f)
    ],
  );

  void changePalette({required int index}) async {
    String data = await rootBundle.loadString("assets/json/color_data.json");
    List<dynamic> decodedData = jsonDecode(data);

    palette.codeList = await decodedData[index]["colors"];

    List<int> paletteIntData = palette.codeList.map((e) => int.parse(e, radix: 16)).toList();
    palette.colorList= paletteIntData.map((e) => Color(e)).toList();

    notifyListeners();
  }

  void changeColorPalette() async {
    String data = await rootBundle.loadString("assets/json/color_palette.json");
    List<dynamic> decodedData = jsonDecode(data);
    List<dynamic> res = decodedData[0]["colors"];

    int num1 = random.nextInt(104);
    int num2 = random.nextInt(104);
    int num3 = random.nextInt(104);
    int num4 = random.nextInt(104);
    int num5 = random.nextInt(104);
    int num6 = random.nextInt(104);
    List<String> dataList = [res[num1],res[num2],res[num3],res[num4],res[num5],res[num6]];

    palette.codeList = dataList;

    List<int> paletteIntData = palette.codeList.map((e) => int.parse(e, radix: 16)).toList();
    palette.colorList = paletteIntData.map((e) => Color(e)).toList();

    notifyListeners();
  }
}
