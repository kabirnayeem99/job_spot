import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:job_spot/common/utility/utility.dart';
import 'package:job_spot/domain/entity/company_description.dart';
import 'package:job_spot/domain/entity/job_type.dart';
import 'package:job_spot/ui/widgets/image.dart';

import '../../common/theme/colors.dart';
import '../../domain/entity/job_description.dart';
import '../../domain/entity/job_description_page_state.dart';
import '../widgets/primary_action_button.dart';

const jobDescScreenNavRouteName = "job_description_screen/";

class JobDescriptionScreen extends StatefulWidget {
  const JobDescriptionScreen({Key? key}) : super(key: key);

  @override
  State<JobDescriptionScreen> createState() => _JobDescriptionScreenState();
}

class _JobDescriptionScreenState extends State<JobDescriptionScreen> {
  JobDescriptionPageState _pageState = JobDescriptionPageState.description;
  final jobDescription = JobDescription.generateMockJobDescription();
  final companyDescription =
      CompanyDescription.generateMockCompanyDescription();

  late GoogleMapController mapController;

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

  var filaneName = "Jamet kudos - CV - UI/UX Designer";

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
              children: [
                Text(
                  filaneName,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: blackHaiti,
                  ),
                ),
                const SizedBox(height: 5.0),
                const Text(
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

        final file = files[0];
        final name = file.path.split('/').last;

        setState(() {
          filaneName = name;
        });

        logger.w("file name -> $name");
      } else {
        logger.w("no file was selected");
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            companyDescription.about,
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            companyDescription.website,
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "${companyDescription.employees} Employees",
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            companyDescription.headOfficeAddress,
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            companyDescription.type,
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "${companyDescription.foundationDate}",
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            companyDescription.specialisation,
            textAlign: TextAlign.left,
            style: const TextStyle(
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
                  child: RemoteImage(
                    imageUrl: companyDescription.companyGalleryImages[0],
                    height: 158.0,
                    width: 115.0,
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: RemoteImage(
                    imageUrl: companyDescription.companyGalleryImages[1],
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
          child: (jobDescription.companyLogoImageUrl ?? "").isNotEmpty
              ? RemoteImage(
                  imageUrl: jobDescription.companyLogoImageUrl ?? "",
                  height: 84,
                  width: 84,
                )
              : const SizedBox(
                  height: 84,
                  width: 84,
                ),
        ),
        const SizedBox(height: 14),
        Text(
          jobDescription.title ?? "",
          style: const TextStyle(
            color: nightBlue,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              jobDescription.companyName ?? "",
              style: const TextStyle(
                color: nightBlue,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const Text(
              "•",
              style: TextStyle(
                color: nightBlue,
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
            Text(
              jobDescription.city ?? "",
              style: const TextStyle(
                color: nightBlue,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const Text(
              "•",
              style: TextStyle(
                color: nightBlue,
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
            Text(
              jobDescription.timePassed ?? "Just now",
              style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            jobDescription.shortDescription ?? "",
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            jobDescription.requirements ?? "",
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            jobDescription.location?.fullAddress ?? "",
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            jobDescription.title ?? "",
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            jobDescription.qualification ?? "",
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            getJobTypeDisplayNameByEnum(
                jobDescription.jobType ?? JobType.fullTime),
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            jobDescription.specialisation ?? "",
            textAlign: TextAlign.left,
            style: const TextStyle(
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
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            jobDescription.facilities ?? "",
            textAlign: TextAlign.left,
            style: const TextStyle(
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
            position: LatLng(jobDescription.location?.latitude ?? 0.0,
                jobDescription.location?.longitude ?? 0.0),
            infoWindow: InfoWindow(
              title: jobDescription.companyName ?? "",
              snippet: jobDescription.location?.fullAddress ?? "",
            ),
          )
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(jobDescription.location?.latitude ?? 0.0,
              jobDescription.location?.longitude ?? 0.0),
          zoom: 15.0,
        ),
      ),
    );
  }
}
