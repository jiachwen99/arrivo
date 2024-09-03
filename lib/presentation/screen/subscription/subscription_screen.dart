import 'package:arrivo/domain/configure/colors.dart';
import 'package:arrivo/domain/configure/dimens.dart';
import 'package:arrivo/domain/configure/theme.dart';
import 'package:arrivo/domain/model/subscription_details.dart';
import 'package:arrivo/presentation/widget/theme_button.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConfig.white,
      body: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(DimenConfig.horizontal_margin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Subscriptions',
                        style: ThemeService.mediumTextStyle(fontSize: 24),
                      ),
                    )
                  ],
                ),
              ),
              Wrap(
                runSpacing: 10,
                spacing: 24,
                children: [SubscriptionDetails(title: "Basic Package", subTitle: "Powerful essentials", description: "Free access to normal posts\nPosts limits may apply", monthlyCost: 0), SubscriptionDetails(title: "Premium Package", subTitle: "Advanced features", description: "Free access to normal and premium posts\nNo limits may apply", monthlyCost: 100)].asMap().entries.map((e) => _buildSubscriptionPackageWidget(package: e.value, isSubscribedPackage: e.key == 0)).toList(),
              ),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _buildSubscriptionPackageWidget({required SubscriptionDetails package, bool isSubscribedPackage = false}) => Container(
        padding: EdgeInsets.symmetric(horizontal: DimenConfig.getSize(24), vertical: DimenConfig.getSize(40)),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              package.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(package.subTitle, style: ThemeService.regularTextStyle()),
            const SizedBox(height: 10),
            Text("\$ ${package.monthlyCost}/month", style: ThemeService.boldTextStyle()),
            const SizedBox(height: 10),
            Text(package.description, style: ThemeService.regularTextStyle()),
            SizedBox(height: 24),
            isSubscribedPackage
                ? ThemeButton(
                    text: "Your Current Plan",
                    color: ColorConfig.orangeSub,
                    onPressed: () {},
                  )
                : ThemeButton(
                    text: "Subscribe",
                    onPressed: () {},
                  ),
          ],
        ),
      );
}
