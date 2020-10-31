import 'package:flutter/material.dart';
import 'package:go/utils/default.dart';


class GameCard extends StatelessWidget {
  String image = './assets/icons/coffe.png';
  Color startColor = Color(0xffC28456);
  Color endColor = Colors.white.withOpacity(0);
  double startGradientPos = 0;
  double endGradientPos = 1;

  Color contentColor = Colors.white;
  String category = "Подпишись в соцсетях";
  double categoryFontSize = 14;
  IconData icon = Icons.settings;
  String title = 'Кофе "Coffies co скидкой 10%"';
  double titleFontSize = 30;

  bool isBoldTitle = false;

  Widget destination;

  // GameCard({number});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double cardWidth = screenWidth - Default.getDefaultMargin(onlyValue: true) * 2;
    double cardHeight = cardWidth * 9 / 16;

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
      },
      child: Container(
        decoration: BoxDecoration(
          color: startColor,
          borderRadius: Default.getDefauilBorderRadius(),
        ),
        margin: Default.getDefaultMargin(),
        width: cardWidth,
        height: cardHeight,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: Default.getDefauilBorderRadius(),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                          colors: [startColor, endColor],
                          stops: [startGradientPos, endGradientPos],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)
                      .createShader(bounds);
                },
                blendMode: BlendMode.srcATop,
                child: Image.asset(
                  image,
                  repeat: ImageRepeat.noRepeat,
                  fit: BoxFit.cover,
                  width: cardWidth,
                  height: cardHeight,
                ),
              ),
            ),
            Container(
              padding: Default.getDefaultPadding(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(category, style: TextStyle(color: contentColor, fontSize: categoryFontSize)),
                  SizedBox(height: 10),
                  Icon(icon, color: contentColor, size: 30),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: titleFontSize,
                            color: contentColor,
                            fontWeight: isBoldTitle ? FontWeight.w600 : FontWeight.normal),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

