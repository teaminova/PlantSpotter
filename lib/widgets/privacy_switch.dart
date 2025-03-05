import 'package:flutter/material.dart';

class PrivacySwitch extends StatelessWidget {
  final bool isPublic;
  final Function(bool) togglePrivacy;

  const PrivacySwitch({
    required this.isPublic,
    required this.togglePrivacy,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "PRIVATE",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF6B8E58)),
          ),
          const SizedBox(width: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 50,
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isPublic ? Color(0xFF6B8E58) : Colors.black12,
            ),
            child: Stack(
              alignment: isPublic ? Alignment.centerRight : Alignment.centerLeft,
              children: [
                Positioned(
                  left: isPublic ? 25 : 3,
                  child: GestureDetector(
                    onTap: () => togglePrivacy(!isPublic),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 3,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            "PUBLIC",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF6B8E58)),
          ),
        ],
      ),
    );
  }
}
