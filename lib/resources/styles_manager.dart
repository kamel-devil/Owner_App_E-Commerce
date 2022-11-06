
import 'package:flutter/material.dart';

import 'font_manager.dart';





TextStyle _getTextStyle(double fontsize,FontWeight fontWeight,Color color){
  return TextStyle(fontWeight: fontWeight,fontSize: fontsize,fontFamily: FontConstants.fontFamily,color: color);
}
TextStyle getRegularStyle({double fontsize=FontSize.s12,required Color color}){
  return _getTextStyle(fontsize,FontWeightManager.Regular,color);
}
TextStyle getMediumStyle({double fontsize=FontSize.s14,required Color color}){
  return _getTextStyle(fontsize,FontWeightManager.Medium,color);
}
TextStyle getLightStyle({double fontsize=FontSize.s14,required Color color}){
  return _getTextStyle(fontsize,FontWeightManager.Light,color);
}
TextStyle getBoldStyle({double fontsize=FontSize.s14,required Color color}){
  return _getTextStyle(fontsize,FontWeightManager.Bold,color);
}
TextStyle getSemiBoldStyle({double fontsize=FontSize.s14,required Color color}){
  return _getTextStyle(fontsize,FontWeightManager.SemiBold,color);
}