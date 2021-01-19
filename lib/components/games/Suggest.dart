import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go/components/AppBar.dart';
import 'package:go/components/TextTitle.dart';
import 'package:go/utils/gotheme.dart';
import 'package:go/utils/launchUrl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Suggest extends StatelessWidget {
  String addGameText =
      'Мы даём возможность загружать свои собственные игры в наше приложение.\nНа данный момент это бесплатно.\n\nЕсли Вы владаете каким-либо бизнесом и заинтересованы в привлечении аудитории через наше приложение, то мы точно подружимся.\n\nДля публикации необходимо:\n- ознакомиться с политикой конфиденциальности\n- подтвердить свой аккаунт для получения доступа к конструктору\n\nПосле создания игры или акции она попадает на проверку. За собой мы оставляем право удалить\\отклонить любую акцию без объяснения причины.\nПо ссылке ниже Вы можете ознакомиться с полной информацией, необходимой для создания своей игры.\n\n';
  String suggestIdea =
      'Мы очень рады, что Вы пользуетесь нашим приложением. Объединая людей вместе, мы хотели бы создать прекрасный продукт. Из-за этого напоминаем Вам, что наши контакты всегда открыты для ваших предложений.\nЛюбая идейная и материальная помощь не будет недооценена.\n\nСписок контактов:\n';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      backgroundColor: context.watch<GoTheme>().backgroundColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            TextTitle("Добавить собственную игру:"),
            TextBlock(
              addGameText,
              TextSpan(
                text: 'Прочитать подробнее.',
                style: TextStyle(color: context.watch<GoTheme>().linkColor),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl('https://vk.com');
                  },
              ),
            ),
            TextTitle("Пользователям:"),
            TextBlock(
              suggestIdea,
              TextSpan(
                children: [
                  TextSpan(
                    text: 'goapp.sup@gmail.com\n',
                    style: TextStyle(color: context.watch<GoTheme>().linkColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Clipboard.setData(ClipboardData(text: "goapp.sup@gmail.com"));
                      },
                  ),
                  TextSpan(
                    text: 'Telegram',
                    style: TextStyle(color: context.watch<GoTheme>().linkColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launchUrl('https://t.me/grnbows');
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextBlock extends StatelessWidget {
  String label;
  TextSpan linkBlock;

  TextBlock(this.label, this.linkBlock);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.watch<GoTheme>().padding),
      margin: EdgeInsets.only(
        bottom: context.watch<GoTheme>().margin * 2,
        left: context.watch<GoTheme>().margin,
        right: context.watch<GoTheme>().margin,
        top: context.watch<GoTheme>().margin,
      ),
      decoration: BoxDecoration(
        color: context.watch<GoTheme>().secondaryColor,
        boxShadow: context.watch<GoTheme>().boxShadow,
        borderRadius: BorderRadius.circular(context.watch<GoTheme>().borderRadius),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: label,
              style: TextStyle(
                color: context.watch<GoTheme>().textColor,
              ),
            ),
            linkBlock,
          ],
        ),
      ),
    );
  }
}
