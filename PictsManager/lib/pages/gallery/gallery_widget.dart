// ignore_for_file: use_build_context_synchronously

import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/imagename_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'gallery_model.dart';
export 'gallery_model.dart';

class GalleryWidget extends StatefulWidget {
  const GalleryWidget({super.key});

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late GalleryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GalleryModel());
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String? name = await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              enableDrag: false,
              context: context,
              builder: (context) {
                return GestureDetector(
                  onTap: () => _model.unfocusNode.canRequestFocus
                      ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                      : FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: const ImagenameWidget(),
                  ),
                );
              },
            );
            if (name == null) return;
            _model.apiResult32b = await UploadNewLibraryCall.call(
              token: 'token',
              name: name,
            );
            if ((_model.apiResult32b?.succeeded ?? true)) {
              await showDialog(
                context: context,
                builder: (alertDialogContext) {
                  return AlertDialog(
                    title: const Text('Uploaded'),
                    content: const Text('New library created'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(alertDialogContext),
                        child: const Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            } else {
              await showDialog(
                context: context,
                builder: (alertDialogContext) {
                  return AlertDialog(
                    title: const Text('Error'),
                    content: Text('Unable to create library: $name'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(alertDialogContext),
                        child: const Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            }

            setState(() {});
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          elevation: 8.0,
          child: Icon(
            Icons.add,
            color: FlutterFlowTheme.of(context).info,
            size: 24.0,
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: Text(
              'Gallery',
              style: FlutterFlowTheme.of(context).headlineLarge.override(
                    fontFamily: 'Outfit',
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
            ),
          ),
          actions: [
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
              child: FlutterFlowIconButton(
                borderRadius: 20.0,
                buttonSize: 40.0,
                icon: Icon(
                  Icons.settings,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  context.pushNamed('auth_2_Profile');
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: const AlignmentDirectional(0.0, -1.0),
            child: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: GetLibrariesCall.call(),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          final wrapGetLibrariesResponse = snapshot.data!;
                          return Builder(
                            builder: (context) {
                              final list = [
                                LibraryStruct(
                                  name: 'Library 1',
                                  id: 1,
                                  imageIds: [
                                    1,
                                    2,
                                    3,
                                  ],
                                ),
                                LibraryStruct(
                                    name: 'Library 2',
                                    id: 2,
                                    imageIds: [
                                      4,
                                      5,
                                      6,
                                      7,
                                      8,
                                    ]),
                                LibraryStruct(
                                  name: 'Library 3',
                                  id: 3,
                                  imageIds: [
                                    9,
                                    10,
                                    11,
                                    12,
                                    13,
                                  ],
                                ),
                                LibraryStruct(
                                  name: 'Library 4',
                                  id: 4,
                                  imageIds: [
                                    14,
                                    15,
                                    16,
                                    17,
                                    18,
                                  ],
                                ),
                              ];
                              // (wrapGetLibrariesResponse.jsonBody
                              //             .toList()
                              //             .map<LibraryStruct?>(
                              //                 LibraryStruct.maybeFromMap)
                              //             .toList() as Iterable<LibraryStruct?>)
                              //         .withoutNulls
                              //         ?.toList() ??
                              //     [];
                              return Wrap(
                                spacing: 0.0,
                                runSpacing: 0.0,
                                alignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                direction: Axis.horizontal,
                                runAlignment: WrapAlignment.start,
                                verticalDirection: VerticalDirection.down,
                                clipBehavior: Clip.none,
                                children:
                                    List.generate(list.length, (listIndex) {
                                  final listItem = list[listIndex];
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            8.0, 8.0, 8.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.pushNamed(
                                          'ImageGallery',
                                          queryParameters: {
                                            'imageIds': serializeParam(
                                              listItem.imageIds,
                                              ParamType.int,
                                              true,
                                            ),
                                            'name': serializeParam(
                                              listItem.name,
                                              ParamType.String,
                                            ),
                                            'libraryId': serializeParam(
                                              listItem.id,
                                              ParamType.int,
                                            ),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Container(
                                        width: 150.0,
                                        height: 150.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(12.0, 12.0, 12.0, 12.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.folder,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                size: 48.0,
                                              ),
                                              Text(
                                                listItem.name,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Readex Pro',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
