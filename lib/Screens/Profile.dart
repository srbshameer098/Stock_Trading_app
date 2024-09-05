import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:avatar_glow/avatar_glow.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEBFCF8),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50.h),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 150,
                      child: AvatarGlow(
                        startDelay: const Duration(milliseconds: 1000),
                        glowColor: Colors.grey,
                        glowShape: BoxShape.circle,
                        glowCount: 2,
                        glowRadiusFactor: 0.2,
                        // // animate: _animate,
                        curve: Curves.fastOutSlowIn,
                        // endRaduis:100.0,

                        child: const Material(
                          elevation: 8.0,
                          shape: CircleBorder(),
                          color: Colors.black,
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFFFFFFF),
                            child: Icon(
                              Icons.person_4,
                              size: 50,
                            ),
                            radius: 50.0,
                          ),
                        ),
                      ),
                    ),
                    Text('Pablo',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        )),
                    SizedBox(
                      height: 20.h,
                    )
                  ],
                ),
              ),

              // -------------- 1st Container  ------------------  //

              Center(
                child: Container(
                  // width: 334,
                  // height: 370,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 2, color: Colors.grey),
                      color: Colors.white),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              // left: 14.w,right: 14.w,
                              top: 18.h,
                              bottom: 4.h),
                          child: GestureDetector(
                            // onTap: () {
                            //   Navigator.of(context).push(
                            //       MaterialPageRoute(builder: (builder) => Personal_details()));
                            // },
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    // border: Border.all(width: 2,color: Colors.grey),
                                    color: Color(0xfddedede),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: Color(0xfd000000),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  width: 212.w,
                                  child: Text("Personal Details",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 18,
                                  color: Color(0xfd000000),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            width: 315.w,
                            child: Divider(
                              thickness: 0,
                            )),
                        GestureDetector(
                          // onTap: () {
                          //   Navigator.of(context).push(
                          //       MaterialPageRoute(builder: (builder) => My_Order()));
                          // },
                          child: Padding(
                            padding: EdgeInsets.only(
                                // left: 14.w,right: 14.w,
                                top: 12.h,
                                bottom: 4.h),
                            child: Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    // border: Border.all(width: 2,color: Colors.grey),
                                    color: Color(0xfddedede),
                                  ),
                                  child: Icon(
                                    Icons.shopping_bag,
                                    color: Color(0xfd000000),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  width: 212.w,
                                  child: Text("My Orders",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 18,
                                  color: Color(0xfd000000),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            width: 315.w,
                            child: Divider(
                              thickness: 0,
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              // left: 14.w,right: 14.w,
                              top: 12.h,
                              bottom: 4.h),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  // border: Border.all(width: 2,color: Colors.grey),
                                  color: Color(0xfddedede),
                                ),
                                child: const Icon(
                                  Icons.credit_card,
                                  color: Color(0xfd000000),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                width: 227.w,
                                child: Text("My Card",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                                color: Color(0xfd000000),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 315.w,
                            child: Divider(
                              thickness: 0,
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              // left: 14.w,right: 14.w,
                              top: 12.h,
                              bottom: 4.h),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  // border: Border.all(width: 2,color: Colors.grey),
                                  color: Color(0xfddedede),
                                ),
                                child: Icon(
                                  Icons.settings,
                                  color: Color(0xfd000000),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                width: 227.w,
                                child: Text("Settings",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                                color: Color(0xfd000000),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20.h,
              ),

              // -------------- 2nd Container  ------------------  //

              Center(
                child: Container(
                  // width: 334,
                  // height: 255,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 2, color: Colors.grey),
                      color: Colors.white),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              // left: 14.w,right: 14.w,
                              top: 12.h,
                              bottom: 4.h),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  // border: Border.all(width: 2,color: Colors.grey),
                                  color: Color(0xfddedede),
                                ),
                                child: Icon(
                                  Icons.language_outlined,
                                  color: Color(0xfd000000),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                width: 214.w,
                                child: Text("FAQs",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                                color: Color(0xfd000000),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 315.w,
                            child: Divider(
                              thickness: 0,
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              // left: 14.w,right: 14.w,
                              top: 12.h,
                              bottom: 4.h),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  // border: Border.all(width: 2,color: Colors.grey),
                                  color: Color(0xfddedede),
                                ),
                                child: Icon(
                                  Icons.privacy_tip_outlined,
                                  color: Color(0xfd000000),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                width: 214.w,
                                child: Text("Privacy",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                                color: Color(0xfd000000),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 315.w,
                            child: Divider(
                              thickness: 0,
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              // left: 14.w,right: 14.w,
                              top: 12.h,
                              bottom: 4.h),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  // border: Border.all(width: 2,color: Colors.grey),
                                  color: Color(0xfddedede),
                                ),
                                child: Icon(
                                  Icons.file_copy,
                                  color: Color(0xfd000000),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                width: 214.w,
                                child: Text("Terms & Contions",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                                color: Color(0xfd000000),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 315.w,
                            child: Divider(
                              thickness: 0,
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              // left: 14.w,right: 14.w,
                              top: 12.h,
                              bottom: 4.h),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  // border: Border.all(width: 2,color: Colors.grey),
                                  color: Color(0xfddedede),
                                ),
                                child: Icon(
                                  Icons.rate_review_outlined,
                                  color: Color(0xfd000000),
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              SizedBox(
                                width: 229.w,
                                child: Text("Reviews",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    )),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 18,
                                color: Color(0xfd000000),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
