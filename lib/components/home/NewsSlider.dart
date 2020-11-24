import 'package:flutter/material.dart';
import 'package:go/pages/gameconstructor.dart';

import '../../utils/default.dart';

class NewsSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.9 * 9 / 16,
      // padding: EdgeInsets.only(left: Default.getDefaultMargin(onlyValue: true)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          children: <Widget>[
            SliderCard(
              imgSrc:
                  'https://images.pexels.com/photos/5950964/pexels-photo-5950964.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
              startColor: Colors.black.withOpacity(0.6),
              endColor: Colors.black.withOpacity(0),
              label:
                  'Мы запустились! Сейчас приложение находится на этапе альфатестирования.\n\nСпасибо, что вы с нами!',
              labelColor: Colors.white,
            ),
            SliderCard(
              imgSrc:
                  'https://images.pexels.com/photos/4458199/pexels-photo-4458199.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
              startColor: Colors.black.withOpacity(0.6),
              endColor: Colors.black.withOpacity(0),
              label: 'Перейти в конструктор игр',
              labelColor: Colors.white,
              hasAction: true,
              destination: GameConstrucor(),
            ),
            SliderCard(
              imgSrc:
                  'https://images.pexels.com/photos/5630557/pexels-photo-5630557.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
              startColor: Colors.black.withOpacity(0.6),
              endColor: Colors.black.withOpacity(0),
              label: 'Что-то ещё',
              labelColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class SliderCard extends StatelessWidget {
  String imgSrc;
  Color startColor;
  Color endColor;
  String label;
  Color labelColor;
  bool hasAction;
  Widget destination;

  SliderCard(
      {this.imgSrc,
      this.startColor,
      this.endColor,
      this.label = '',
      this.labelColor = Colors.white,
      this.hasAction = false,
      this.destination});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasAction
          ? () async {
              await Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, anotrerAnimation) {
                    return this.destination;
                  },
                  transitionDuration: Duration(milliseconds: 300),
                  transitionsBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation, Widget child) {
                    animation = CurvedAnimation(curve: Curves.easeInOut, parent: animation);
                    return new SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            }
          : () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        margin: Default.getDefaultMargin(),
        decoration: BoxDecoration(borderRadius: Default.getDefauilBorderRadius()),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: Default.getDefauilBorderRadius(),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                          colors: [startColor, endColor],
                          stops: [0, 1],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)
                      .createShader(bounds);
                },
                blendMode: BlendMode.srcATop,
                child: Image.network(
                  imgSrc,
                  repeat: ImageRepeat.noRepeat,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: double.infinity,
                ),
              ),
            ),
            Container(
              padding: Default.getDefaultPadding(),
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: labelColor, fontSize: MediaQuery.of(context).size.width / 30),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
