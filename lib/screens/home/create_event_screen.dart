import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_place/google_place.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mash/configs/app_colors.dart';
import 'package:mash/configs/app_data.dart';
import 'package:mash/configs/app_textfield.dart';
import 'package:mash/screens/feed_view/controller/create_event_controller.dart';
import 'package:mash/screens/home/API/create_event_service.dart';
import 'package:mash/widgets/app_bar_widget.dart';
import 'package:mash/widgets/app_button.dart';
import 'package:mash/widgets/blur_loader.dart';
import 'package:mash/widgets/error_snackbar.dart';
import 'package:mash/widgets/spacers.dart';

class InsertEventScreen extends StatefulWidget {
  const InsertEventScreen({Key? key}) : super(key: key);

  @override
  State<InsertEventScreen> createState() => _InsertEventScreenState();
}

class _InsertEventScreenState extends State<InsertEventScreen> {
  CreateEventController createEventController =
      Get.put(CreateEventController());

  File? image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: appAppBar(
          isBack: false,
          title: "Create Event",
        ),
        body: Obx(
          () => Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            y16,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: appTextField(
                                controller: createEventController
                                    .createEventTitle.value,
                                hintText: "Event Name",
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                },
                              ),
                            ),
                            y10,
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: appTextField(
                                hintText: "Location",
                                textInputAction: TextInputAction.search,
                                controller:
                                    createEventController.location.value,
                                onChanged: (val) async {},
                                onSubmitted: (val) async {
                                  if (val.trim().length != 0) {
                                    var googlePlace = GooglePlace(
                                        "AIzaSyArgtGCvxqhaW-EdFHnSeI4vTANeGvRFTg");
                                    createEventController.pred.clear();
                                    var result =
                                        await googlePlace.autocomplete.get(val);
                                    createEventController.pred.value =
                                        result!.predictions!;
                                  } else {
                                    createEventController.pred.clear();
                                  }
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Required";
                                  }
                                },
                              ),
                            ),
                            eventContainer(
                                onTap: () {},
                                selectedValue:
                                    createEventController.selectedCategory,
                                eventName: "Category",
                                data: category,
                                onChanged: (value) {
                                  createEventController.selectedCategory.value =
                                      value!;
                                }),
                            eventContainer(
                                onTap: () {},
                                selectedValue:
                                    createEventController.selectedParty,
                                eventName: "Party",
                                data: party,
                                onChanged: (value) {
                                  createEventController.selectedParty.value =
                                      value!;
                                }),
                            timeContainer(
                                onTap: () {},
                                selectedValue:
                                    createEventController.selectedTime,
                                eventName: "Time",
                                data: time,
                                onChanged: (value) async {
                                  createEventController.selectedTime.value =
                                      value!;
                                }),
                            Obx(() => createEventController
                                        .selectedTime.value !=
                                    2
                                ? SizedBox()
                                : InkWell(
                                    onTap: () async {
                                      DateTime? date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now()
                                              .add(Duration(days: 2)),
                                          firstDate: DateTime.now()
                                              .add(Duration(days: 2)),
                                          lastDate: DateTime.now()
                                              .add(Duration(days: 14)));
                                      if (date != null) {
                                        createEventController.eventDate.value =
                                            date;
                                      }
                                    },
                                    child: Container(
                                        margin: EdgeInsets.all(16),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 16.h),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColors.shadowColor,
                                                  offset: Offset(3, 3),
                                                  blurRadius: 10)
                                            ]),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Select Date",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            Text(
                                              DateFormat("dd MMM yyyy").format(
                                                  createEventController
                                                      .eventDate.value),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.kOrange),
                                            )
                                          ],
                                        )),
                                  )),
                            InkWell(
                              onTap: () {
                                Get.dialog(Dialog(
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            Get.back();
                                            XFile? res = await ImagePicker()
                                                .pickImage(
                                                    source: ImageSource.camera);
                                            if (res != null) {
                                              image = File(res.path);
                                              setState(() {});
                                            } else {
                                              print("NOT");
                                            }
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                  height: 60,
                                                  child: Icon(
                                                    Icons.camera,
                                                    color: AppColors.kOrange,
                                                    size: 60,
                                                  )),
                                              Text(
                                                "Camera",
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                        color:
                                                            AppColors.kOrange,
                                                        fontSize: 16.sp),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            Get.back();

                                            XFile? res = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (res != null) {
                                              image = File(res.path);
                                              setState(() {});
                                            } else {
                                              print("NOT");
                                            }
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                  height: 60,
                                                  child: Icon(
                                                    Icons.collections_outlined,
                                                    color: AppColors.kOrange,
                                                    size: 60,
                                                  )),
                                              Text(
                                                "Gallery",
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                        color:
                                                            AppColors.kOrange,
                                                        fontSize: 16.sp),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                              },
                              child: Container(
                                height: 200,
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.shadowColor,
                                        offset: Offset(4, 4),
                                        blurRadius: 10,
                                      )
                                    ]),
                                child: image == null
                                    ? Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 50,
                                        color: AppColors.kOrange,
                                      )
                                    : Image.file(image!),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, bottom: 25.h, right: 16.w),
                    child: appButton(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            if (createEventController.lat.value == 0.0 ||
                                createEventController.lng.value == 0.0) {
                              errorSnackBar("Problem with the location",
                                  "Add location or change location");
                            } else {
                              createEventService(image);
                            }
                          }
                        },
                        buttonBgColor: AppColors.kOrange,
                        textColor: Colors.white,
                        buttonName: "Create Event"),
                  )
                ],
              ),
              createEventController.pred.length == 0
                  ? SizedBox()
                  : Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(top: 145, left: 16, right: 16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(4, 4),
                                blurRadius: 24)
                          ]),
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InkWell(
                                onTap: () async {
                                  createEventController.loading.value = true;
                                  var addresses = await GeoCode(
                                          apiKey:
                                              "AIzaSyArgtGCvxqhaW-EdFHnSeI4vTANeGvRFTg")
                                      .forwardGeocoding(
                                          address: createEventController
                                              .pred[index].description!);
                                  createEventController.loading.value = false;

                                  createEventController.location.value.text =
                                      createEventController.pred[index]
                                          .structuredFormatting!.mainText!;
                                  createEventController.lat.value =
                                      addresses.latitude!;
                                  createEventController.lng.value =
                                      addresses.longitude!;
                                  createEventController.pred.clear();
                                  print(createEventController.lat.value);
                                  print(createEventController.lng.value);
                                },
                                child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: AppColors.kOrange,
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.shadowColor,
                                              offset: Offset(3, 3),
                                              blurRadius: 10)
                                        ],
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      createEventController
                                          .pred[index].description!,
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white),
                                    )),
                              ),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                          itemCount: createEventController.pred.length),
                    ),
              createEventController.loading.value ? bluLoader() : SizedBox()
            ],
          ),
        ));
  }

  Widget eventContainer(
      {required String eventName,
      VoidCallback? onTap,
      required List<Map<String, dynamic>> data,
      required RxInt selectedValue,
      required Function(int?) onChanged}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eventName,
            style: GoogleFonts.sourceSansPro(color: AppColors.kOrange),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.shadowColor,
                        offset: Offset(3, 3),
                        blurRadius: 10)
                  ]),
              child: Obx(() {
                return DropdownButton<int>(
                  isExpanded: true,
                  hint: Text(
                    eventName,
                    style: GoogleFonts.sourceSansPro(),
                  ),
                  value: selectedValue.value,
                  onChanged: onChanged,
                  underline: SizedBox(),
                  items: List.generate(
                      data.length,
                      (index) => DropdownMenuItem(
                            child: Text(
                              data[index]["title"],
                              style: GoogleFonts.sourceSansPro(),
                            ),
                            value: data[index]["id"],
                          )),
                );
              })),
        ],
      ),
    );
  }

  Widget timeContainer(
      {required String eventName,
      VoidCallback? onTap,
      required List<String> data,
      required RxInt selectedValue,
      required Function(int?) onChanged}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eventName,
            style: GoogleFonts.sourceSansPro(color: AppColors.kOrange),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.shadowColor,
                        offset: Offset(3, 3),
                        blurRadius: 10)
                  ]),
              child: Obx(() {
                return DropdownButton<int>(
                  isExpanded: true,
                  hint: Text(
                    eventName,
                    style: GoogleFonts.sourceSansPro(),
                  ),
                  value: selectedValue.value,
                  onChanged: onChanged,
                  underline: SizedBox(),
                  items: List.generate(
                      data.length,
                      (index) => DropdownMenuItem(
                            child: Text(
                              data[index],
                              style: GoogleFonts.sourceSansPro(),
                            ),
                            value: index,
                          )),
                );
              })),
        ],
      ),
    );
  }
}
