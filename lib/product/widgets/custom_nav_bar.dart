import 'package:flutter/material.dart';
import 'package:chillflix_app/product/constants/color_constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.10,
      decoration: BoxDecoration(
        color: ColorConstants.blackColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 0.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            _buildNavItem(
              context: context,
              icon: Icons.home,
              label: 'Ana Sayfa',
              index: 0,
              size: size,
            ),
            _buildNavItem(
              context: context,
              icon: Icons.search,
              label: 'Keşfet',
              index: 1,
              size: size,
            ),
            _buildNavItem(
              context: context,
              icon: Icons.person,
              label: 'Profil',
              index: 2,
              size: size,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required Size size,
  }) {
    final bool isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        splashColor: Colors.white.withOpacity(0.1),
        highlightColor: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02,
            vertical: size.height * 0.008,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? ColorConstants.whiteColor : Colors.grey,
                size: size.width * 0.06,
              ),
              SizedBox(height: size.height * 0.004),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? ColorConstants.whiteColor : Colors.grey,
                  fontSize: size.width * 0.03,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
