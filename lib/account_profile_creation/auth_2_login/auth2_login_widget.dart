// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:picts_manager/auth/firebase_auth/firebase_auth_manager.dart';
import 'package:uni_links/uni_links.dart';

import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'auth2_login_model.dart';
export 'auth2_login_model.dart';

class Auth2LoginWidget extends StatefulWidget {
  const Auth2LoginWidget({super.key});

  @override
  State<Auth2LoginWidget> createState() => _Auth2LoginWidgetState();
}

class _Auth2LoginWidgetState extends State<Auth2LoginWidget>
    with TickerProviderStateMixin {
  late Auth2LoginModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: const Offset(0.0, 140.0),
          end: const Offset(0.0, 0.0),
        ),
        ScaleEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: const Offset(0.9, 0.9),
          end: const Offset(1.0, 1.0),
        ),
        TiltEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 300.ms,
          begin: const Offset(-0.349, 0),
          end: const Offset(0, 0),
        ),
      ],
    ),
  };

  Future<void> initUniLinks() async {
    linkStream.listen((String? link) {
      // Extract authentication code from the link and use it to continue the auth process
    }, onError: (err) {
      // Handle error
    });
  }

  @override
  void initState() {
    super.initState();
    initUniLinks();
    _model = createModel(context, () => Auth2LoginModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                FlutterFlowTheme.of(context).primary,
                FlutterFlowTheme.of(context).tertiary
              ],
              stops: const [0.0, 1.0],
              begin: const AlignmentDirectional(0.87, -1.0),
              end: const AlignmentDirectional(-0.87, 1.0),
            ),
          ),
          alignment: const AlignmentDirectional(0.0, -1.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0, 70.0, 0.0, 32.0),
                  child: Container(
                    width: 200.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 12.0, 0.0),
                          child: Icon(
                            Icons.flourescent_rounded,
                            color: FlutterFlowTheme.of(context).info,
                            size: 44.0,
                          ),
                        ),
                        Text(
                          'flow.io',
                          style: FlutterFlowTheme.of(context)
                              .displaySmall
                              .override(
                                fontFamily: 'Outfit',
                                color: FlutterFlowTheme.of(context).info,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      maxWidth: 570.0,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4.0,
                          color: Color(0x33000000),
                          offset: Offset(0.0, 2.0),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context).displaySmall,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 8.0, 0.0, 24.0),
                              child: Text(
                                'Fill out the information below in order to access your account.',
                                textAlign: TextAlign.start,
                                style: FlutterFlowTheme.of(context).labelLarge,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 16.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  print("hello");
                                  // Trigger the authentication flow
                                  final GoogleSignInAccount? googleUser =
                                      await GoogleSignIn().signIn();
                                  if (googleUser == null) {
                                    return;
                                  }

                                  // Obtain the auth details from the request
                                  final GoogleSignInAuthentication googleAuth =
                                      await googleUser.authentication;

                                  // Create a new credential
                                  final credential =
                                      GoogleAuthProvider.credential(
                                    accessToken: googleAuth.accessToken,
                                    idToken: googleAuth.idToken,
                                  );

                                  // Once signed in, return the UserCredential
                                  UserCredential userCred = await FirebaseAuth
                                      .instance
                                      .signInWithCredential(credential);
                                  print("http://10.101.52.242:8080/login");
                                  log(googleAuth.idToken ?? "null");
                                  print(
                                      "http://10.101.52.242:8080/login?token_id=${googleAuth.idToken}&google_id=${googleUser.id}&email=${googleUser.email}&name=${googleUser.displayName}&picture=${googleUser.photoUrl}");
                                  final res = await Dio()
                                      .post(
                                    "http://10.101.52.242:8080/login?token_id=${googleAuth.idToken}&google_id=${googleUser.id}&email=${googleUser.email}&name=${googleUser.displayName}&picture=${googleUser.photoUrl}",
                                    options: Options(
                                      headers: {
                                        "Content-Type": "application/json",
                                        "accept": "application/json",
                                      },
                                    ),
                                  )
                                      .onError(
                                          (DioError error, stackTrace) async {
                                    return Response(
                                      requestOptions: RequestOptions(path: ''),
                                      statusCode:
                                          error.response?.statusCode ?? 0,
                                      data: error.response?.data ?? {},
                                    );
                                  });
                                  log(res.data);
                                  final resJson = json.decode(
                                      "{${res.data.toString().replaceAll("user:", "'user':").replaceAll("'", "\"")}}");
                                  print(resJson);
                                  if (resJson['user']['id'] != null) {
                                    const FlutterSecureStorage().write(
                                        key: "userId",
                                        value:
                                            resJson['user']['id'].toString());
                                    const FlutterSecureStorage().write(
                                        key: "username",
                                        value: resJson['user']['username']
                                            .toString());
                                    const FlutterSecureStorage().write(
                                        key: "email",
                                        value: resJson['user']['email']
                                            .toString());
                                    const FlutterSecureStorage().write(
                                        key: "picture",
                                        value: resJson['user']['picture']
                                            .toString());
                                    context.pushNamedAuth(
                                      'gallery',
                                      context.mounted,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Sign in failed',
                                        ),
                                      ),
                                    );
                                  }
                                },
                                text: 'Continue with Google',
                                icon: const FaIcon(
                                  FontAwesomeIcons.google,
                                  size: 20.0,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 44.0,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                  hoverColor: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation']!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
