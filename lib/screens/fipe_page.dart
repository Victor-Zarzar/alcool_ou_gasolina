import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:alcool_ou_gasolina/features/app_theme.dart';
import 'package:alcool_ou_gasolina/features/theme_provider.dart';
import 'package:alcool_ou_gasolina/services/fipe_service.dart';
import 'package:provider/provider.dart';

class FipePage extends StatefulWidget {
  const FipePage({super.key});

  @override
  State<FipePage> createState() => _FipePageState();
}

class _FipePageState extends State<FipePage> {
  final _fipeService = FipeService();
  String resultText = '';

  final _vehicleTypes = ['carros', 'motos', 'caminhoes'];

  String? _selectedType;
  String? _selectedBrand;
  String? _selectedModel;
  String? _selectedYear;

  List<dynamic> _brands = [];
  List<dynamic> _models = [];
  List<dynamic> _years = [];

  Map<String, dynamic>? _fipeResult;
  bool _isLoading = false;

  Future<void> _fetchBrands(String type) async {
    try {
      setState(() {
        _resetSelections();
      });
      final brands = await _fipeService.fetchBrands(type);
      setState(() {
        _brands = brands;
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _fetchModels(String type, String brandCode) async {
    try {
      setState(() {
        _models = [];
        _years = [];
        _selectedModel = null;
        _selectedYear = null;
        _fipeResult = null;
      });
      final models = await _fipeService.fetchModels(type, brandCode);
      setState(() {
        _models = models;
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _fetchYears(
    String type,
    String brandCode,
    String modelCode,
  ) async {
    try {
      setState(() {
        _years = [];
        _selectedYear = null;
        _fipeResult = null;
      });
      final years = await _fipeService.fetchYears(type, brandCode, modelCode);
      setState(() {
        _years = years;
      });
    } catch (e) {
      _showError(e.toString());
    }
  }

  Future<void> _fetchDetails(
    String type,
    String brandCode,
    String modelCode,
    String yearCode,
  ) async {
    try {
      setState(() {
        _isLoading = true;
        _fipeResult = null;
      });
      final details = await _fipeService.fetchDetails(
        type,
        brandCode,
        modelCode,
        yearCode,
      );
      setState(() {
        _fipeResult = details;
        resultText =
            '${'value_label'.tr()}: ${_fipeResult!['Valor']}, ${'brand_label'.tr()}: ${_fipeResult!['Marca']}, ${'model_label'.tr()}: ${_fipeResult!['Modelo']}, ${'year_label'.tr()}: ${_fipeResult!['AnoModelo']}';
      });
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _resetSelections() {
    _brands = [];
    _models = [];
    _years = [];
    _selectedBrand = null;
    _selectedModel = null;
    _selectedYear = null;
    _fipeResult = null;
  }

  void _showError(String message) {
    showDialog(
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
                message,
                style: GoogleFonts.jetBrainsMono(
                  textStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color:
                        notifier.isDark
                            ? TextColor.secondaryColor
                            : TextColor.primaryColor,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK'.tr(),
                    style: GoogleFonts.jetBrainsMono(
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color:
                            notifier.isDark
                                ? TextColor.secondaryColor
                                : TextColor.primaryColor,
                      ),
                    ),
                  ),
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
        return Scaffold(
          backgroundColor:
              notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
          appBar: GFAppBar(
            centerTitle: true,
            title: Text(
              'fipetable'.tr(),
              style: GoogleFonts.jetBrainsMono(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color:
                      notifier.isDark
                          ? TextColor.secondaryColor
                          : TextColor.primaryColor,
                ),
              ),
            ),
            backgroundColor:
                notifier.isDark ? AppTheme.thirdColor : AppTheme.primaryColor,
            automaticallyImplyLeading: false,
          ),
          body: SizedBox(
            height: myHeight,
            width: myWidth,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    SizedBox(
                      width: 300,
                      child: Text(
                        'infofipe'.tr(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.jetBrainsMono(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color:
                                notifier.isDark
                                    ? TextColor.secondaryColor
                                    : TextColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Image.asset(
                      "assets/carfipe.png",
                      height: 180,
                      width: 230,
                      semanticLabel: 'dashboard'.tr(),
                    ),
                    Container(
                      width: 160,
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              notifier.isDark
                                  ? FormColor.secondaryColor
                                  : FormColor.primaryColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(2),
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(8),
                        isExpanded: true,
                        hint: Text(
                          'select_type'.tr(),
                          style: GoogleFonts.jetBrainsMono(
                            textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontWeight: FontWeight.bold,
                              color:
                                  notifier.isDark
                                      ? TextColor.secondaryColor
                                      : TextColor.primaryColor,
                            ),
                          ),
                        ),
                        dropdownColor:
                            notifier.isDark
                                ? ButtonColor.thirdColor
                                : ButtonColor.primaryColor,
                        value: _selectedType,
                        underline: const SizedBox.shrink(),
                        items:
                            _vehicleTypes.map((type) {
                              IconData icon;
                              Color iconColor =
                                  notifier.isDark
                                      ? IconColor.thirdColor
                                      : IconColor.primaryColor;
                              switch (type) {
                                case 'carros':
                                  icon = Icons.directions_car;
                                  break;
                                case 'motos':
                                  icon = Icons.motorcycle;
                                  break;
                                case 'caminhoes':
                                  icon = Icons.local_shipping;
                                  break;
                                default:
                                  icon = Icons.device_unknown;
                              }
                              return DropdownMenuItem(
                                value: type,
                                child: Row(
                                  children: [
                                    Icon(icon, color: iconColor),
                                    const SizedBox(width: 8),
                                    Text(
                                      type.toUpperCase(),
                                      style: GoogleFonts.jetBrainsMono(
                                        textStyle: TextStyle(
                                          fontSize:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              notifier.isDark
                                                  ? TextColor.secondaryColor
                                                  : TextColor.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _selectedType = value);
                            _fetchBrands(value);
                          }
                        },
                      ),
                    ),
                    if (_brands.isNotEmpty)
                      Container(
                        width: 170,
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                notifier.isDark
                                    ? FormColor.secondaryColor
                                    : FormColor.primaryColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(8),
                          isExpanded: true,
                          hint: Text(
                            'select_brand'.tr(),
                            style: GoogleFonts.jetBrainsMono(
                              textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.bold,
                                color:
                                    notifier.isDark
                                        ? TextColor.secondaryColor
                                        : TextColor.primaryColor,
                              ),
                            ),
                          ),
                          dropdownColor:
                              notifier.isDark
                                  ? ButtonColor.thirdColor
                                  : ButtonColor.primaryColor,
                          value: _selectedBrand,
                          underline: const SizedBox.shrink(),
                          items:
                              _brands.map<DropdownMenuItem<String>>((brand) {
                                return DropdownMenuItem<String>(
                                  value: brand['codigo'] as String,
                                  child: Text(
                                    brand['nome'] as String,
                                    style: GoogleFonts.jetBrainsMono(
                                      textStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.03,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            notifier.isDark
                                                ? TextColor.secondaryColor
                                                : TextColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedBrand = value);
                              _fetchModels(_selectedType!, value);
                            }
                          },
                        ),
                      ),
                    if (_models.isNotEmpty)
                      Container(
                        width: 350,
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                notifier.isDark
                                    ? FormColor.secondaryColor
                                    : FormColor.primaryColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(8),
                          isExpanded: true,
                          hint: Text(
                            'select_model'.tr(),
                            style: GoogleFonts.jetBrainsMono(
                              textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.bold,
                                color:
                                    notifier.isDark
                                        ? TextColor.secondaryColor
                                        : TextColor.primaryColor,
                              ),
                            ),
                          ),
                          dropdownColor:
                              notifier.isDark
                                  ? ButtonColor.thirdColor
                                  : ButtonColor.primaryColor,
                          value: _selectedModel,
                          underline: const SizedBox.shrink(),
                          items:
                              _models.map<DropdownMenuItem<String>>((model) {
                                return DropdownMenuItem<String>(
                                  value: model['codigo'].toString(),
                                  child: Text(
                                    model['nome'] as String,
                                    style: GoogleFonts.jetBrainsMono(
                                      textStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.03,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            notifier.isDark
                                                ? TextColor.secondaryColor
                                                : TextColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedModel = value);
                              _fetchYears(
                                _selectedType!,
                                _selectedBrand!,
                                value,
                              );
                            }
                          },
                        ),
                      ),
                    if (_years.isNotEmpty)
                      Container(
                        width: 150,
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                notifier.isDark
                                    ? FormColor.secondaryColor
                                    : FormColor.primaryColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: DropdownButton<String>(
                          borderRadius: BorderRadius.circular(8),
                          isExpanded: true,
                          hint: Text(
                            'select_the_year'.tr(),
                            style: GoogleFonts.jetBrainsMono(
                              textStyle: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                fontWeight: FontWeight.bold,
                                color:
                                    notifier.isDark
                                        ? TextColor.secondaryColor
                                        : TextColor.primaryColor,
                              ),
                            ),
                          ),
                          dropdownColor:
                              notifier.isDark
                                  ? ButtonColor.thirdColor
                                  : ButtonColor.primaryColor,
                          value: _selectedYear,
                          underline: const SizedBox.shrink(),
                          items:
                              _years.map<DropdownMenuItem<String>>((year) {
                                return DropdownMenuItem<String>(
                                  value: year['codigo'] as String,
                                  child: Text(
                                    year['nome'] as String,
                                    style: GoogleFonts.jetBrainsMono(
                                      textStyle: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                            0.03,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            notifier.isDark
                                                ? TextColor.secondaryColor
                                                : TextColor.primaryColor,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _selectedYear = value);
                              _fetchDetails(
                                _selectedType!,
                                _selectedBrand!,
                                _selectedModel!,
                                value,
                              );
                            }
                          },
                        ),
                      ),
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else if (_fipeResult != null)
                      SizedBox(
                        width: 300,
                        child: Text(
                          resultText,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.jetBrainsMono(
                            textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.03,
                              fontWeight: FontWeight.bold,
                              color:
                                  notifier.isDark
                                      ? TextColor.secondaryColor
                                      : TextColor.primaryColor,
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
