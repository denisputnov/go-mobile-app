import 'package:flutter/material.dart';
import 'package:go/components/AppBar.dart';
import 'package:go/components/TextTitle.dart';
import 'package:go/utils/gotheme.dart';
import 'package:provider/provider.dart';

class Suggest extends StatelessWidget {
  String addGameText =
      'Мы даём возможность загружать свои собственные игры в наше приложение.\nНа данный момент это бесплатно.\n\nЕсли Вы владаете каким-либо бизнесом и заинтересованы в привлечении аудитории через наше приложение, то мы точно подружимся.\n\nДля публикации необходимо:\n- ознакомиться с политикой конфиденциальности\n- подтвердить свой аккаунт для получения доступа к конструктору\n\nПосле создания игры или акции она попадает на проверку. За собой мы оставляем право удалить\\отклонить любую акцию без объяснения причины.\nПо ссылке ниже Вы можете ознакомиться с полной информацией, необходимой для создания своей игры.\n\nПрочитать подробнее.';
  String suggestIdea =
      'Мы очень рады, что Вы пользуетесь нашим приложением. Объединая людей вместе, мы хотели бы создать прекрасный продукт. Из-за этого напоминаем Вам, что наши контакты всегда открыты для ваших предложений.\nЛюбая идейная и материальная помощь не будет недооценена.\n\nСписок контактов:';
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
            TextBlock(addGameText),
            TextTitle("Пользователям:"),
            TextBlock(suggestIdea),
          ],
        ),
      ),
    );
  }
}

class TextBlock extends StatelessWidget {
  String label;

  TextBlock(this.label);

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
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
