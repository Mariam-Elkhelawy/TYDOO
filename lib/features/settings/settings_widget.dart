import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/utils/app_colors.dart';
import 'package:todo_app/core/utils/app_images.dart';
import 'package:todo_app/core/utils/styles.dart';
import 'package:todo_app/providers/my_provider.dart';

class SettingsWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String? hint;
  final bool isHint;
  final bool isDropMenu;
  final List<String>? dropDownItems;
  final void Function(String?)? onDropDownChanged;
  final void Function()? onTap;

  const SettingsWidget({
    super.key,
    required this.iconPath,
    required this.title,
    this.hint,
    this.isHint = false,
    this.isDropMenu = false,
    this.dropDownItems,
    this.onDropDownChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h, left: 24.w, right: 24.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: AppColor.whiteColor,
          boxShadow: [
            BoxShadow(
                color: AppColor.shadowColor.withOpacity(.08),
                offset: const Offset(0, 0),
                blurRadius: 20.r,
                spreadRadius: 0),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Container(
                width: 8.w,
                height: isHint ? 63.h : 52.h,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: provider.languageCode == 'en'
                        ? Radius.circular(12.r)
                        : Radius.circular(0.r),
                    bottomLeft: provider.languageCode == 'en'
                        ? Radius.circular(12.r)
                        : Radius.circular(0.r),
                    bottomRight: provider.languageCode == 'en'
                        ? Radius.circular(0.r)
                        : Radius.circular(12.r),
                    topRight: provider.languageCode == 'en'
                        ? Radius.circular(0.r)
                        : Radius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              SvgPicture.asset(
                iconPath,
                colorFilter:
                    ColorFilter.mode(AppColor.colorPalette[4], BlendMode.srcIn),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: isDropMenu
                    ? CustomDropdown<String>(
                        closedHeaderPadding: EdgeInsets.zero,
                        items: dropDownItems ?? [],
                        hintText: title,
                        onChanged: onDropDownChanged,
                        decoration: CustomDropdownDecoration(
                          closedSuffixIcon:
                              SvgPicture.asset(AppImages.arrowDown),
                          expandedSuffixIcon:
                              SvgPicture.asset(AppImages.arrowTop),
                          headerStyle: AppStyles.bodyM,
                          listItemStyle: AppStyles.bodyM,
                          hintStyle: AppStyles.settingTitle,
                          expandedBorder:
                              Border.all(color: AppColor.primaryColor),
                          closedFillColor: provider.themeMode == ThemeMode.dark
                              ? AppColor.blackColor
                              : AppColor.whiteColor,
                          expandedFillColor:
                              provider.themeMode == ThemeMode.dark
                                  ? AppColor.blackColor
                                  : AppColor.whiteColor,
                        ),
                        initialItem: hint,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppStyles.settingTitle,
                          ),
                          if (isHint)
                            Text(
                              hint!,
                              style: AppStyles.hintText.copyWith(
                                fontSize: 14.sp,
                                color: AppColor.hintColor,
                              ),
                            ),
                        ],
                      ),
              ),
              if (!isDropMenu) SvgPicture.asset(AppImages.arrowSquare),
              SizedBox(
                width: 18.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}
