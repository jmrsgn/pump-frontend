import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pump/core/constants/app/app_dimens.dart';
import 'package:pump/core/presentation/theme/app_colors.dart';
import 'package:pump/core/presentation/theme/app_text_styles.dart';
import 'package:pump/core/presentation/widgets/custom_scaffold.dart';
import 'package:pump/core/utils/navigation_utils.dart';

import '../../../../core/constants/app/app_strings.dart';
import '../../../../core/routes.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  // TODO continue

  final List<Map<String, String>> clients = const [
    {
      'name': 'John Martin I. Marasigan',
      'status': 'Active',
      'image': 'assets/images/jm.jpg',
    },
    {'name': 'Hans Gracia', 'status': 'Inactive', 'image': ''},
    {'name': 'Romeo Jaranilla', 'status': 'Active', 'image': ''},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Clients'),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppDimens.dimen12),
        child: Column(
          children: [
            // Search bar
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimens.dimen12,
                vertical: AppDimens.dimen4,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimens.radiusM),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search clients...',
                  hintStyle: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppDimens.dimen12),

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
                    imagePath: client['image']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(
          Icons.add,
          size: AppDimens.dimen16,
          color: AppColors.textOnPrimary,
        ),
        label: Text(
          AppStrings.enroll,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textOnPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.symmetric(
            horizontal: AppDimens.dimen16,
            vertical: AppDimens.dimen8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimens.radiusM),
          ),
        ),
      ),
    );
  }

  Widget _buildClientCard(
    BuildContext context, {
    required String name,
    required String status,
    String imagePath = '',
  }) {
    return Card(
      color: AppColors.surface,
      margin: EdgeInsets.only(bottom: AppDimens.dimen8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusM),
      ),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(AppDimens.dimen12),
        child: Row(
          children: [
            // Profile avatar with subtle shadow
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: AppDimens.radiusXL,
                backgroundImage: imagePath.isNotEmpty
                    ? AssetImage(imagePath)
                    : null,
                backgroundColor: imagePath.isEmpty
                    ? AppColors.primary
                    : Colors.transparent,
              ),
            ),
            SizedBox(width: AppDimens.dimen12),

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
                  SizedBox(height: AppDimens.dimen4),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: status.toLowerCase() == 'active'
                            ? AppColors.success
                            : AppColors.error,
                        size: AppDimens.dimen8,
                      ),
                      SizedBox(width: AppDimens.dimen4),
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

            // Navigate button
            IconButton(
              onPressed: () {
                NavigationUtils.navigateTo(context, AppRoutes.clientInfo);
              },
              icon: Icon(FontAwesomeIcons.arrowRight, size: AppDimens.dimen16),
            ),
          ],
        ),
      ),
    );
  }
}
