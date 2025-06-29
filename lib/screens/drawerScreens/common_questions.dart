import 'package:flutter/material.dart';
import 'package:sahary_united_company_for_powers/constants/app_color_styles.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/models/common_question_model.dart';
import 'package:sahary_united_company_for_powers/screens/drawerScreens/drawer_screens_container.dart';
import 'package:sahary_united_company_for_powers/widgets/expandable_card.dart';

class CommonQuestions extends StatefulWidget {
  const CommonQuestions({super.key});

  @override
  State<CommonQuestions> createState() => _CommonQuestionsState();
}

class _CommonQuestionsState extends State<CommonQuestions> {
  final List<CommonQuestionModel> commonQuestions = [
    CommonQuestionModel(
      id: 1,
      question: 'كيف يمكننى التواصل مع الاادارة؟',
      answer:
          'يمكن للجميع التواصل مع الادارة والاستفسار عن اى الموضوعات التى يرغبها الزائر عبر الايميل الرسمى (w@sahary.com.sa)  او من خلال التواصل تليفونيا علي الرقم 0564188059',
    ),
    CommonQuestionModel(
      id: 2,
      question: 'ما هى المنتجات التى تقدمها الشركة؟',
      answer:
          'لدينا العديد من المنتجات المميزة مثل:\n'
          '* جميع اكسسورات تمديد الكابلات الارضية ( كهرباء وفايبر ) رول ارضي مستقيم وزاوية حوامل بكرات\n'
          '* دقاقات (شواكيش) كوري الصنع كافة المقاسات.\n'
          '* جميع باكت الخاص بالمعدات كتربلير مقاسات مختلفة وجميع قطع غيار كتربيلر الاصلي.\n'
          '* جميع قطع غيار كتربيلر الاصلي من شركة الزاهد للتراكتورات المحدودة - مورد معتمد لدى شركة الزاهد.\n'
          'وغيرها الكثير والكثير.',
    ),
    CommonQuestionModel(
      id: 3,
      question: 'لماذا اتعامل مع شركة صحارى المتحدة؟',
      answer:
          'شركة صحارى المتحدة: رواد معدات الحفر والشواكيش الكورية ومعدات سحب وتمديد الكابلات وكافة خدمات النقل مع توريد جميع قطع الغيار CAT-Mercedes Benz-FUSO-HIAB الاصلية. '
          'حيث لدينا أحدث المعدات والماكينات بأسعار تنافسية في السوق السعودي بجودة مميزة وخدمة عملاء ذات كفاءة عالية للرد على كافة استفساراتكم.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DrawerScreensContainer(
      title: Texts.commonQuestions,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:
                      commonQuestions.map((question) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ExpandableCard(
                            title: question.question,
                            content: question.answer,
                            backgroundColor: AppColors.background0,
                          ),
                        );
                      }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
