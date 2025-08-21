import 'package:flutter/material.dart';
import 'package:my_portfolio_app/constants/app_colors.dart';
import 'package:my_portfolio_app/presentation/web/widgets/header_desktop.dart';

class HeaderMobile extends StatelessWidget {
  const HeaderMobile({super.key, this.onMenuTap, this.onLogoTap});

  final VoidCallback? onMenuTap;
  final VoidCallback? onLogoTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(40, 5, 20, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient(
          colors: [Colors.transparent, AppColors.primaryColor],
        ),
      ),
      child: Row(
        children: [
          SiteLogo(onTap: onLogoTap),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(onPressed: onMenuTap, icon: Icon(Icons.menu)),
          ),
        ],
      ),
    );
  }
}
