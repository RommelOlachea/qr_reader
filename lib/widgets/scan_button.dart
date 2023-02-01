import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/scans_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //     '#3DBBEF', 'CANCELAR', false, ScanMode.QR);
        //final barcodeScanRes = 'https://fernando-herrera.com/';

        final barcodeScanRes = 'geo:24.019158,-110.293483';
        if (barcodeScanRes == '-1') {
          return;
        }

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        launchScan(context, nuevoScan);
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
