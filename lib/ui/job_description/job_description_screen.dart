import 'package:flutter/material.dart';
import 'package:job_spot/common/theme/colors.dart';
import 'package:job_spot/ui/widgets/primary_action_button.dart';

const jobDescScreenNavRouteName = "job_description_screen/";

class JobDescriptionScreen extends StatefulWidget {
  const JobDescriptionScreen({Key? key}) : super(key: key);

  @override
  State<JobDescriptionScreen> createState() => _JobDescriptionScreenState();
}

class _JobDescriptionScreenState extends State<JobDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
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
                const SizedBox(height: 50),
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(left: 22.0),
          child: const PrimaryActionButton(
            buttonText: "APPLY NOW",
            width: 270.0,
          ),
        ),
      ),
    );
  }
}
