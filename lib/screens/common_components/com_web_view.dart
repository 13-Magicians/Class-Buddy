import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OpenExternalLink extends StatefulWidget {
  final String getName, getLink;

  const OpenExternalLink(this.getName, this.getLink);

  @override
  State<OpenExternalLink> createState() => _OpenExternalLinkState();
}

class _OpenExternalLinkState extends State<OpenExternalLink> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.deepOrange.shade200)
      ..canGoBack()
      ..enableZoom(true)
      ..goBack()
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            CircularProgressIndicator();
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              // return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
    // ..loadRequest(Uri.parse('https://drive.google.com/file/d/1kS7wkXMaZnaK-vURXWDDyhUM7yvIWAWR/view?usp=sharing'));
      ..loadRequest(Uri.parse(widget.getLink));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.getName),surfaceTintColor: Colors.deepOrange,backgroundColor: Colors.deepOrange.shade300,),
      body: WebViewWidget(controller: controller,),
    );
  }
}

void externalLink(
    BuildContext context, String getName, String getLink) {
  Navigator.of(context).push(MaterialPageRoute<void>(
    fullscreenDialog: true,
    builder: (BuildContext context) {
      return OpenExternalLink(getName, getLink);
    },
  ));
}
