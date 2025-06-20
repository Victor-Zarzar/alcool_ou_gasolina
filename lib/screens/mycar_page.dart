import 'package:alcool_ou_gasolina/features/app_assets.dart';
import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/responsive_extesion.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/theme_provider.dart';

class MyCarPage extends StatefulWidget {
  const MyCarPage({super.key});

  @override
  State<MyCarPage> createState() => _MyCarPageState();
}

class _MyCarPageState extends State<MyCarPage> {
  late final TextEditingController _plateController = TextEditingController();
  late final TextEditingController _modelController = TextEditingController();
  late final TextEditingController _yearController = TextEditingController();
  late final TextEditingController _consumptionController =
      TextEditingController();
  final _yearFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _loadCarInfo();
  }

  Future<void> _loadCarInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _plateController.text = prefs.getString('plate') ?? '';
      _modelController.text = prefs.getString('model') ?? '';
      _yearController.text = prefs.getInt('year')?.toString() ?? '';
      _consumptionController.text = prefs.getString('consumption') ?? '';
    });
  }

  Future<void> _saveCarInfo(BuildContext context) async {
    if (_plateController.text.isEmpty ||
        _modelController.text.isEmpty ||
        _yearController.text.isEmpty ||
        _consumptionController.text.isEmpty) {
      _showValidationErrorDialog();
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('plate', _plateController.text);
    await prefs.setString('model', _modelController.text);
    await prefs.setInt('year', int.tryParse(_yearController.text) ?? 0);
    await prefs.setString('consumption', _consumptionController.text);
    await _showSaveConfirmationDialog();
  }

  Future<void> _showValidationErrorDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<UiProvider>(
          builder: (context, notifier, child) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color:
                      notifier.isDark
                          ? AppTheme.primaryColor
                          : AppTheme.thirdColor,
                  width: 2,
                ),
              ),
              backgroundColor:
                  notifier.isDark
                      ? AlertDialogColor.primaryColor
                      : AlertDialogColor.secondaryColor,
              content: Text(
                'pleasefillinallfields'.tr(),
                style: context.bodySmallDialog,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK', style: context.bodySmallDialog),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showSaveConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<UiProvider>(
          builder: (context, notifier, child) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color:
                      notifier.isDark
                          ? AppTheme.primaryColor
                          : AppTheme.thirdColor,
                  width: 2,
                ),
              ),
              backgroundColor:
                  notifier.isDark
                      ? AlertDialogColor.primaryColor
                      : AlertDialogColor.secondaryColor,
              content: Text(
                'datasavedsuccessfully'.tr(),
                style: context.bodySmallDialog,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK', style: context.bodySmallDialog),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _deleteCarInfo(BuildContext context) async {
    if (_plateController.text.isEmpty &&
        _modelController.text.isEmpty &&
        _yearController.text.isEmpty &&
        _consumptionController.text.isEmpty) {
      _showNoDataToDeleteDialog();
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('plate');
    await prefs.remove('model');
    await prefs.remove('year');
    await prefs.remove('consumption');
    setState(() {
      _plateController.clear();
      _modelController.clear();
      _yearController.clear();
      _consumptionController.clear();
    });
    await _showDeleteConfirmationDialog();
  }

  Future<void> _showNoDataToDeleteDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<UiProvider>(
          builder: (context, notifier, child) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(
                  color:
                      notifier.isDark
                          ? AppTheme.primaryColor
                          : AppTheme.thirdColor,
                  width: 2,
                ),
              ),
              backgroundColor:
                  notifier.isDark
                      ? AlertDialogColor.primaryColor
                      : AlertDialogColor.secondaryColor,
              content: Text(
                'nodatatodelete'.tr(),
                style: context.bodySmallDialog,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK', style: context.bodySmallDialog),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<UiProvider>(
          builder: (context, notifier, child) {
            return AlertDialog(
              backgroundColor:
                  notifier.isDark
                      ? ButtonColor.primaryColor
                      : ButtonColor.secondaryColor,
              content: Text(
                'successfullydeleted'.tr(),
                style: context.bodySmallDialog,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK', style: context.bodySmallDialog),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Consumer<UiProvider>(
      builder: (context, notifier, child) {
        return SizedBox(
          height: myHeight,
          width: myWidth,
          child: Scaffold(
            backgroundColor:
                notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
            appBar: GFAppBar(
              backgroundColor:
                  notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text('mycar'.tr(), style: context.h1),
            ),
            body: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('save'.tr(), style: context.bodyIconButton),
                          const SizedBox(width: 6),
                          GFIconButton(
                            type: GFButtonType.outline2x,
                            tooltip: 'save'.tr(),
                            size: 30,
                            color:
                                notifier.isDark
                                    ? ButtonColor.primaryColor
                                    : ButtonColor.secondaryColor,
                            onPressed: () async {
                              await _saveCarInfo(context);
                            },
                            icon: Icon(
                              Icons.save,
                              color:
                                  notifier.isDark
                                      ? TextColor.secondaryColor
                                      : TextColor.primaryColor,
                              size: 18,
                              semanticLabel: 'save'.tr(),
                            ),
                          ),
                          const SizedBox(width: 15),
                          GFIconButton(
                            type: GFButtonType.outline2x,
                            tooltip: 'delete'.tr(),
                            size: 30,
                            color:
                                notifier.isDark
                                    ? ButtonColor.primaryColor
                                    : ButtonColor.secondaryColor,
                            onPressed: () async {
                              await _deleteCarInfo(context);
                            },
                            icon: Icon(
                              Icons.delete,
                              color:
                                  notifier.isDark
                                      ? TextColor.secondaryColor
                                      : TextColor.primaryColor,
                              size: 18,
                              semanticLabel: 'delete'.tr(),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text('delete'.tr(), style: context.bodyIconButton),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                    Car.asset(),
                    Text("savecar".tr(), style: context.bodySmall),
                    const SizedBox(height: 20),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 180,
                        child: TextField(
                          cursorColor:
                              notifier.isDark
                                  ? FormColor.secondaryColor
                                  : FormColor.primaryColor,
                          controller: _plateController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[A-Za-z0-9]'),
                            ),
                          ],
                          decoration: InputDecoration(
                            labelText: 'plate'.tr(),
                            labelStyle: context.textSmall,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    notifier.isDark
                                        ? FormColor.secondaryColor
                                        : FormColor.primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 50,
                      width: 180,
                      child: TextField(
                        cursorColor:
                            notifier.isDark
                                ? FormColor.secondaryColor
                                : FormColor.primaryColor,
                        controller: _modelController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9]'),
                          ),
                        ],
                        decoration: InputDecoration(
                          labelText: 'carmodel'.tr(),
                          labelStyle: context.textSmall,
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  notifier.isDark
                                      ? FormColor.secondaryColor
                                      : FormColor.primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 50,
                      width: 180,
                      child: TextField(
                        cursorColor:
                            notifier.isDark
                                ? FormColor.secondaryColor
                                : FormColor.primaryColor,
                        controller: _yearController,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        focusNode: _yearFocus,
                        decoration: InputDecoration(
                          labelText: 'year'.tr(),
                          labelStyle: context.textSmall,
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  notifier.isDark
                                      ? FormColor.secondaryColor
                                      : FormColor.primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 50,
                      width: 180,
                      child: TextField(
                        controller: _consumptionController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9]'),
                          ),
                        ],
                        decoration: InputDecoration(
                          labelText: 'lastconsumption'.tr(),
                          labelStyle: context.textSmall,
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                                  notifier.isDark
                                      ? FormColor.secondaryColor
                                      : FormColor.primaryColor,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
