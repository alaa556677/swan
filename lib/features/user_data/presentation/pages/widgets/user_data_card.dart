import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/model/user_data_model.dart';
import '../../../domain/entity/user_data_entity.dart';
import 'item_card.dart';

class UserDataCard extends StatefulWidget{
  final UserDataEntityEntity userDataEntityEntity;
  final Tax tax;
  const UserDataCard({super.key, required this.userDataEntityEntity, required this.tax});

  @override
  State<UserDataCard> createState() => _UserDataCardState();
}

class _UserDataCardState extends State<UserDataCard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFE6E6E6),
          borderRadius: BorderRadius.circular(9)
      ),
      padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemForCard(
            text: 'User Name',
            titleData: widget.userDataEntityEntity.userName ?? "",
          ),
          ItemForCard(
            text: 'Email',
            titleData: widget.userDataEntityEntity.email ?? "",
          ),
          ItemForCard(
            text: 'Limit',
            titleData: widget.userDataEntityEntity.limit != null ? widget.userDataEntityEntity.limit.toString() : "",
          ),
          ItemForCard(
            text: 'Mobile Number',
            titleData: widget.userDataEntityEntity.mobile != null ? widget.userDataEntityEntity.mobile.toString() : "",
          ),
          ItemForCard(
            text: 'Room Number',
            titleData: widget.userDataEntityEntity.roomNumber != null ? widget.userDataEntityEntity.roomNumber.toString() : "",
          ),
          ItemForCard(
            text: 'Tax',
            titleData: widget.tax.value != null ? widget.tax.value.toString() : "",
          ),
          ItemForCard(
            text: 'Status',
            titleData: widget.userDataEntityEntity.status != null ? widget.userDataEntityEntity.status.toString() : "",
          ),
        ],
      ),
    );
  }
}

