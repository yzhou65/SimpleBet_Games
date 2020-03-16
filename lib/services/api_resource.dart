import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

typedef Widget SuccessWidget(dynamic data);

class ApiResource {
  static final ApiResource shared = ApiResource._privateConstructor();
  ApiResource._privateConstructor();

  FutureBuilder buildFuture(String endpoint,
      SuccessWidget successWidget,
      {Widget loadingWidget = const GlowingOverscrollIndicator(axisDirection: AxisDirection.right, color: Colors.red)}
    ) {
    Dio dio = new Dio();
    return FutureBuilder(
        future: dio.get(endpoint),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return successWidget(response.data);
          }
          return loadingWidget;
        }
    );
  }
}