
import 'package:flutter/material.dart';

import '../../config/constant_colors.dart';
import '../../config/constant_images.dart';
import '../03.components/Drawer_component.dart';
import '../03.components/components.dart';
import '../03.components/text_form_field.dart';
import '../popups/alert_dialog.dart';



class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var formKey=GlobalKey<FormState>();
  TextEditingController dashboardPasswordController=TextEditingController();
  bool isDevices = false;
  bool isDashboard = true;
  bool isDepartment = false;
  bool isSettings = false;
  bool isMaintenance = false;
  bool isSuppliers = false;
  bool isStock = false;
  bool isContract = false;
  bool isStore = false;

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.grey[300],
      body: Row(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * .15,
            child: Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10,left: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius
                    .circular(10)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.LOGO,
                            width: 40,
                            height: 30,
                          ),
                          const SizedBox(width: 10,),
                          Text("HEMS",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),

                        ],

                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: const Text(
                        "GENERAL",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    DrawerComponent(
                        textColor: isDashboard
                            ? AppColors.PRIMARYCOLOR
                            : Colors.black,
                        onPressed: () {
                          setState(() {
                            isDashboard = true;
                            isDepartment = false;
                            isSettings = false;
                            isMaintenance = false;
                            isDevices = false;
                            isSuppliers = false;
                            isStock=false;
                            isContract=false;
                            isStore=false;
                          });
                          controller.jumpToPage(0);
                        },
                        image: AppImages.DASHHBOARD,
                        text: "Dashboard"),
                    DrawerComponent(
                        textColor: isDevices
                            ? AppColors.PRIMARYCOLOR
                            : Colors.black,
                        onPressed: () {
                          setState(() {
                            isDevices = true;
                            isDashboard = false;
                            isDepartment = false;
                            isSettings = false;
                            isMaintenance = false;
                            isStore=false;
                            isSuppliers = false;
                            isStock=false;
                            isContract=false;
                          });

                          controller.jumpToPage(1);
                        },
                        image: AppImages.DEVICES,
                        text: "Devices"),
                    DrawerComponent(
                        textColor: isMaintenance ? AppColors
                            .PRIMARYCOLOR : Colors.black,
                        onPressed: () {
                          setState(() {
                            isDevices = false;
                            isDashboard = false;
                            isDepartment = false;
                            isSettings = false;
                            isMaintenance = true;
                            isSuppliers = false;
                            isStock=false;
                            isStore=false;
                            isContract=false;
                          });

                          controller.jumpToPage(2);
                        },
                        image: AppImages.MAINTENANCE,
                        text: "Maintenance"),

                    DrawerComponent(
                        textColor: isSuppliers
                            ? AppColors.PRIMARYCOLOR
                            : Colors.black,
                        onPressed: () {
                          setState(() {
                            isDevices = false;
                            isDashboard = false;
                            isDepartment = false;
                            isSettings = false;
                            isMaintenance = false;
                            isSuppliers = true;
                            isStock=false;
                            isContract=false;
                            isStore=false;
                          });
                          controller.jumpToPage(5);
                        },
                        image: AppImages.SUPPLIERS,
                        text: "Suppliers"),
                    DrawerComponent(
                        textColor: isStock
                            ? AppColors.PRIMARYCOLOR
                            : Colors.black,
                        onPressed: () {
                          setState(() {
                            isDevices = false;
                            isDashboard = false;
                            isDepartment = false;
                            isStock = true;
                            isSettings = false;
                            isMaintenance = false;
                            isSuppliers=false;
                            isContract=false;
                            isStore=false;
                          });
                          controller.jumpToPage(7);
                        },
                        image: AppImages.STOCK,
                        text: "Stock"),
                    DrawerComponent(
                        textColor: isContract
                            ? AppColors.PRIMARYCOLOR
                            : Colors.black,
                        onPressed: () {
                          setState(() {
                            isDevices = false;
                            isDashboard = false;
                            isDepartment = false;
                            isSettings = false;
                            isMaintenance = false;
                            isSuppliers=false;
                            isContract=true;
                            isStock=false;
                            isStore=false;

                          });
                          controller.jumpToPage(6);
                        },
                        image: AppImages.CONTRACT,
                        text: "Contract"),
                    DrawerComponent(
                        textColor: isStore
                            ? AppColors.PRIMARYCOLOR
                            : Colors.black,
                        onPressed: () {
                          setState(() {
                            isDevices = false;
                            isDashboard = false;
                            isDepartment = false;
                            isSettings = false;
                            isMaintenance = false;
                            isSuppliers=false;
                            isContract=false;
                            isStock=false;
                            isStore=true;

                          });
                          controller.jumpToPage(8);
                        },
                        image: AppImages.STORAGE,
                        text: "Storage"),
                    DrawerComponent(
                        textColor: isSettings
                            ? AppColors.PRIMARYCOLOR
                            : Colors.black,
                        onPressed: () {
                          setState(() {
                            isStore=false;
                            isDevices = false;
                            isDashboard = false;
                            isDepartment = false;
                            isSettings = true;
                            isMaintenance = false;
                            isSuppliers = false;
                            isStock=false;
                            isContract=false;
                          });
                          controller.jumpToPage(3);
                        },
                        image: AppImages.SETTINGS,
                        text: "Settings"),

                  ],
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width * .85,
            child: PageView.builder(
              controller: controller,
              itemBuilder: (context, i) => pages[i],
              itemCount: pages.length,
            ),
          )
        ],
      ),
    );



  }
}
