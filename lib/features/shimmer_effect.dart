import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class ShimmerComponent extends StatefulWidget {
  const ShimmerComponent({super.key});

  @override
  State<ShimmerComponent> createState() => _ShimmerComponentState();
}

class _ShimmerComponentState extends State<ShimmerComponent> {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<UiProvider>(context);
    return GFShimmer(
      showShimmerEffect: true,
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Color(0xFF212121), Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 46,
                color:
                    notifier.isDark
                        ? ShimmerColor.primaryColor
                        : ShimmerColor.secondaryColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 8,
                      color:
                          notifier.isDark
                              ? ShimmerColor.primaryColor
                              : ShimmerColor.secondaryColor,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: 8,
                      color:
                          notifier.isDark
                              ? ShimmerColor.primaryColor
                              : ShimmerColor.secondaryColor,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: 8,
                      color:
                          notifier.isDark
                              ? ShimmerColor.primaryColor
                              : ShimmerColor.secondaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
