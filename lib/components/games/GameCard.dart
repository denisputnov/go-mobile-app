import 'package:flutter/material.dart';
import 'package:go/utils/gotheme.dart';
import 'package:provider/provider.dart';

class GameCard extends StatelessWidget {
  dynamic image;
  Color startColor;
  Color endColor;
  double startGradientPos;
  double endGradientPos;

  Color contentColor;
  String category;
  double categoryFontSize;
  IconData icon;
  String title;
  double titleFontSize;

  bool isBoldTitle;

  Widget destination;

  GameCard(
      {this.image,
      this.startColor,
      this.endColor,
      this.startGradientPos,
      this.endGradientPos,
      this.contentColor,
      this.category,
      this.categoryFontSize = 14,
      this.icon,
      this.title,
      this.titleFontSize = 30,
      this.isBoldTitle = true,
      this.destination});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double cardWidth = screenWidth - context.watch<GoTheme>().margin * 2;
    double cardHeight = cardWidth * 9 / 16;

    return GestureDetector(
      onTap: () {
        if (destination != null) Navigator.push(context, MaterialPageRoute(builder: (context) => destination));
      },
      child: Container(
        decoration: BoxDecoration(
          color: startColor,
          borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
          boxShadow: context.watch<GoTheme>().boxShadow,
        ),
        margin: EdgeInsets.all(context.watch<GoTheme>().margin),
        width: cardWidth,
        height: cardHeight,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
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
                child: image is Image
                    ? image
                    : Image.network(
                        image,
                        repeat: ImageRepeat.noRepeat,
                        fit: BoxFit.cover,
                        width: cardWidth,
                        height: cardHeight,
                      ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(context.watch<GoTheme>().padding),
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
                          fontWeight: isBoldTitle ? FontWeight.w600 : FontWeight.normal,
                        ),
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
