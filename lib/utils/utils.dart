import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchScan(BuildContext context, ScanModel scan) async {
  final url = scan.valor;
  final dir = Uri.parse(scan.valor);

  // 'https://fernando.herrera.com' as Uri;

  if (scan.tipo == 'http') {
    //Abrir sitio web
    await launchUrl(
        dir); //lanzamos la aplicacion directamente, porque marca error al verificar la app que puede abrir la url
    // if (await canLaunchUrl(dir)) {
    //   await launchUrl(dir);
    // } else {
    //   throw 'Could not launch $url';
    // }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
