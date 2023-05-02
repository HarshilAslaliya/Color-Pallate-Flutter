import 'package:color_pallate/modals/colorpallate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/pallate_provider.dart';
import '../../providers/theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int i = 0;
  bool switchValue = false;
  bool isTrue = false;

  defaultProvider() {
    Provider.of<PaletteProvider>(context, listen: false)
        .changePalette(index: 0);
  }

  @override
  void initState() {
    super.initState();
    defaultProvider();
  }

  late Uint8List imageFile;

  @override
  Widget build(BuildContext context) {
    ColorPalette colorpalette =
        Provider.of<PaletteProvider>(context).palette;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Color Pallate Generator",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () async {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .changeTheme();
                    isTrue = !isTrue;
                  },
                  icon: Icon(
                    (isTrue == true)
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                  ),
                )
              ],
            ),
          ),
          const Spacer(flex: 2,),
          Text(
            (switchValue == false)
                ? "Opacitywise Color Pallate"
                : "Random Color Pallate",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
          const Spacer(),
          Transform.scale(
            scale: 1.2,
            child: Switch(
              activeThumbImage: const AssetImage("assets/images/switch.png"),
              inactiveThumbColor: colorpalette.colorList[1],
              activeTrackColor: colorpalette.colorList[0],
              inactiveTrackColor: colorpalette.colorList[0],
              value: switchValue,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (val) {
                setState(() {
                  switchValue = val;
                });
              },
            ),
          ),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                      ClipboardData(text: "${colorpalette.codeList[0]}"));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: const Text("Copied Color Code!"),
                      backgroundColor: (isTrue == true)
                          ? Colors.white
                          : Colors.grey.shade800,
                    ),
                  );
                },
                child: Container(
                  height: size.height * 0.1,
                  width: size.width * 0.61,
                  decoration: BoxDecoration(
                    color: colorpalette.colorList[0],
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                ),
              ),
              buildGestureDetector(colorpalette, context, num: 1),
              buildGestureDetector(colorpalette, context, num: 2),
              buildGestureDetector(colorpalette, context, num: 3),
              buildGestureDetector(colorpalette, context, num: 4),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                      ClipboardData(text: "${colorpalette.codeList[5]}"));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: const Text("Copied Color Code!"),
                      backgroundColor: (isTrue == true)
                          ? Colors.white
                          : Colors.grey.shade800,
                    ),
                  );
                },
                child: Container(
                  height: size.height * 0.1,
                  width: size.width * 0.61,
                  decoration: BoxDecoration(
                    color: colorpalette.colorList[5],
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Transform.scale(
            scale: 1.2,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  isTrue ? Colors.white : Colors.grey.shade800,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              onPressed: () {
                if (switchValue) {
                  Provider.of<PaletteProvider>(context, listen: false)
                      .changeColorPalette();
                } else {
                  (i == 14) ? i = 0 : i++;
                  Provider.of<PaletteProvider>(context, listen: false)
                      .changePalette(index: i);
                }
              },
              child: Text(
                "Change Color",
                style: TextStyle(color: isTrue ? Colors.black : Colors.white),
              ),
            ),
          ),
          const Spacer(flex: 2,),
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(
      ColorPalette colorpalette, BuildContext context,
      {required int num}) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: "${colorpalette.codeList[num]}"));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: const Text("Copied Color Code!"),
            backgroundColor:
                (isTrue == true) ? Colors.white : Colors.grey.shade800,
          ),
        );
      },
      child: Container(
        height: size.height * 0.1,
        width: size.width * 0.61,
        color: colorpalette.colorList[num],
      ),
    );
  }
}
