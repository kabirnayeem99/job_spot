import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:job_spot/common/theme/colors.dart';
import 'package:job_spot/domain/entity/job_description_page_state.dart';

import '../widgets/primary_action_button.dart';

const jobDescScreenNavRouteName = "job_description_screen/";

class JobDescriptionScreen extends StatefulWidget {
  const JobDescriptionScreen({Key? key}) : super(key: key);

  @override
  State<JobDescriptionScreen> createState() => _JobDescriptionScreenState();
}

class _JobDescriptionScreenState extends State<JobDescriptionScreen> {
  JobDescriptionPageState _pageState = JobDescriptionPageState.description;

  late GoogleMapController mapController;

  final LatLng _center = const LatLng(22.313999275669637, 91.80758944137361);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _navigateBack(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f7),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 22.0),
            child: Column(
              children: [
                _buildActionBar(context),
                const SizedBox(height: 20),
                _buildJobShortDesc(),
                const SizedBox(height: 20),
                _buildTabButtons(),
                const SizedBox(height: 25),
                _showFragmentBasedOnState(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _showFragmentBasedOnState() {
    late Widget fragment;
    if (_pageState.name == JobDescriptionPageState.description.name) {
      fragment = _buildJobDescriptionFragment();
    } else if (_pageState.name == JobDescriptionPageState.company.name) {
      fragment = _buildCompanyDescriptionFragment();
    } else {
      fragment = _buildJobApplyFragment();
    }
    return fragment;
  }

  Widget _buildJobApplyFragment() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Upload CV",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Add your CV/Resume to apply for a job",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: mulledWine,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildUploadCvButtonBox(),
        const SizedBox(height: 30),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Information",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Container(
          height: 232.0,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: const TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Explain why you are the right person for this job",
            ),
          ),
        )
      ],
    );
  }

  Widget _buildUploadCvButtonBox() {
    return GestureDetector(
      onTap: () => _pickPdfFiles(),
      child: DottedBorder(
        color: mulledWine.withOpacity(0.8),
        strokeWidth: 1.2,
        radius: const Radius.circular(14.0),
        borderType: BorderType.RRect,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          child: Container(
            color: bluePurpleAmethystSmoke.withOpacity(0.3),
            width: double.infinity,
            child: _buildAfterUploadBox(),
          ),
        ),
      ),
    );
  }

  Widget _buildAfterUploadBox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 15.0),
        Row(
          children: [
            const SizedBox(width: 15.0),
            SvgPicture.asset(
              "assets/images/svgs/ic_pdf_file.svg",
              height: 44.0,
              width: 44.0,
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Jamet kudos - CV - UI/UX Designer",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: blackHaiti,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "867 Kb * 14 Feb 2022 at 11:30 am",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: spanPearl,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 27.0),
        Row(
          children: [
            const SizedBox(width: 21.0),
            SvgPicture.asset(
              "assets/images/svgs/ic_delete.svg",
              height: 24.0,
              width: 24.0,
            ),
            const SizedBox(width: 10.0),
            const Text(
              "Remove file",
              style: TextStyle(
                color: lightRed,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }

  Widget _buildBeforeUploadBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/images/svgs/ic_upload.svg",
          height: 24.0,
          width: 24.0,
        ),
        const SizedBox(width: 17.0),
        const Text(
          "Upload CV/Resume",
          style: TextStyle(
            color: mulledWine,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }

  void _pickPdfFiles() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result != null) {
        List<File> files =
            result.paths.map((path) => File(path ?? "")).toList();
        if (kDebugMode) {
          print(files[0]);
        }
      } else {
        if (kDebugMode) {
          print("no file was selected");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Widget _buildTabButtons() {
    final shouldShowCompanyTab =
        _pageState.name == JobDescriptionPageState.company.name;

    return _pageState.name == JobDescriptionPageState.apply.name
        ? Container()
        : Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _onDescriptionButtonClicked,
                  child: PrimaryActionButton(
                    buttonText: "Description",
                    buttonTextColor:
                        shouldShowCompanyTab ? Colors.white : darkIndigo,
                    buttonColor:
                        shouldShowCompanyTab ? darkIndigo : purpleBlueMoonraker,
                  ),
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: GestureDetector(
                  onTap: _onCompanyButtonClicked,
                  child: PrimaryActionButton(
                    buttonText: "Company",
                    buttonTextColor:
                        shouldShowCompanyTab ? darkIndigo : Colors.white,
                    buttonColor:
                        shouldShowCompanyTab ? purpleBlueMoonraker : darkIndigo,
                  ),
                ),
              ),
            ],
          );
  }

  void _onCompanyButtonClicked() {
    setState(() {
      _pageState = JobDescriptionPageState.company;
    });
  }

  void _onDescriptionButtonClicked() {
    setState(() {
      _pageState = JobDescriptionPageState.description;
    });
  }

  void _onProceedToApplyClick() {
    setState(() {
      _pageState = JobDescriptionPageState.apply;
    });
  }

  Widget _buildCompanyDescriptionFragment() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "About Company",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem ...",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: mulledWine,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Website",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "www.ubuntu.org",
            textAlign: TextAlign.left,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blueAccent,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Industry",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Operating system",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: mulledWine,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Employee size",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "121,145 Employees",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: mulledWine,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Head Office",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Naya Bazar, Chittagong",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: mulledWine,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Type",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Multinational Company",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: mulledWine,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Since",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "1998",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: mulledWine,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Specialisation",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Operating system, Open Source, FOSS Movement, IOT",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: mulledWine,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Company Gallery",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(
                    "https://i.dailymail.co.uk/i/pix/2015/05/19/17/28DDC0C500000578-3088186-image-m-4_1432053736097.jpg",
                    fit: BoxFit.cover,
                    height: 158.0,
                    width: 115.0,
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(
                    "https://i.dailymail.co.uk/i/pix/2015/05/19/17/28DDC0C500000578-3088186-image-m-4_1432053736097.jpg",
                    fit: BoxFit.cover,
                    height: 158.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(left: 22.0),
        child: GestureDetector(
          onTap: _onProceedToApplyClick,
          child: PrimaryActionButton(
            buttonText: _pageState.name == JobDescriptionPageState.apply.name
                ? "apply now"
                : "proceed to apply",
            width: 270.0,
          ),
        ),
      ),
    );
  }

  Widget _buildJobShortDesc() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Image.network(
            "https://cdn1.iconfinder.com/data/icons/metro-ui-dock-icon-set--icons-by-dakirby/512/Ubuntu_alt.png",
            height: 84,
            width: 84,
          ),
        ),
        const SizedBox(height: 14),
        const Text(
          "UI/UX Designer",
          style: TextStyle(
            color: nightBlue,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              "Ubuntu",
              style: TextStyle(
                color: nightBlue,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            Text(
              "•",
              style: TextStyle(
                color: nightBlue,
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
            Text(
              "California",
              style: TextStyle(
                color: nightBlue,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            Text(
              "•",
              style: TextStyle(
                color: nightBlue,
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
            Text(
              "1 day ago",
              style: TextStyle(
                color: nightBlue,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => _navigateBack(context),
          child: SvgPicture.asset(
            "assets/images/svgs/ic_back_arrow.svg",
            height: 24,
            width: 24,
          ),
        ),
        SvgPicture.asset(
          "assets/images/svgs/ic_more_vert.svg",
          height: 24,
          width: 24,
        ),
      ],
    );
  }

  Widget _buildJobDescriptionFragment() {
    return Column(
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Job Description",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem ...",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: mulledWine,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.topLeft,
          child: PrimaryActionButton(
            buttonText: "Read more",
            width: 91,
            height: 30.0,
            buttonTextFontSize: 12.0,
            buttonTextColor: darkIndigo,
            buttonColor: blueLotus.withOpacity(0.3),
          ),
        ),
        const SizedBox(height: 25),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Requirements",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "• Lorem Ispum Lorem\n• Lorem Ispum Loremdadf fdskfasdkj \n• Lorem Ispum Lorem\n• Lorem Ispum Lorem"
            "\n• Lorem Ispum Lorem",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: mulledWine,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Location",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Shapla Abashik Jame Mosjid Rd, Chattogram",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: mulledWine,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 15),
        _buildGoogleMapPreview(),
        const SizedBox(height: 25),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Information",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Position",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "UI/UX Designer",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Divider(
          thickness: 0.8,
          color: tealishBlue,
        ),
        const SizedBox(height: 15),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Qualification",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Bachelor's Degree",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Divider(
          thickness: 0.8,
          color: tealishBlue,
        ),
        const SizedBox(height: 15),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Job Type",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Full-time",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Divider(
          thickness: 0.8,
          color: tealishBlue,
        ),
        const SizedBox(height: 15),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Specialisation",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Design",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Divider(
          thickness: 0.8,
          color: tealishBlue,
        ),
        const SizedBox(height: 15),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Facilities and others",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 5),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "• The main job is to run & monitor sales & marketing department.\n• Execute physical & digital marketing plan as per market feedback.\n• Generate innovative marketing ideas for promoting software products like ERP, Retail POS, Accounting applications etc.",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: blackHaiti,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Divider(
          thickness: 0.8,
          color: tealishBlue,
        ),
      ],
    );
  }

  Widget _buildGoogleMapPreview() {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: GoogleMap(
        compassEnabled: false,
        trafficEnabled: false,
        scrollGesturesEnabled: false,
        zoomControlsEnabled: false,
        buildingsEnabled: false,
        myLocationEnabled: false,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        myLocationButtonEnabled: false,
        mapToolbarEnabled: false,
        indoorViewEnabled: false,
        zoomGesturesEnabled: false,
        liteModeEnabled: false,
        onMapCreated: _onMapCreated,
        markers: {
          Marker(
            markerId: const MarkerId("bugicugi"),
            position: _center,
            infoWindow: const InfoWindow(
              title: "Ubuntu",
              snippet: "Shapla Abashik Jame Mosjid Rd, Chattogram",
            ),
          )
        },
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 15.0,
        ),
      ),
    );
  }
}
