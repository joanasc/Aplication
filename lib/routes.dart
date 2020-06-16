//RUTAS 
import 'package:BerlopAdministrador/cliente/mainC.dart';
import 'package:BerlopAdministrador/pages/forgotPassword.dart';
import 'package:BerlopAdministrador/pages/login.dart';
import 'package:BerlopAdministrador/pages/mainTabs.dart';
import 'package:BerlopAdministrador/pages/welcome.dart';
import 'package:BerlopAdministrador/productos/ProductosCM/productosCM.dart';
import 'package:BerlopAdministrador/productos/ProductosSM/ui/listview_product.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> buildAppRoutes() {
  return {
    '/login': (BuildContext context) => LoginPage(),
    '/cliente': (BuildContext context) => HomePageMain(),
    '/forgotpassword': (BuildContext context) => ForgotPasswordPage(),
    '/maintabs': (BuildContext context ) => MainTabsPage(),
    '/welcome': (BuildContext context ) => WelcomePage(),
    '/productossm': (BuildContext context ) => ListViewProduct(),
    '/productoscm': (BuildContext context ) => ProductosCM(),
  };
}