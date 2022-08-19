import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:unicons/unicons.dart';

import '../../common/theme/colors.dart';
import '../../common/utility/utility.dart';
import '../../domain/entity/job_description_page_state.dart';
import '../../domain/entity/job_type.dart';
import '../widgets/image.dart';
import '../widgets/primary_action_button.dart';
import 'bloc/job_description_cubit.dart';

const jobDescScreenNavRouteName = "job_description_screen/";

class JobDescriptionScreen extends StatefulWidget {
  const JobDescriptionScreen({Key? key}) : super(key: key);

  @override
  State<JobDescriptionScreen> createState() => _JobDescriptionScreenState();
}

class _JobDescriptionScreenState extends State<JobDescriptionScreen> {
  late JobDescriptionCubit bloc = GetIt.I.get<JobDescriptionCubit>();
  late FluroRouter router = FluroRouter.appRouter;

  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    bloc = JobDescriptionCubit()..loadJobDescription("afasdf");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JobDescriptionCubit>(
      create: (_) => bloc,
      child: BlocBuilder<JobDescriptionCubit, JobDescriptionState>(
        bloc: bloc,
        builder: (context, state) => _buildPage(context),
      ),
    );
    //
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Scaffold _buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f7),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 22.0),
            child: Column(
              children: [
                const _JobDescriptionActionBar(),
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
    if (bloc.state.pageState.name == JobDescriptionPageState.description.name) {
      fragment = _buildJobDescriptionFragment();
    } else if (bloc.state.pageState.name ==
        JobDescriptionPageState.company.name) {
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
      onTap: () async => _pickPdfFiles(),
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
            child: bloc.state.file == null
                ? _buildBeforeUploadBox()
                : _buildAfterUploadBox(),
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
            const Icon(
              UniconsLine.document_info,
              color: lightRed,
              size: 44.0,
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getFileNameFromFile(bloc.state.file),
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: blackHaiti,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  "${getFileSize(bloc.state.file)} MB * 14 Feb 2022 at 11:30 am",
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: spanPearl,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 27.0),
        GestureDetector(
          onTap: () => {bloc.removeFile()},
          child: Row(
            children: const [
              SizedBox(width: 21.0),
              Icon(UniconsLine.trash_alt, color: lightRed),
              SizedBox(width: 10.0),
              Text(
                "Remove file",
                style: TextStyle(
                  color: lightRed,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }

  Widget _buildBeforeUploadBox() {
    return SizedBox(
      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            UniconsLine.upload_alt,
            size: 24.0,
            color: mulledWine,
          ),
          SizedBox(width: 17.0),
          Text(
            "Upload CV/Resume",
            style: TextStyle(color: mulledWine, fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  void _pickPdfFiles() async {
    try {
      var result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['pdf']);
      bloc.selectedFilePickerResult(result);
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Widget _buildTabButtons() {
    final currentlySelectedTabName = bloc.state.pageState.name;

    final shouldShowCompanyTab =
        currentlySelectedTabName == JobDescriptionPageState.company.name;

    return currentlySelectedTabName == JobDescriptionPageState.apply.name
        ? Container()
        : Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async => bloc.loadDescriptionData(),
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
                  onTap: () async => bloc.loadCompanyData(),
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
            bloc.state.companyDescription?.about ?? "",
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
            bloc.state.companyDescription?.website ?? "N/A",
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
            "${bloc.state.companyDescription?.employees ?? "N/A"} Employees",
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
            bloc.state.companyDescription?.headOfficeAddress ?? "N/A",
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
            bloc.state.companyDescription?.type ?? "N/A",
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
            "${bloc.state.companyDescription?.foundationDate ?? "N/A"}",
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
            bloc.state.companyDescription?.specialisation ?? "N/A",
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
                    imageUrl: bloc.state.companyDescription
                            ?.companyGalleryImages[0] ??
                        "",
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
                    imageUrl: bloc.state.companyDescription
                            ?.companyGalleryImages[1] ??
                        "",
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
          onTap: () async => bloc.loadApplicationData(),
          child: PrimaryActionButton(
            buttonText:
                bloc.state.pageState.name == JobDescriptionPageState.apply.name
                    ? "apply now"
                    : "proceed to apply",
            width: 270.0,
          ),
        ),
      ),
    );
  }

  Widget _buildJobShortDesc() {
    final companyLogoImageUrl =
        bloc.state.jobDescription?.companyLogoImageUrl ?? "";
    final jobDescription = bloc.state.jobDescription?.title ?? "";
    return _JobShortDescription(
      companyLogoImageUrl: companyLogoImageUrl,
      jobDescription: jobDescription,
    );
  }

  Widget _buildJobDescriptionFragment() {
    final facilities = bloc.state.jobDescription?.facilities ?? "N/A";
    final shortDescription =
        bloc.state.jobDescription?.shortDescription ?? "N/A";
    final requirements = bloc.state.jobDescription?.requirements ?? "N/A";
    final location = bloc.state.jobDescription?.location?.fullAddress ?? "N/A";
    final title = bloc.state.jobDescription?.title ?? "N/A";
    final qualification = bloc.state.jobDescription?.qualification ?? "N/A";
    final specialisation = bloc.state.jobDescription?.specialisation ?? "N/A";
    final jobType = getJobTypeDisplayNameByEnum(
      bloc.state.jobDescription?.jobType ?? JobType.fullTime,
    );

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
            shortDescription,
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
            requirements,
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
            location,
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
            title,
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
            qualification,
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
            jobType,
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
            specialisation,
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
            facilities,
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
    final lat = bloc.state.jobDescription?.location?.latitude ?? 0.0;
    final lng = bloc.state.jobDescription?.location?.longitude ?? 0.0;
    final companyName = bloc.state.jobDescription?.companyName ?? "";
    final fullAddress = bloc.state.jobDescription?.location?.fullAddress ?? "";

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
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(title: companyName, snippet: fullAddress),
          )
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lng),
          zoom: 15.0,
        ),
      ),
    );
  }
}

class _JobShortDescription extends StatelessWidget {
  const _JobShortDescription({
    Key? key,
    required this.companyLogoImageUrl,
    required this.title,
  }) : super(key: key);

  final String companyLogoImageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: companyLogoImageUrl.isNotEmpty
              ? RemoteImage(
                  imageUrl: companyLogoImageUrl,
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
          title,
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
              bloc.state.jobDescription?.companyName ?? "",
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
              bloc.state.jobDescription?.city ?? "",
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
              bloc.state.jobDescription?.timePassed ?? "Just now",
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
}

class _JobDescriptionActionBar extends StatelessWidget {
  const _JobDescriptionActionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async => _navigateBack(context),
          child: const Icon(
            UniconsLine.angle_left_b,
            size: 32.0,
          ),
        ),
        const Icon(
          UniconsLine.ellipsis_v,
          size: 28.0,
        ),
      ],
    );
  }

  Future<void> _navigateBack(BuildContext context) async =>
      FluroRouter.appRouter.pop(context);
}
