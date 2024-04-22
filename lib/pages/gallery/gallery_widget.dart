// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:share_plus/share_plus.dart';
import 'package:tuple/tuple.dart';

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
  bool loading = false;
  bool isEditing = false;
  DateTime date = DateTime.now();
  Map<String, dynamic> data = {};
  int pos = 0;
  final TextEditingController searchController = TextEditingController();
  bool isOpen = false;
  String search = '';

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
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Tuple2<String, bool>? name = await showModalBottomSheet(
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
            if (name.item2) {
              _model.apiResult32b = await UploadNewLibraryCall.call(
                name: name.item1,
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
                      content: Text('Unable to create library: ${name.item1}'),
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
            } else {
              _model.apiResult32b = await LinkLibraryCall.call(
                libraryId: name.item1,
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
                      content: Text('Unable to create library: ${name.item1}'),
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
        appBar: isEditing
            ? AppBar(
                backgroundColor: Colors.white,
                title: SizedBox(
                  width: size.width * 0.6,
                  height: 40,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Rechercher',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                      border: InputBorder.none,
                    ),
                    onSubmitted: (value) async {
                      if (value.isNotEmpty) {
                        setState(() {
                          search = value;
                        });
                      }
                    },
                  ),
                ),
                centerTitle: false,
                elevation: 0,
                leading: IconButton(
                  splashRadius: 1,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      search = '';
                      searchController.text = '';
                      isEditing = false;
                    });
                  },
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
                    child: IconButton(
                      splashRadius: 1,
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () async {
                        if (searchController.text.isEmpty) {
                          setState(() {
                            search = '';
                            searchController.text = '';
                            isEditing = false;
                          });
                        } else {
                          setState(() {
                            search = '';
                            searchController.text = '';
                          });
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              )
            : AppBar(
                backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 16.0, 16.0, 16.0),
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
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 16.0, 0.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderRadius: 20.0,
                      buttonSize: 40.0,
                      icon: Icon(
                        Icons.search_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24.0,
                      ),
                      onPressed: () {
                        setState(() {
                          isEditing = true;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 16.0, 0.0, 0.0),
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
                    if (search != "")
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 0.0,
                            bottom: 8.0,
                            left: 16.0,
                          ),
                          child: Text(
                            'Search folder results: ',
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: 14.0,
                                ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      child: FutureBuilder<ApiCallResponse>(
                        future: (search != "")
                            ? GetLibrariesCall.callSearch(search: search)
                            : GetLibrariesCall.call(),
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
                          print(snapshot.data!.response?.body);
                          if (snapshot.data!.response?.body == "[]") {
                            return Container();
                          }
                          List<Map<String, dynamic>> librariesResponse =
                              (jsonDecode(snapshot.data!.response?.body ?? "")
                                      as List<dynamic>)
                                  .map(
                                    (e) => e as Map<String, dynamic>,
                                  )
                                  .toList();
                          return Builder(
                            builder: (context) {
                              final list = (librariesResponse
                                          .map<LibraryStruct?>(
                                              LibraryStruct.maybeFromMap)
                                          .toList() as Iterable<LibraryStruct?>)
                                      .withoutNulls
                                      ?.toList() ??
                                  [];
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
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons.folder,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  size: 48.0,
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  listItem.name,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Readex Pro',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                      color: Colors.red
                                                          .withOpacity(0.7),
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () async {
                                                        await DeleteLibrary.call(
                                                            libraryId: listItem
                                                                .id
                                                                .toString());
                                                        setState(() {});
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                      color: Colors.blue
                                                          .withOpacity(0.7),
                                                    ),
                                                    child: IconButton(
                                                      onPressed: () async {
                                                        Share.share(
                                                            '${listItem.id}',
                                                            subject:
                                                                "Share this gallery code with the other user");
                                                      },
                                                      icon: Icon(
                                                        Icons.share,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
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
                    if (search != "")
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            bottom: 8.0,
                            left: 16.0,
                          ),
                          child: Text(
                            'Search image results: ',
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: 'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  fontSize: 14.0,
                                ),
                          ),
                        ),
                      ),
                    if (search != "")
                      FutureBuilder<ApiCallResponse>(
                          future: GetImagesCall.callSearch(
                            search: search,
                          ),
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
                            List<Map<String, dynamic>> librariesResponse =
                                (jsonDecode(snapshot.data!.response?.body ?? "")
                                        as List<dynamic>)
                                    .map(
                                      (e) => e as Map<String, dynamic>,
                                    )
                                    .toList();
                            final list = (librariesResponse
                                        .map<ImageStruct?>(
                                            ImageStruct.maybeFromMap)
                                        .toList() as Iterable<ImageStruct?>)
                                    .withoutNulls
                                    ?.toList() ??
                                [];
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      return Wrap(
                                        spacing: 0.0,
                                        runSpacing: 0.0,
                                        alignment: WrapAlignment.start,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        direction: Axis.horizontal,
                                        runAlignment: WrapAlignment.start,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        clipBehavior: Clip.none,
                                        children: List.generate(list.length,
                                            (imagesIndex) {
                                          final imagesItem = list[imagesIndex];
                                          return Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(8.0, 8.0, 8.0, 0.0),
                                            child: Container(
                                              width: 150.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.network(
                                                          imagesItem.image ??
                                                              'https://picsum.photos/seed/951/600',
                                                          width: 200.0,
                                                          height: 200.0,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(8.0,
                                                                8.0, 8.0, 0.0),
                                                        child: Text(
                                                          imagesItem.name ?? '',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                                fontSize: 14.0,
                                                              ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10.0),
                                                        ),
                                                        color: Colors.red
                                                            .withOpacity(0.7),
                                                      ),
                                                      child: IconButton(
                                                        onPressed: () async {
                                                          await DeleteImage.call(
                                                              imageId: imagesItem
                                                                  .id
                                                                  .toString());
                                                          setState(() {});
                                                        },
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }),
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
