import 'package:flutter/material.dart';
import 'package:milkman/core/theme/extensions/text_ext.dart';
import 'package:milkman/features/milk/presentation/widgets/custom_appbar.dart';
import 'package:milkman/features/milk/presentation/widgets/promo_card_background.dart';

class MilkOrderPage extends StatefulWidget {
  const MilkOrderPage({super.key});

  @override
  State<MilkOrderPage> createState() => _MilkOrderPageState();
}

class _MilkOrderPageState extends State<MilkOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        userName: 'Alex Johnson',
        location: 'Green Valley, NY',
        hasNotification: true,
        onNotificationTap: () {
          print('Notification tapped!');
        },
      ),

      body: PromoCardBackground(),
    );
  }
}
