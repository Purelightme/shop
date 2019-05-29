import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController _controller = new TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.redAccent,
          leading: BackButton(),
          actions: <Widget>[
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text('搜索'),
                ),
              ),
              onTap: (){
                Navigator.of(context).pushNamed('/product_detail');
              },
            )
          ],
          elevation: 0,
          titleSpacing: 0,
          title: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.search,color: Color.fromRGBO(51, 51, 51, 1),size: 20,),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (value){
                      print(value);
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        hintText: '搜一搜',
                        hintStyle: TextStyle(fontSize: 14),
                        border: InputBorder.none
                    ),
                  ),
                )
              ],
            ),
          )
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.withOpacity(0.2),
              padding: EdgeInsets.all(10),
              child: Text('热门搜索'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [1,2,3,4,15,6,7,128,9,10].map<Widget>((num){
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Text('牛仔裤$num',style: TextStyle(
                          fontSize: 10,
                          color: Colors.black.withOpacity(0.6)
                      ),),
                    );
                  }).toList()
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.withOpacity(0.2),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('最近搜索'),
                  Icon(Icons.delete_outline,color: Colors.grey,)
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    1,2,3,4,15,6,7,128,9,10,10022,3,5,331,432,44,5523532532,
                    1,2,3,4,15,6,7,128,9,10,10022,3,5,331,432,44,5523532532,
                    1,2,3,4,15,6,7,128,9,10,10022,3,5,331,432,44,5523532532,
                    1,2,3,4,15,6,7,128,9,10,10022,3,5,331,432,44,5523532532,
                    1,2,3,4,15,6,7,128,9,10,10022,3,5,331,432,44,5523532532,
                  ].map<Widget>((num){
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Text('牛仔裤$num',style: TextStyle(
                          fontSize: 10,
                          color: Colors.black.withOpacity(0.6)
                      ),),
                    );
                  }).toList()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
