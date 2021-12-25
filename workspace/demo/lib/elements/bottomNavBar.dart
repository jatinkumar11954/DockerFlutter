import 'package:athome_partner_app/static/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  int index;

  BottomNavBar({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Color before = Theme.of(context).primaryColor;
    Color after = Colors.black45;

    return Container(
      color: Colors.white,
      height: SizeConfig.h * 0.088,
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Divider(thickness: 1.2, height: 1.2, color: Colors.grey[300]),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,

            selectedItemColor: Theme.of(context).primaryColor,
            selectedFontSize: SizeConfig.w * 0.036,
            unselectedFontSize: SizeConfig.w * 0.036,
            iconSize: 22,
            elevation: 0,
            selectedLabelStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w400),
            unselectedLabelStyle: TextStyle(
                color: Theme.of(context).focusColor,
                fontWeight: FontWeight.w400),
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(size: 28),
            unselectedItemColor: Theme.of(context).accentColor,
            currentIndex: widget.index,
            onTap: (int i) {
              switch (i) {
                case 0:
                  Navigator.of(context).pushReplacementNamed(
                    '/HomeScreen',
                  );
                  break;
                case 1:
                  Navigator.of(context).pushNamed(
                    '/Bookings',
                  );
                  break;
                case 2:
                  Navigator.of(context).pushNamed(
                    '/SettingScreen',
                  );
                  break;
                case 3:
                  // Navigator.of(context).pushNamed(
                  //   '/SettingScreen',
                  // );
                  break;
                // case 4:
                //   Navigator.of(context)
                //       .pushReplacementNamed('/Pages', arguments: 4);
                //   break;
              }
            },
            // this will be set when a new tab is tapped
            items: [
              BottomNavigationBarItem(
                  title: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: SizeConfig.w * 0.036,
                        color: widget.index == 0 ? before : after,
                      ),
                    ),
                  ),
                  // title: SizedBox(),
                  icon: Icon(
                    Icons.home,
                    color: widget.index == 0 ? before : after,
                  )
                  //  Image.asset("assets/icons/home.png",
                  //     color: widget.index == 0 ? before : after, height: 20)
                  ),
              BottomNavigationBarItem(
                  title: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "Bookings",
                      style: TextStyle(
                        fontSize: SizeConfig.w * 0.036,
                        color: widget.index == 1 ? before : after,
                      ),
                    ),
                  ),
                  icon: Icon(
                    Icons.shopping_bag,
                    color: widget.index == 1 ? before : after,
                  )
                  //  Image.asset("assets/icons/discount32.png",
                  //     color: widget.index == 1 ? before : after, height: 20)
                  ),
              BottomNavigationBarItem(
                  title: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: SizeConfig.w * 0.036,
                        color: widget.index == 2 ? before : after,
                      ),
                    ),
                  ),
                  icon: Icon(
                    Icons.person,
                    color: widget.index == 2 ? before : after,
                  )),
              BottomNavigationBarItem(
                  title: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "Notification",
                      style: TextStyle(
                        fontSize: SizeConfig.w * 0.036,
                        color: widget.index == 3 ? before : after,
                      ),
                    ),
                  ),
                  icon: Icon(
                    Icons.notifications,
                    color: widget.index == 3 ? before : after,
                  )
                  //  new Image.asset("assets/icons/team.png",
                  //     height: 20, color: widget.index == 2 ? before : after)
                  ),

              //  Image.asset("assets/icons/user.png",
              //     height: 20, color: widget.index == 3 ? before : after)),
            ],
          ),
        ],
      ),
    );
  }
}
