import 'package:fluintl/fluintl.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ones_ai_flutter/common/api/user_api.dart';
import 'package:ones_ai_flutter/common/dao/user_dao.dart';
import 'package:ones_ai_flutter/common/net/http_manager.dart';
import 'package:ones_ai_flutter/common/redux/global/ones_state.dart';
import 'package:ones_ai_flutter/common/routes/page_route.dart';
import 'package:ones_ai_flutter/resources/font_icons.dart';
import 'package:ones_ai_flutter/resources/index.dart';
import 'package:ones_ai_flutter/utils/utils_index.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ones_ai_flutter/widget/button/gradient_button.dart';
import 'package:redux/redux.dart';
import 'package:build_daemon/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _widthAnimation;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  static bool _showPlaintext = true,
      _autoValied = false,
      _userNameValied = false,
      _passwordValied = false;

  static String _userName, _password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _widthAnimation = Tween<double>(begin: 1000, end: 42.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(.0, 0.25, curve: Curves.ease))
          ..addListener(() {
            if (_widthAnimation.isCompleted) {}
          }));
    _accountController.text = "huangjinfan+5001@ones.ai";
    _passwordController.text = "11111111";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(IntlUtil.getString(context, Strings.titleLogin)),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            margin: EdgeInsets.only(top: 60.0, bottom: 10.0),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/images/ones_icon.png"),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Card(
            margin: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildAccountTextField(),
                    SizedBox(height: _userNameValied ? 10 : 5),
                    _buildPasswordTextField(),
                    _buildForgetPasswordWidget(),
                    _buildLoginWidget_()
//                    _buildLoginWidget()
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAccountTextField() {
    return TextFormField(
      onSaved: (String value) {
        _userName = value;
      },
      keyboardType: TextInputType.text,
      maxLines: 1,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      autofocus: false,
      autovalidate: _autoValied,
      controller: _accountController,
      decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(width: double.infinity)),
          hintStyle: TextStyle(
            fontSize: 14,
          ),
          hintText: IntlUtil.getString(context, Strings.titleAccountHint),
          prefixIcon: Icon(
            FontIcons.ACCOUNT,
            size: 25,
          ),
          suffixIcon: IconButton(
              icon: Icon(FontIcons.CANCLE),
              onPressed: () {
//                _accountController.clear();
                WidgetsBinding.instance
                    .addPostFrameCallback((_) => _accountController.clear());
              })),
      validator: (value) {
        var accountReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");
        _userNameValied = accountReg.hasMatch(value);
        return _userNameValied
            ? null
            : IntlUtil.getString(context, Strings.titleAccountError);
      },
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      margin: EdgeInsets.only(bottom: _passwordValied ? 12 : 4),
      child: TextFormField(
        onSaved: (String value) {
          _password = value;
        },
        keyboardType: TextInputType.text,
        maxLines: 1,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        autofocus: false,
        autovalidate: _autoValied,
        controller: _passwordController,
        obscureText: _showPlaintext,
        decoration: InputDecoration(
            border: UnderlineInputBorder(
                borderSide: BorderSide(width: double.infinity)),
            hintStyle: TextStyle(
              fontSize: 14,
            ),
            hintText: IntlUtil.getString(context, Strings.titlePasswordHint),
            prefixIcon: Icon(
              FontIcons.PASSWORD,
              size: 25,
            ),
            suffixIcon: IconButton(
                icon: Icon(_showPlaintext
                    ? FontIcons.CLOSED_EYE
                    : FontIcons.OPEND_EYE),
                onPressed: () {
                  setState(() {
                    _showPlaintext = !_showPlaintext;
                  });
                })),
        validator: (value) {
          var passwordReg =
              RegExp(r"^(?=.*\d)(?=.*[a-zA-Z])[\x21-\x7E]{8,32}$");
          _passwordValied = true; //passwordReg.hasMatch(value);
          return _passwordValied
              ? null
              : IntlUtil.getString(context, Strings.titlePasswordError);
        },
      ),
    );
  }

  Widget _buildForgetPasswordWidget() {
    return Container(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          Fluttertoast.showToast(msg: "to do!");
        },
        child: Text(
          IntlUtil.getString(
            context,
            Strings.titleForgetPassword,
          ),
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColor,
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  Widget _buildLoginWidget_() {
    Store<OnesGlobalState> store = StoreProvider.of(context);
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            height: 42,
            width: _widthAnimation.value,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Theme.of(context).primaryColor),
            alignment: Alignment.center,
            child: _widthAnimation.value > 75
                ? GradientButton(
                    child: Text(IntlUtil.getString(context, Strings.titleLogin),
                        style: TextStyle(fontSize: 16)),
                    borderRadius: BorderRadius.circular(8),
                    onPressed: () async {
                      await _animationController.forward().orCancel;
                      await _animationController.reverse().orCancel;
//          _autoValied = true;
//          if (!_formKey.currentState.validate()) {
//            setState(() {});
//          } else {
//            setState(() {});
//            _formKey.currentState.save();
//            Fluttertoast.showToast(msg: "login start!");
//            UserApi.login(_userName, _password, null).then((user) async {
//              if (user != null) {
//                print(user.email);
//                await UserDao.saveLoginUserInfo(user, store);
//                PageRouteManager.openNewPage(
//                    context, PageRouteManager.homePagePath);
//              }
//            });
//          }
                    },
                    childPadding: EdgeInsets.symmetric(vertical: 8),
                  )
                : CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeWidth: 2,
                  ),
          );
        });
  }

  Widget _buildLoginWidget() {
    Store<OnesGlobalState> store = StoreProvider.of(context);
    return Container(
      child: GradientButton(
        child: Text(IntlUtil.getString(context, Strings.titleLogin),
            style: TextStyle(fontSize: 16)),
        borderRadius: BorderRadius.circular(8),
        onPressed: () {
          _autoValied = true;
          if (!_formKey.currentState.validate()) {
            setState(() {});
          } else {
            setState(() {});
            _formKey.currentState.save();
            Fluttertoast.showToast(msg: "login start!");
            UserApi.login(_userName, _password, null).then((user) async {
              if (user != null) {
                print(user.email);
                await UserDao.saveLoginUserInfo(user, store);
                PageRouteManager.openNewPage(
                    context, PageRouteManager.homePagePath);
              }
            });
          }
        },
        childPadding: EdgeInsets.symmetric(vertical: 11),
      ),
      margin: EdgeInsets.only(top: 18, bottom: 5),
    );
  }
}
