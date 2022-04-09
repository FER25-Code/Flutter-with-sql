import 'package:app_with_sql/Mysql.dart';
import 'package:flutter/material.dart';


void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomePage(),
    )
);
class HomePage extends StatefulWidget{
  @override
  HomePageState createState()=>HomePageState();
}

class HomePageState extends State<HomePage> {

  var db =new Mysql();
  String phat_image='';
  String titer='';
  String price='';






  @override
  Widget build(BuildContext context) {
   try{
     db.getConnection().then((conn) {
       String sql ='select titer,price,phat_image from product';
       conn.query(sql).then((result){
         for(var row in result){
           setState(() {
             titer=row[0];
             price=row[1];
             phat_image =row[2];
             print('titer: ${row[0]}, price: ${row[1]}, phat_image: ${row[2]}');

           });
         }

       });
     });
   }catch(error) {
     print('no connet ');


   }

     return Scaffold(
       backgroundColor: Color.fromRGBO(244, 243, 243, 1),
       appBar: AppBar(
         backgroundColor: Colors.white,
         brightness: Brightness.light,
         elevation: 0,
         leading: IconButton(
           icon: Icon(
             Icons.menu,
             color: Colors.black87,
           ),
           onPressed: (){},
         ),
       ),
       body: SafeArea(
         child: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius:
                     BorderRadius.vertical(bottom: Radius.circular(30))),
                 padding: EdgeInsets.all(20.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text(
                       'Find Your',
                       style: TextStyle(color: Colors.black87, fontSize: 25),
                     ),
                     SizedBox(
                       height: 5,
                     ),
                     Text(
                       'Product',
                       style: TextStyle(
                           color: Colors.black,
                           fontSize: 40,
                           fontWeight: FontWeight.bold),
                     ),
                     SizedBox(
                       height: 20,
                     ),
                     Container(
                       padding: EdgeInsets.all(5),
                       decoration: BoxDecoration(
                           color: Color.fromRGBO(244, 243, 243, 1),
                           borderRadius: BorderRadius.circular(15)),
                       child: TextField(
                         decoration: InputDecoration(
                             border: InputBorder.none,
                             prefixIcon: Icon(
                               Icons.search,
                               color: Colors.black87,
                             ),
                             hintText: "Search you're looking for",
                             hintStyle:
                             TextStyle(color: Colors.grey, fontSize: 15)),
                       ),
                     ),
                     SizedBox(
                       height: 10,
                     ),
                   ],
                 ),
               ),
               SizedBox(
                 height: 20,
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Text(
                       'Drinks',
                       style:
                       TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                     ),
                     SizedBox(
                       height: 15,
                     ),
                     Container(
                       height: 200,
                       child: ListView(
                         scrollDirection: Axis.horizontal,
                         children: <Widget>[


                           ProductCard('$phat_image','$price','$titer'),


                         ],
                       ),
                     ),
                     SizedBox(
                       height: 20,
                     ),
                     Container(
                       height: 150,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         image: DecorationImage(
                             fit: BoxFit.cover,
                             image: AssetImage('assets/images/store.jpg')),
                       ),
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           gradient: LinearGradient(
                               begin: Alignment.bottomRight,
                               stops: [
                                 0.3,
                                 0.9
                               ],
                               colors: [
                                 Colors.black.withOpacity(.8),
                                 Colors.black.withOpacity(.2)
                               ]),
                         ),
                         child: Align(
                           alignment: Alignment.bottomLeft,
                           child: Padding(
                             padding: const EdgeInsets.all(15.0),
                             child: Text(
                               'Here All whats you need',
                               style:
                               TextStyle(color: Colors.white, fontSize: 20),
                             ),
                           ),
                         ),
                       ),
                     )
                   ],
                 ),
               )
             ],
           ),
         ),
       ),
     );
   }
  }

  Widget ProductCard(String path, String price ,String title) {
    return AspectRatio(
      aspectRatio: 2.50 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(path)),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                0.1,
                0.9
              ], colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.1)
              ])),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:<Widget>[
                Text(title,style: TextStyle(color:Colors.white,fontSize: 15),),
                SizedBox(height: 10,),
                Text(price,style: TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),

              ]

          ),
        ),
      ),
    );
  }






