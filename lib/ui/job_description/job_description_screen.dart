import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:job_spot/common/theme/colors.dart';
import 'package:job_spot/ui/widgets/primary_action_button.dart';

const jobDescScreenNavRouteName = "job_description_screen/";

class JobDescriptionScreen extends StatefulWidget {
  const JobDescriptionScreen({Key? key}) : super(key: key);

  @override
  State<JobDescriptionScreen> createState() => _JobDescriptionScreenState();
}

class _JobDescriptionScreenState extends State<JobDescriptionScreen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(22.313999275669637, 91.80758944137361);

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _navigateBack(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 22.0),
            child: Column(
              children: [
                _buildActionBar(context),
                const SizedBox(height: 20),
                _buildJobShortDesc(),
                const SizedBox(height: 25),
                _buildCompanyDescriptionFragment(),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildCompanyDescriptionFragment() {
    return Column(
      children: [
        Align(
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
        SizedBox(height: 10),
        Align(
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
        SizedBox(height: 20),
        Align(
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
        SizedBox(height: 10),
        Align(
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
        SizedBox(height: 20),
        Align(
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
        SizedBox(height: 10),
        Align(
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
        SizedBox(height: 20),
        Align(
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
        SizedBox(height: 10),
        Align(
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
        SizedBox(height: 20),
        Align(
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
        SizedBox(height: 10),
        Align(
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
        SizedBox(height: 20),
        Align(
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
        SizedBox(height: 10),
        Align(
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
        SizedBox(height: 20),
        Align(
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
        SizedBox(height: 10),
        Align(
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
        SizedBox(height: 20),
        Align(
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
        SizedBox(height: 10),
        Align(
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
        SizedBox(height: 20),
        Align(
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
        SizedBox(height: 10),
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
        child: const PrimaryActionButton(
          buttonText: "proceed to apply",
          width: 270.0,
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
            "* Lorem Ispum Lorem\n* Lorem Ispum Lorem\n* Lorem Ispum Lorem\n* Lorem Ispum Lorem\n* Lorem Ispum Lorem",
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

  SizedBox _buildGoogleMapPreview() {
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
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
          liteModeEnabled: true,
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
      ),
    );
  }
}
