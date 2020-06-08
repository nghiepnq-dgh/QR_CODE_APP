import 'package:flutter/material.dart';
import 'package:qr_code_app/util/ImgPath.dart';

class DrawerView extends StatefulWidget {
  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            color: Colors.lightBlueAccent,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(ImgPath.logo),
                          fit: BoxFit.fill
                        ),
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.lock_open),
            title: Text("Đăng nhập", style: TextStyle(fontSize: 18.0),),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text("Danh sách hồ sơ", style: TextStyle(fontSize: 18.0),),
            onTap: (){},
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text("Lịch sử tìm kiếm", style: TextStyle(fontSize: 18.0),),
            onTap: (){},
          )
        ],
      ),
    );
  }
}
