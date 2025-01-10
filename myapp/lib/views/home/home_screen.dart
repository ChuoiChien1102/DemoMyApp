import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:myapp/component/Card/one_card.dart';
import 'package:myapp/constant/app_colors.dart';
import 'package:myapp/constant/constant.dart';
import 'package:myapp/models/event.dart';
import 'package:myapp/theme/app_theme.dart';
import 'package:myapp/view_models/home_cubit.dart';
import 'package:myapp/views/event/event_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalManager globalManager = Get.find();
  List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeCubit>().getListEvent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buidTitle(context),
              _buildListEvent(context),
              _buildGetDataSuccess(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buidTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 30.0, top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10.0),
          Text(
            'Events',
            style: AppTheme.of(context)
                .header
                .copyWith(fontSize: 30.0, color: Colors.blue),
          ),
          const SizedBox(height: 5.0),
        ],
      ),
    );
  }

  Widget _buildListEvent(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: _events.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final item = _events.elementAt(index);
        return Column(
          children: [
            if (index != 0)
              const Divider(
                  color: AppColors.textGrey1,
                  thickness: 1,
                  height: 0,
                  indent: 10,
                  endIndent: 10),
            _buildItem(context, item)
          ],
        );
      },
    );
  }

  Widget _buildItem(BuildContext context, Event data) {
    return InkWell(
      onTap: () {
        Get.to(
          () => EventDetailScreen(
            event: data,
          ),
        );
      },
      child: OneCard(
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
                    'Name: ',
                    style: AppTheme.of(context)
                        .textFieldText
                        .copyWith(color: AppColors.textBrand),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    data.name,
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
                    data.expectedDate,
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
                    data.status.toString(),
                    style: AppTheme.of(context)
                        .textFieldText
                        .copyWith(color: AppColors.textBrand),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(height: 1.0, color: AppColors.dividerGrey),
          ],
        ),
      ),
    );
  }

  Widget _buildGetDataSuccess(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      bloc: Get.find<HomeCubit>(),
      listener: (context, state) async {
        if (state is ListEventInProgress) {
          EasyLoading.show(status: 'Loading...');
          return;
        }

        EasyLoading.dismiss();

        if (state is ListEventFailure) {
          Get.snackbar("Error", state.error.toString());
          return;
        }

        if (state is ListEventSuccess) {
          final response = state.dataResponse;
          if (response!.error_code == ResponseStatus.success) {
            setState(() {
              _events = response.data;
            });
          } else {
            Get.snackbar("Error", response.message.toString());
          }
        }
      },
      builder: (context, state) {
        return Container();
      },
    );
  }
}
