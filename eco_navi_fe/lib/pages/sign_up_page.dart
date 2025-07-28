import 'dart:convert';

import 'package:eco_navi_fe/services/econavi_api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKeyNM = GlobalKey<FormState>();
  final FocusNode _nodeNM = FocusNode();
  late String _textValNM;

  final _formKeyID = GlobalKey<FormState>();
  final FocusNode _nodeID = FocusNode();
  late String _textValID;

  final _formKeyPW = GlobalKey<FormState>();
  final FocusNode _nodePW = FocusNode();
  late String _textValPW;

  @override
  void initState() {
    _nodeNM.addListener(() => setState(() {}));
    _nodeID.addListener(() => setState(() {}));
    _nodePW.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? validateEmail(String? value) {
    const pattern =
        r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final width = size.height * (402 / 874);
    final double heightRatio = size.height / 874;

    final bool focusedNM = _nodeID.hasFocus;
    final bool focusedID = _nodeID.hasFocus;
    final bool focusedPW = _nodePW.hasFocus;

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 92 * heightRatio,
            width: width,
            margin: EdgeInsets.fromLTRB(
              15 * heightRatio,
              43 * heightRatio,
              15 * heightRatio,
              80 * heightRatio,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 70 * heightRatio,
                  width: 70 * heightRatio,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).pop();
                        },
                        child: Container(
                          height: 35 * heightRatio,
                          width: 35 * heightRatio,
                          child: SvgPicture.asset(
                            'svg/chevron-left.svg',
                            height: 33 * heightRatio,
                            width: 33 * heightRatio,
                            colorFilter: ColorFilter.mode(
                              Color(0xFF000000),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 20 * heightRatio,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Container(height: 70 * heightRatio, width: 70 * heightRatio),
              ],
            ),
          ),

          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(
                  30 * heightRatio,
                  10 * heightRatio,
                  30 * heightRatio,
                  10 * heightRatio,
                ),
                child: Text(
                  "이름",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 14 * heightRatio,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Form(
                key: _formKeyNM,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    25 * heightRatio,
                    5 * heightRatio,
                    25 * heightRatio,
                    5 * heightRatio,
                  ),
                  padding: EdgeInsets.fromLTRB(
                    5 * heightRatio,
                    5 * heightRatio,
                    5 * heightRatio,
                    5 * heightRatio,
                  ),
                  height: 50 * heightRatio,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  alignment: Alignment.center,
                  child: TextFormField(
                    focusNode: _nodeNM,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: focusedNM ? '' : '이름',
                      hintStyle: TextStyle(
                        color: Color(0xFF6C6C6C),
                        fontSize: 14 * heightRatio,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                    cursorColor: Colors.black,
                    cursorHeight: 18 * heightRatio,

                    onChanged:
                        (value) => setState(() {
                          _textValNM = value;
                        }),

                    onSaved: (newValue) {
                      _textValNM = newValue!;
                      //검색 이벤트 발생
                    },
                  ),
                ),
              ),
            ],
          ),

          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(
                  30 * heightRatio,
                  10 * heightRatio,
                  30 * heightRatio,
                  10 * heightRatio,
                ),
                child: Text(
                  "아이디 (이메일)",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 14 * heightRatio,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Form(
                key: _formKeyID,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    25 * heightRatio,
                    5 * heightRatio,
                    25 * heightRatio,
                    5 * heightRatio,
                  ),
                  padding: EdgeInsets.fromLTRB(
                    5 * heightRatio,
                    5 * heightRatio,
                    5 * heightRatio,
                    5 * heightRatio,
                  ),
                  height: 50 * heightRatio,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  alignment: Alignment.center,
                  child: TextFormField(
                    focusNode: _nodeID,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: focusedID ? '' : '아이디 (이메일)',
                      hintStyle: TextStyle(
                        color: Color(0xFF6C6C6C),
                        fontSize: 14 * heightRatio,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                    cursorColor: Colors.black,
                    cursorHeight: 18 * heightRatio,

                    validator: validateEmail,
                    onChanged:
                        (value) => setState(() {
                          _textValID = value;
                        }),
                    onSaved: (newValue) {
                      _textValID = newValue!;
                    },
                  ),
                ),
              ),
            ],
          ),

          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(
                  30 * heightRatio,
                  10 * heightRatio,
                  30 * heightRatio,
                  10 * heightRatio,
                ),
                child: Text(
                  "비밀번호",
                  style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 14 * heightRatio,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Form(
                key: _formKeyPW,
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    25 * heightRatio,
                    5 * heightRatio,
                    25 * heightRatio,
                    5 * heightRatio,
                  ),
                  padding: EdgeInsets.fromLTRB(
                    5 * heightRatio,
                    5 * heightRatio,
                    5 * heightRatio,
                    5 * heightRatio,
                  ),
                  height: 50 * heightRatio,
                  width: width,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  alignment: Alignment.center,
                  child: TextFormField(
                    focusNode: _nodePW,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintText: focusedPW ? '' : '비밀번호',
                      hintStyle: TextStyle(
                        color: Color(0xFF6C6C6C),
                        fontSize: 14 * heightRatio,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                    cursorColor: Colors.black,
                    cursorHeight: 18 * heightRatio,
                    obscureText: true,

                    onChanged:
                        (value) => setState(() {
                          _textValPW = value;
                        }),

                    onSaved: (newValue) {
                      _textValPW = newValue!;
                    },
                  ),
                ),
              ),
            ],
          ),

          InkWell(
            onTap: () {
              final isNmInput = _textValPW.isNotEmpty;
              final isEmailValidate = _formKeyID.currentState!.validate();
              final isPwInput = _textValPW.isNotEmpty;

              if (isNmInput && isPwInput && isEmailValidate) {
                try {
                  AuthService.signUp(
                    username: _textValID,
                    name: _textValNM,
                    role: "USER",
                    password: _textValPW,
                  );
                  GoRouter.of(context).go('/home');
                } catch (e) {
                  print(e);
                }
              }
            },
            child: Container(
              margin: EdgeInsets.fromLTRB(
                25 * heightRatio,
                50 * heightRatio,
                25 * heightRatio,
                20 * heightRatio,
              ),
              padding: EdgeInsets.fromLTRB(
                5 * heightRatio,
                10 * heightRatio,
                5 * heightRatio,
                10 * heightRatio,
              ),
              height: 60 * heightRatio,
              width: width,
              decoration: BoxDecoration(
                color: Color(0xFF272727),
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
              alignment: Alignment.center,
              child: Text(
                '회원가입하기',
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16 * heightRatio,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
