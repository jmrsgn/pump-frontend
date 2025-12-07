import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pump/core/constants/app/app_dimens.dart';
import 'package:pump/core/presentation/theme/app_colors.dart';
import 'package:pump/core/presentation/theme/app_text_styles.dart';
import 'package:pump/core/presentation/widgets/custom_button.dart';
import 'package:pump/core/presentation/widgets/custom_scaffold.dart';
import 'package:pump/core/presentation/widgets/custom_text_field.dart';
import 'package:pump/core/utils/navigation_utils.dart';
import 'package:pump/core/utils/ui_utils.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/routes.dart';

class ClientsScreen extends ConsumerStatefulWidget {
  const ClientsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends ConsumerState {
  final _searchController = TextEditingController();

  final List<Map<String, String>> clients = const [
    {
      'name': 'John Martin I. Marasigan',
      'status': 'Active',
      'image': 'assets/images/jm.jpg',
    },
    {'name': 'Romeo Jaranilla', 'status': 'Active', 'image': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CustomScaffold(
        appBarTitle: AppStrings.clients,
        body: Padding(
          padding: EdgeInsets.all(AppDimens.paddingScreen),
          child: Column(
            children: [
              // Search bar
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimens.padding12,
                  vertical: AppDimens.padding4,
                ),
                child: CustomTextField(
                  prefixIcon: Icons.search,
                  hint: AppStrings.searchClients,
                  controller: _searchController,
                ),
              ),

              UiUtils.addVerticalSpaceM(),

              // Client list
              Expanded(
                child: ListView.builder(
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final client = clients[index];
                    return _buildClientCard(
                      context,
                      name: client['name']!,
                      status: client['status']!,
                      profileImageUrl: client['image']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: CustomButton(
          prefixIcon: Icons.add,
          onPressed: () {},
          label: AppStrings.enroll,
        ),
      ),
    );
  }

  Widget _buildClientCard(
    BuildContext context, {
    required String name,
    required String status,
    String profileImageUrl = '',
  }) {
    return GestureDetector(
      onTap: () {
        NavigationUtils.navigateTo(context, AppRoutes.clientOverview);
      },
      child: Card(
        color: AppColors.surface,
        margin: EdgeInsets.only(bottom: AppDimens.margin8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radius8),
        ),
        elevation: AppDimens.elevation3,
        child: Padding(
          padding: EdgeInsets.all(AppDimens.padding12),
          child: Row(
            children: [
              profileImageUrl == ''
                  ? CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: AppDimens.radius24,
                      child: Text(name[0], style: AppTextStyles.heading2),
                    )
                  : CircleAvatar(
                      backgroundImage: AssetImage(profileImageUrl),
                      radius: AppDimens.radius24,
                    ),
              UiUtils.addHorizontalSpaceM(),

              // Name & Status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    UiUtils.addVerticalSpaceXS(),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: status.toLowerCase() == 'active'
                              ? AppColors.success
                              : AppColors.error,
                          size: AppDimens.dimen8,
                        ),
                        UiUtils.addHorizontalSpaceS(),
                        Text(
                          status,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(FontAwesomeIcons.arrowRight, size: AppDimens.dimen16),
            ],
          ),
        ),
      ),
    );
  }
}
