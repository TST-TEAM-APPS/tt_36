import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fraze_pocket/onboarding_view/initial_page.dart';
import 'package:fraze_pocket/service/mixins/network_mixin.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class MoreInfoPage extends StatefulWidget {
  const MoreInfoPage({super.key});

  @override
  State<MoreInfoPage> createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> with NetworkMixin {
  late final WebViewController _controller;

  bool _isLoading = true;

  String get _cssCode {
    return ".docs-ml-promotion, #docs-ml-header-id { display: none !important; } .app-container { margin: 0 !important; }";
  }

  String get _jsCode => """
      var style = document.createElement('style');
      style.type = "text/css";
      style.innerHTML = "$_cssCode";
      document.head.appendChild(style);
    """;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            controller.runJavaScript(_jsCode);

            setState(() => _isLoading = false);
          },
          onWebResourceError: (WebResourceError error) {
            if (error.errorCode == -1009) {
              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(
                  builder: (context) => const InitialScreen(),
                ),
              );
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            if (change.url != null) {
              saveLastVisit(change.url!);
            }
          },
        ),
      );

    if (controller.platform is WebKitWebViewController) {
      (controller.platform as WebKitWebViewController)
          .setAllowsBackForwardNavigationGestures(true);
    }

    _controller = controller;

    final urlToLoad = loadUrl();

    _controller.loadRequest(Uri.parse(urlToLoad));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0xFF17182D),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    const CupertinoActivityIndicator(
                      color: CupertinoColors.white,
                      radius: 15,
                    )
                  ],
                ),
              ),
            )
          : SafeArea(
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
    );
  }
}
