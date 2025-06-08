import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/responsive_text.dart';
import 'package:alcool_ou_gasolina/features/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

extension ResponsiveTextStyle on BuildContext {
  UiProvider get ui => Provider.of<UiProvider>(this, listen: true);

  // Heading Styles

  TextStyle get h1 => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 13),
    fontWeight: FontWeight.w900,
    color: ui.isDark ? TextColor.secondaryColor : TextColor.primaryColor,
  );

  TextStyle get h2 => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 11),
    fontWeight: FontWeight.w500,
    color: ui.isDark ? TextColor.secondaryColor : TextColor.primaryColor,
  );

  //Body Styles

  TextStyle get bodyLarge => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 18),
    color: ui.isDark ? TextColor.secondaryColor : TextColor.primaryColor,
  );

  TextStyle get bodyMedium => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 16),
    color: ui.isDark ? TextColor.secondaryColor : TextColor.primaryColor,
  );

  TextStyle get bodySmall => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 11),
    color: ui.isDark ? TextColor.secondaryColor : TextColor.primaryColor,
  );

  TextStyle get bodySmallBold => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 10),
    fontWeight: FontWeight.bold,
    color: ui.isDark ? TextColor.secondaryColor : TextColor.primaryColor,
  );

  TextStyle get textSmall => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 9),
    color: ui.isDark ? TextColor.secondaryColor : TextColor.primaryColor,
  );

  TextStyle get textSmallBold => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 9),
    fontWeight: FontWeight.bold,
    color: ui.isDark ? TextColor.secondaryColor : TextColor.primaryColor,
  );

  TextStyle get bodySmallDialog => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 11),
    color: ui.isDark ? TextColor.secondaryColor : TextColor.primaryColor,
  );

  TextStyle get bodyIconButton => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 9),
    fontWeight: FontWeight.w600,
    color: ui.isDark ? TextColor.secondaryColor : TextColor.primaryColor,
  );

  TextStyle get bodyMediumFont => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 13),
    fontWeight: FontWeight.w600,
    color: ui.isDark ? TextColor.secondaryColor : TextColor.primaryColor,
  );
}
