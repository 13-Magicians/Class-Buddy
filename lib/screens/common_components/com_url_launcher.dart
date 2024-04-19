


import 'package:flutter/material.dart';
// import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalUrlRedirect extends StatefulWidget {
  const ExternalUrlRedirect({super.key});

  @override
  State<ExternalUrlRedirect> createState() => _ExternalUrlRedirectState();
}

class _ExternalUrlRedirectState extends State<ExternalUrlRedirect> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class ExtraUrlLunch {


  Future elaunchUrl (String url) async {
    final Uri _url = Uri.parse('https://drive.google.com/drive/folders/1lBJbEsueiCo4EKwU_pqcN4Qm5qIFi1D9');
    await launchUrl(_url,mode: LaunchMode.externalApplication,webViewConfiguration: WebViewConfiguration(enableJavaScript: true));

  }








}


