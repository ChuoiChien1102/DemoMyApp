import 'package:flutter/material.dart';
import 'package:myapp/component/card/one_card.dart';
import 'package:myapp/component/appbar/one_app_bar.dart';
import 'package:myapp/constant/app_colors.dart';
import 'package:myapp/models/event.dart';
import 'package:myapp/theme/app_theme.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key, required this.event});
  final Event event;

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  late Event _event;

  @override
  void initState() {
    super.initState();
    _event = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OneAppBar(
                title: 'Events ${_event.id.toString()}',
                onTapBack: () {
                  Navigator.of(context).pop();
                },
              ),
              _buildEventDetail(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventDetail(BuildContext context) {
    return OneCard(
      margin: const EdgeInsets.fromLTRB(20, 14, 20, 14),
      padding: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(8.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'EventID: ',
                  style: AppTheme.of(context)
                      .textFieldText
                      .copyWith(color: AppColors.textBrand),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  _event.id.toString(),
                  style: AppTheme.of(context)
                      .textFieldText
                      .copyWith(color: AppColors.textBrand),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1.0, color: AppColors.dividerGrey),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Name: ',
                  style: AppTheme.of(context)
                      .textFieldText
                      .copyWith(color: AppColors.textBrand),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  _event.name,
                  style: AppTheme.of(context)
                      .textFieldText
                      .copyWith(color: AppColors.textBrand),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1.0, color: AppColors.dividerGrey),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'ExpectedDate: ',
                  style: AppTheme.of(context)
                      .textFieldText
                      .copyWith(color: AppColors.textBrand),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  _event.expectedDate,
                  style: AppTheme.of(context)
                      .textFieldText
                      .copyWith(color: AppColors.textBrand),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1.0, color: AppColors.dividerGrey),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Status: ',
                  style: AppTheme.of(context)
                      .textFieldText
                      .copyWith(color: AppColors.textBrand),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  _event.status.toString(),
                  style: AppTheme.of(context)
                      .textFieldText
                      .copyWith(color: AppColors.textBrand),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1.0, color: AppColors.dividerGrey),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'UserID: ',
                  style: AppTheme.of(context)
                      .textFieldText
                      .copyWith(color: AppColors.textBrand),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  _event.userId.toString(),
                  style: AppTheme.of(context)
                      .textFieldText
                      .copyWith(color: AppColors.textBrand),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1.0, color: AppColors.dividerGrey)
        ],
      ),
    );
  }
}
