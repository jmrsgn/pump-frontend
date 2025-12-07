import 'package:flutter/material.dart';
import 'package:pump/core/presentation/widgets/custom_button.dart';

import '../../../../core/constants/app/app_dimens.dart';
import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/presentation/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/custom_scaffold.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/utils/ui_utils.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<StatefulWidget> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomScaffold(
        appBarTitle: AppStrings.feedback,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.paddingScreen),
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Takes only as much as available height needed
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.letMeKnowWhatToImprove,
                  style: AppTextStyles.bodyLarge,
                ),

                UiUtils.addVerticalSpaceXXL(),

                // Middle section
                Center(
                  child: CustomTextField(
                    hint: AppStrings.message,
                    controller: _messageController,
                    isMultiline: true,
                  ),
                ),

                UiUtils.addVerticalSpaceS(),

                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    onPressed: () {},
                    label: AppStrings.submit,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
