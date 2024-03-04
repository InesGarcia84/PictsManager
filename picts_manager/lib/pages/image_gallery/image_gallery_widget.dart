import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'image_gallery_model.dart';
export 'image_gallery_model.dart';

class ImageGalleryWidget extends StatefulWidget {
  const ImageGalleryWidget({
    super.key,
    required this.imageIds,
    required this.name,
  });

  final List<int>? imageIds;
  final String? name;

  @override
  State<ImageGalleryWidget> createState() => _ImageGalleryWidgetState();
}

class _ImageGalleryWidgetState extends State<ImageGalleryWidget> {
  late ImageGalleryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ImageGalleryModel());
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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
              },
              text: '',
              icon: Icon(
                Icons.chevron_left,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 30.0,
              ),
              options: FFButtonOptions(
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primaryBackground,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Readex Pro',
                      color: Colors.white,
                    ),
                elevation: 0.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          title: Text(
            valueOrDefault<String>(
              widget.name,
              'NoName',
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  fontSize: 23.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, -1.0),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 30.0, 0.0, 0.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Builder(
                        builder: (context) {
                          final images = widget.imageIds!.toList();
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
                                List.generate(images.length, (imagesIndex) {
                              final imagesItem = images[imagesIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 8.0, 8.0, 0.0),
                                child: FutureBuilder<ApiCallResponse>(
                                  future: GetImagesCall.call(
                                    id: imagesItem,
                                  ),
                                  builder: (context, snapshot) {
                                    // Customize what your widget looks like when it's loading.
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    final containerGetImagesResponse =
                                        snapshot.data!;
                                    return Container(
                                      width: 150.0,
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          'https://picsum.photos/seed/951/600',
                                          width: 300.0,
                                          height: 200.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
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
