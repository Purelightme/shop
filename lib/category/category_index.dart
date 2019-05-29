import 'package:flutter/material.dart';
import 'package:shop/category/product/product_list.dart';
import 'package:shop/common/touch_callback.dart';

class CategoryIndex extends StatefulWidget {
  @override
  _CategoryIndexState createState() => _CategoryIndexState();
}

class _CategoryIndexState extends State<CategoryIndex> {

  List<String> _categories = ['女装','食品','生鲜','洗护','母婴','百货','鞋靴','手机',
    '运动','男装','内衣','美家','美妆','箱包','饰品','电器','车品','保健'
  ];

  List<List<Map<String,dynamic>>> children = [
    [
      {
        'title':'裙子',
        'childs':[
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'裙子'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'休闲群'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'牛仔裤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'打底裤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'西装裤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'裙子'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'休闲群'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'牛仔裤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'打底裤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'西装裤'},
        ]
      },
      {
        'title':'上装',
        'childs':[
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'T恤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'衬衫'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'毛衣'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'卫衣'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'裙子'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'休闲群'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'牛仔裤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'打底裤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'西装裤'},
        ]
      }
    ],
    [
      {
        'title':'零食',
        'childs':[
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'裙子'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'休闲群'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'牛仔裤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'打底裤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'西装裤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'裙子'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'休闲群'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'牛仔裤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'打底裤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'西装裤'},
        ]
      },
      {
        'title':'饼干',
        'childs':[
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'T恤'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'衬衫'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'毛衣'},
          {'imageCover':'https://ws1.sinaimg.cn/large/0065oQSqgy1fwgzx8n1syj30sg15h7ew.jpg','title':'卫衣'},
        ]
      }
    ],
  ];

  int _currentIndex = 0;

  Widget _buildLeftItem(int index){
    return GestureDetector(
      child: Container(
        color: _currentIndex == index ? Colors.grey.withOpacity(0.2) : Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
        child: Text(_categories[index],style: TextStyle(
          color: _currentIndex == index ? Colors.redAccent : Colors.black
        ),),
      ),
      onTap: (){
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  List<Widget> _buildLeft(){
    List<Widget> lefts = [];
    int length = _categories.length;
    for(int i = 0;i < length;i++){
      lefts.add(_buildLeftItem(i));
    }
    return lefts;
  }

  Widget _buildRightItem2(items){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(16),
          child: Text(items['title']),
        ),
        Container(
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
          ),
          child: Column(
              children: items['childs'].map<Widget>((item){
                return Column(
                  children: <Widget>[
                    Image.network(item['imageCover'],width: 50,height: 50,),
                    Text(item['title'])
                  ],
                );
              }).toList()
          )
        ),

      ],
    );
  }

  Widget _buildRightItem(items){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(16),
          child: Text(items['title']),
        ),
        Container(
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            child: GridView.count(
                crossAxisCount: 3,
                physics: new NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: items['childs'].map<Widget>((item) {
                  return TouchCallback(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Image.network(item['imageCover'], width: 50, height: 50,),
                          Text(item['title'])
                        ],
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context){
                          return ProductList();
                        })
                      );
                    },
                  );
                }).toList()
            )
        ),
      ],
    );
  }

  Widget _buildRight() {

    List<Widget> rights = [];

    rights = children[_currentIndex].map<Widget>(
            (item) => _buildRightItem(item)
    ).toList();

    rights.add(Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Center(
        child: Text('---到底了---'),
      ),
    ));

    return Container(
      color: Colors.grey.withOpacity(0.2),
      child: ListView(
          children: rights
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: 80,
            child: ListView(
              children: _buildLeft()
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: _buildRight()
            )
          ),
        ],
      ),
    );
  }
}
