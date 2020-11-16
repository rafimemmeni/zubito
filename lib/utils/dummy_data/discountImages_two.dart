import 'package:clippy_flutter/diagonal.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<String> discountImageList = [
  '4.png',
  '6.png',
  '7.png',
  '8.png',
];
Future<Widget> _getImage(String image) async {
  Image m;
  await loadFromStorage(image).then((downloadUrl) {
    m = Image.network(
      downloadUrl.toString(),
      fit: BoxFit.cover,
      width: 400.0,
    );
  });

  return m;
}

Future<dynamic> loadFromStorage(String image) async {
  return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
}

List<Widget> imageSlidersTwo = discountImageList
    .map((item) => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF07128A),
                  blurRadius: 5.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 1)),
            ],
          ),
          margin: EdgeInsets.only(left: 0.5, right: 0.5, top: 16, bottom: 16),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      //color: Colors.red,
                      width: 400,
                      child: FutureBuilder(
                        future: _getImage(item),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              height: MediaQuery.of(context).size.height / 1.25,
                              width: MediaQuery.of(context).size.width / 1.25,
                              child: snapshot.data,
                            );
                          }
                          // if (snapshot.connectionState ==
                          //     ConnectionState.waiting)
                          //   return Container(
                          //       height:
                          //           MediaQuery.of(context).size.height /
                          //               1.25,
                          //       width:
                          //           MediaQuery.of(context).size.width /
                          //               1.25,
                          //       child: CircularProgressIndicator());

                          return Container();
                        },
                      ),
                      // Image.network(item, fit: BoxFit.cover, width: 1000)
                      // child: Image.asset(item,
                      //     fit: BoxFit.cover, width: 320.0))),
                    ),
                  )
//                   Align(
//                     alignment: Alignment.centerLeft,
// //                    child:Point(
// //                      triangleHeight: 70.0,
// //                      edge: Edge.RIGHT,
// //                      child: Container(
// //                        color: Colors.white,
// //                        width: 225.0,
// //                        height: 175.0,
// //                        padding: EdgeInsets.only(left: 16, top: 54, right: 72),
// //                        child: Text(
// //                          "Kadın kıyafetlerinde bu aya degil bu yıla özel fırsatlar",
// //                          overflow: TextOverflow.ellipsis,
// //                          maxLines: 5,
// //                          style: GoogleFonts.poppins(
// //                            fontSize: 13,
// //                            color: Color(0xFF5D6A78),
// //                            fontWeight: FontWeight.w300,
// //                          ),
// //                        ),
// //                      ),
// //                    ),
//                     child: Diagonal(
//                       clipHeight: 70.0,
//                       axis: Axis.vertical,
//                       position: DiagonalPosition.BOTTOM_RIGHT,
//                       child: Container(
//                         color: Colors.white,
//                         width: 200.0,
//                         height: 175.0,
//                         child: Align(
//                           alignment: Alignment.center,
//                           // child: Container(
//                           //   width: 150,
//                           //   margin: EdgeInsets.only(right: 54, left: 12),
//                           //   child: Text(
//                           //     "FREE premium organic milk sit amet, consectetur adipiscing elit, sed",
//                           //     overflow: TextOverflow.ellipsis,
//                           //     maxLines: 5,
//                           //     style: GoogleFonts.poppins(
//                           //       fontSize: 13,
//                           //       color: Color(0xFF5D6A78),
//                           //       fontWeight: FontWeight.w300,
//                           //     ),
//                           //   ),
//                           // ),
//                         ),
//                       ),
//                     ),
//                   ),
                ],
              )),
        ))
    .toList();
