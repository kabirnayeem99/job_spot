import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  Scaffold _buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _JobDescriptionActionBar(),
              const SizedBox(height: 20),
              _JobShortDescription(),
              const SizedBox(height: 20),
              const _TabButtons(),
              SizedBox(height: 25, child: Container(color: whiteSnowDrift)),
              const _TabFragmentsContainer(),
              SizedBox(height: 1000, child: Container(color: whiteSnowDrift)),
            ],
          ),
        ),
      ),
      floatingActionButton: const _FloatingActionButton(),
    );
  }
}

class _TabFragmentsContainer extends StatefulWidget {
  const _TabFragmentsContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<_TabFragmentsContainer> createState() => _TabFragmentsContainerState();
}

class _TabFragmentsContainerState extends State<_TabFragmentsContainer> {
  @override
  Widget build(BuildContext context) {
    final JobDescriptionCubit bloc = BlocProvider.of(context);

    return BlocBuilder<JobDescriptionCubit, JobDescriptionState>(
      bloc: bloc,
      buildWhen: (pre, cur) => pre.pageState.name != cur.pageState.name,
      builder: (context, state) {
        late Widget fragment;

        final isDescriptionPageShowing = bloc.state.pageState.name ==
            JobDescriptionPageState.description.name;
        final isCompanyDescriptionPageShowing =
            bloc.state.pageState.name == JobDescriptionPageState.company.name;
        final isApplicationPageShowing =
            bloc.state.pageState.name == JobDescriptionPageState.apply.name;

        if (isDescriptionPageShowing) {
          fragment = const _JobDescriptionFragment();
        } else if (isCompanyDescriptionPageShowing) {
          fragment = const _CompanyDescriptionFragment();
        } else if (isApplicationPageShowing) {
          fragment = const _JobApplyFragment();
        } else {
          fragment = const _AppliedFragment();
        }

        return Flexible(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              color: whiteSnowDrift,
              padding: const EdgeInsets.only(left: 22.0, right: 22.0),
              duration: const Duration(milliseconds: 160),
              child: fragment,
            ),
          ),
        );
      },
    );
  }
}

class _AppliedFragment extends StatelessWidget {
  const _AppliedFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JobDescriptionCubit bloc = BlocProvider.of(context);
    return Column(
      children: [
        const SizedBox(height: 12.0),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            color: antiFlashWhite,
            width: double.infinity,
            child: Row(
              children: [
                const Icon(
                  UniconsLine.document_info,
                  size: 54.0,
                  color: lightRed,
                ),
                const SizedBox(width: 15.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.9,
                      child: Text(
                        getFileNameFromFile(bloc.state.file),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      "${getFileSize(bloc.state.file)}  • 12 Feb 2022 on 11:00 PM",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          const TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        SvgPicture.asset(
          "assets/images/svgs/banner_success.svg",
          height: 120.0,
          width: 120.0,
        ),
        const SizedBox(height: 22.0),
        const Text(
          "Successfull",
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12.0),
        const Text("Congratulations, your application has been sent"),
        const SizedBox(height: 30.0),
        const PrimaryActionButton(
          buttonText: "find a similiar job",
          buttonColor: purpleBlueMoonraker,
          buttonTextColor: deepViolet,
        ),
        const SizedBox(height: 20.0),
        const PrimaryActionButton(
          buttonText: "back to home",
          buttonColor: deepViolet,
          buttonTextColor: Colors.white,
        ),
      ],
    );
  }
}

class _JobDescriptionFragment extends StatelessWidget {
  const _JobDescriptionFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JobDescriptionCubit bloc = BlocProvider.of(context);

    return BlocBuilder<JobDescriptionCubit, JobDescriptionState>(
      bloc: bloc,
      buildWhen: (pre, cur) => pre.jobDescription != cur.jobDescription,
      builder: (context, state) {
        final facilities = state.jobDescription?.facilities ?? "N/A";
        final shortDescription =
            state.jobDescription?.shortDescription ?? "N/A";
        final requirements = state.jobDescription?.requirements ?? "N/A";
        final location = state.jobDescription?.location?.fullAddress ?? "N/A";
        final title = state.jobDescription?.title ?? "N/A";
        final qualification = state.jobDescription?.qualification ?? "N/A";
        final specialisation = state.jobDescription?.specialisation ?? "N/A";
        final jobType = getJobTypeDisplayNameByEnum(
          state.jobDescription?.jobType ?? JobType.fullTime,
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
            const _GoogleMapPreview(),
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
      },
    );
  }
}

class _TabButtons extends StatelessWidget {
  const _TabButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JobDescriptionCubit bloc = BlocProvider.of(context);

    return BlocBuilder<JobDescriptionCubit, JobDescriptionState>(
      bloc: bloc,
      buildWhen: (pre, cur) => pre.pageState != cur.pageState,
      builder: (context, state) {
        final currentlySelectedTabName = state.pageState.name;
        final shouldNotShowAnyTab = currentlySelectedTabName ==
                JobDescriptionPageState.apply.name ||
            currentlySelectedTabName == JobDescriptionPageState.applied.name;
        final isCompanySelected =
            currentlySelectedTabName == JobDescriptionPageState.company.name;
        if (shouldNotShowAnyTab) {
          return Container();
        } else {
          return Container(
            color: whiteSnowDrift,
            padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 12.0),
            child: Row(
              children: [
                _DescriptionTabIndicatorButton(isCompanySelected),
                const SizedBox(width: 9),
                _CompanyTabIndicatorButton(isCompanySelected),
              ],
            ),
          );
        }
      },
    );
  }
}

class _CompanyDescriptionFragment extends StatelessWidget {
  const _CompanyDescriptionFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JobDescriptionCubit bloc = BlocProvider.of(context);
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
}

class _JobApplyFragment extends StatelessWidget {
  const _JobApplyFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: const [
          Align(
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
          SizedBox(height: 10),
          Align(
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
          SizedBox(height: 20),
          _UploadCvButtonBox(),
          SizedBox(height: 30),
          Align(
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
          SizedBox(height: 15),
          _ResumeTextBox(),
        ],
      ),
    );
  }
}

class _ResumeTextBox extends StatelessWidget {
  const _ResumeTextBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class _GoogleMapPreview extends StatelessWidget {
  const _GoogleMapPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<JobDescriptionCubit>(context);

    return BlocBuilder<JobDescriptionCubit, JobDescriptionState>(
      bloc: bloc,
      builder: (context, state) {
        final lat = state.jobDescription?.location?.latitude ?? 0.0;
        final lng = state.jobDescription?.location?.longitude ?? 0.0;
        final companyName = state.jobDescription?.companyName ?? "";
        final fullAddress = state.jobDescription?.location?.fullAddress ?? "";

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
            markers: {
              Marker(
                markerId: const MarkerId("bugicugi"),
                position: LatLng(lat, lng),
                infoWindow:
                    InfoWindow(title: companyName, snippet: fullAddress),
              )
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, lng),
              zoom: 15.0,
            ),
          ),
        );
      },
    );
  }
}

class _CompanyTabIndicatorButton extends StatelessWidget {
  const _CompanyTabIndicatorButton(this.isCompanySelected);

  final bool isCompanySelected;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<JobDescriptionCubit>(context);
    return Expanded(
      child: GestureDetector(
        onTap: () async => bloc.loadCompanyData(),
        child: PrimaryActionButton(
          buttonText: "Company",
          buttonTextColor: isCompanySelected ? darkIndigo : mercuryBlue,
          buttonColor: isCompanySelected ? purpleBlueMoonraker : darkIndigo,
        ),
      ),
    );
  }
}

class _DescriptionTabIndicatorButton extends StatelessWidget {
  const _DescriptionTabIndicatorButton(this.isCompanyTabSelected);

  final bool isCompanyTabSelected;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () async =>
            BlocProvider.of<JobDescriptionCubit>(context).loadDescriptionData(),
        child: PrimaryActionButton(
          buttonText: "Description",
          buttonTextColor: isCompanyTabSelected ? mercuryBlue : darkIndigo,
          buttonColor: isCompanyTabSelected ? darkIndigo : purpleBlueMoonraker,
        ),
      ),
    );
  }
}

class _UploadCvButtonBox extends StatelessWidget {
  const _UploadCvButtonBox();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<JobDescriptionCubit>(context);

    return GestureDetector(
      onTap: () async => _pickPdfFiles(context),
      child: DottedBorder(
        color: mulledWine.withOpacity(0.5),
        strokeWidth: 1.2,
        radius: const Radius.circular(14.0),
        borderType: BorderType.RRect,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(14)),
          child: Container(
            color: bluePurpleAmethystSmoke.withOpacity(0.0),
            width: double.infinity,
            child: bloc.state.file == null
                ? const _BeforeUploadBox()
                : _AfterUploadBox(),
          ),
        ),
      ),
    );
  }

  Future<void> _pickPdfFiles(BuildContext context) async {
    final bloc = BlocProvider.of<JobDescriptionCubit>(context);

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
}

class _AfterUploadBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<JobDescriptionCubit>(context);
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
}

class _BeforeUploadBox extends StatelessWidget {
  const _BeforeUploadBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<JobDescriptionCubit>(context);

    return BlocBuilder<JobDescriptionCubit, JobDescriptionState>(
      bloc: bloc,
      builder: (context, state) {
        final actionButtonText =
            state.pageState.name == JobDescriptionPageState.apply.name
                ? "apply now"
                : "proceed to apply";

        return AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: state.pageState.name == JobDescriptionPageState.applied.name
              ? 0.0
              : 1.0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(left: 22.0),
              child: GestureDetector(
                onTap: () async => actionButtonText == "apply now"
                    ? bloc.loadAppliedData()
                    : bloc.loadApplicationData(),
                child: PrimaryActionButton(
                  buttonText: actionButtonText,
                  width: 270.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _JobShortDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<JobDescriptionCubit>(context).state;
    final title = state.jobDescription?.title ?? "N/A";
    final companyName = state.jobDescription?.companyName ?? "N/A";
    final companyLogoImageUrl = state.jobDescription?.companyLogoImageUrl ?? "";
    final city = state.jobDescription?.city ?? "N/A";
    final timePassed = state.jobDescription?.timePassed ?? "Just now";

    return Container(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0),
      child: Column(
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
                companyName,
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
                city,
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
                timePassed,
                style: const TextStyle(
                  color: nightBlue,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _JobDescriptionActionBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 22.0),
      child: Row(
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
      ),
    );
  }

  Future<void> _navigateBack(BuildContext context) async =>
      FluroRouter.appRouter.pop(context);
}
