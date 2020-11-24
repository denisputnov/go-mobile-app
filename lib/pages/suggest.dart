import 'package:flutter/material.dart';
import 'package:go/components/AppBar.dart';
import 'package:go/utils/default.dart';

class Suggest extends StatelessWidget {
  String addGameText = 'Мы даём возможность загружать свои собственные игры в наше приложение.\nНа данный момент это бесплатно.\n\nЕсли Вы владаете каким-либо бизнесом и заинтересованы в привлечении аудитории через наше приложение, то мы точно подружимся.\n\nДля публикации необходимо:\n- ознакомиться с политикой конфиденциальности\n- подтвердить свой аккаунт для получения доступа к конструктору\n\nПосле создания игры или акции она попадает на проверку. За собой мы оставляем право удалить\\отклонить любую акцию без объяснения причины.\nПо ссылке ниже Вы можете ознакомиться с полной информацией, необходимой для создания своей игры.\n\nПрочитать подробнее.';
  String suggestIdea = 'Мы очень рады, что Вы пользуетесь нашим приложением. Объединая людей вместе, мы хотели бы создать прекрасный продукт. Из-за этого напоминаем Вам, что наши контакты всегда открыты для ваших предложений.\nЛюбая идейная и материальная помощь не будет недооценена.\n\nСписок контактов:';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(),
      backgroundColor: Default.getDefaultBackgroundColor(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SuggestCategory("Добавить собственную игру:"),
            TextBlock(addGameText),
            SuggestCategory("Пользователям:"),
            TextBlock(suggestIdea),
          ],
        ),
      ),
    );
  }
}

class SuggestCategory extends StatelessWidget {
  String label;

  SuggestCategory(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(label,
            style: Default.getDefaultTextStyle(fsz: MediaQuery.of(context).size.width / 20), textAlign: TextAlign.left),
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
      padding: Default.getDefaultPadding(),
      margin: EdgeInsets.only(
        bottom: Default.getDefaultMargin(onlyValue: true) * 2,
        left: Default.getDefaultMargin(onlyValue: true),
        right: Default.getDefaultMargin(onlyValue: true),
        top: Default.getDefaultMargin(onlyValue: true),
      ),
      decoration: BoxDecoration(
        color: Default.getDefaultSecondaryColor(),
        boxShadow: Default.getDefaultBoxShadow(),
        borderRadius: Default.getDefauilBorderRadius(),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
