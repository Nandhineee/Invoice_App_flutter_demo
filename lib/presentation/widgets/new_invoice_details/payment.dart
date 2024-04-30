// import 'package:flutter/material.dart';
//
//
//
// class Paymentinfo extends StatefulWidget {
//   const Paymentinfo({super.key});
//
//   @override
//   State<Paymentinfo> createState() => _PaymentinfoState();
// }
//
// class _PaymentinfoState extends State<Paymentinfo> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//         padding: const EdgeInsets.only(right: 17.0, left: 17.0, top: 20.0),
//         child: Container(
//           height: 150.0,
//           width: 400.0, // Increased width for the same reason
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.rectangle,
//             // Ensures the container is rectangular
//             borderRadius: BorderRadius.circular(10.0),
//             // Gives rounded corners for a nicer look
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 // Shadow color with opacity
//                 spreadRadius: 2.0,
//                 // Spread radius
//                 blurRadius: 8.0,
//                 // Blur radius
//                 offset: const Offset(4.0, 4.0), // X, Y offset from the container
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) =>
//                             const Paymentinfo()), // Navigate to InvoiceInfo page
//                   );
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.only(top: 15.0, left: 20.0),
//                   // Adjust this for desired left alignment
//                   child: Text(
//                     "Payment Info",
//                     style: TextStyle(
//                       color: Colors.grey, // Text color
//                       fontSize: 16.0, // Font size
//                       fontWeight: FontWeight.bold, // Font weight
//                     ),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(
//                     top: 20.0, right: 17.0, left: 17.0),
//                 child: Container(
//                   height: 1.0,
//                   color: Colors.black, // Color for the line
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //       builder: (context) =>
//                   //           const TestApp()), // Navigate to InvoiceInfo page
//                   // );
//                 },
//                 child: const Padding(
//                   padding: EdgeInsets.only(top: 15.0, left: 20.0),
//                   // Adjust this for desired left alignment
//                   child: Text(
//                     "Notes",
//                     style: TextStyle(
//                       color: Colors.grey, // Text color
//                       fontSize: 16.0, // Font size
//                       fontWeight: FontWeight.bold, // Font weight
//                     ),
//                   ),
//                 ),
//               ),
//
//             ],
//           ),
//         ));
//   }
// }
