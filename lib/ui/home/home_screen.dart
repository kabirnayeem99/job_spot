import 'package:floading/floading.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_spot/ui/home/bloc/home_cubit.dart';

import '../../common/theme/colors.dart';
import '../../domain/entity/job_preview.dart';
import '../../domain/entity/offer.dart';
import '../job_description/job_description_screen.dart';
import '../widgets/secondary_action_button.dart';
import 'bloc/home_state.dart';
import 'widgets/job_list_item_container.dart';

const homeScreenNavRouteName = "home_screen/";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FluroRouter? router;
  HomeCubit? bloc = HomeCubit();

  @override
  void initState() {
    bloc ??= HomeCubit();
    super.initState();
    router ??= FluroRouter.appRouter;
  }

  @override
  void dispose() {
    bloc = null;
    router = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (_) => bloc ?? HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          _showUserMessage(state);
          _showLoadingIndicatorWhileNeeded(state);
        },
        builder: (context, state) => _buildPage(),
      ),
    );
  }

  void _showUserMessage(HomeState state) {
    final isThereNotMessageToShow = (state.userMessages?.isEmpty ?? true);
    if (isThereNotMessageToShow) return;

    final userMessage = state.userMessages?.first;
    if (userMessage == null) return;

    final snackBar = SnackBar(content: Text(userMessage.message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    bloc?.userMessageShown(userMessage.id);
  }

  void _showLoadingIndicatorWhileNeeded(HomeState state) {
    if (state.isLoading == null) FLoading.hide(context: context);

    if (state.isLoading!) FLoading.show(context);
    if (!state.isLoading!) FLoading.hide(context: context);
  }

  Scaffold _buildPage() {
    return Scaffold(
      backgroundColor: whiteSnowDrift,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 22.0, right: 22.0, top: 18),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _HomeAppBar(
                  fullUserName: bloc?.state.fullUserName ?? "",
                  userProfilePictureUrl:
                      bloc?.state.userProfilePictureUrl ?? "",
                ),
                const SizedBox(height: 38.0),
                _OfferSlider(offers: bloc?.state.offers ?? []),
                const SizedBox(height: 24.0),
                const _FindYourJobTitle(),
                const SizedBox(height: 24.0),
                const _JobOverViewGrid(
                  remoteJobsCount: 44000,
                  fullTimeJobCount: 10000,
                  partTimeJobCount: 12000,
                ),
                const SizedBox(height: 19.0),
                const _RecentJobTitle(),
                const SizedBox(height: 16.0),
                _RecentJobList(recentJobs: bloc?.state.recentJobs ?? []),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecentJobTitle extends StatelessWidget {
  const _RecentJobTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topLeft,
      child: Text(
        "Recent Job List",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _JobOverViewGrid extends StatelessWidget {
  const _JobOverViewGrid({
    Key? key,
    required this.remoteJobsCount,
    required this.fullTimeJobCount,
    required this.partTimeJobCount,
  }) : super(key: key);

  final int remoteJobsCount;
  final int fullTimeJobCount;
  final int partTimeJobCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _RemoteJobsCounterGridItem(remoteJobsCount: remoteJobsCount),
        const SizedBox(width: 20.0),
        Expanded(
          child: SizedBox(
            height: 170.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _FullTimeJobsCounterGridItem(
                    fullTimeJobCount: fullTimeJobCount),
                _PartTimeJobsCounterGridItem(
                    partTimeJobCount: partTimeJobCount),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _PartTimeJobsCounterGridItem extends StatelessWidget {
  const _PartTimeJobsCounterGridItem({
    Key? key,
    required this.partTimeJobCount,
  }) : super(key: key);

  final int partTimeJobCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: orangeLightApricot,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$partTimeJobCount",
            style: const TextStyle(
              color: nightBlue,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Text(
            "Part Time",
            style: TextStyle(
              color: nightBlue,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _FullTimeJobsCounterGridItem extends StatelessWidget {
  const _FullTimeJobsCounterGridItem({
    Key? key,
    required this.fullTimeJobCount,
  }) : super(key: key);

  final int fullTimeJobCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 75.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: violetPale,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$fullTimeJobCount",
            style: const TextStyle(
              color: nightBlue,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Text(
            "Full Time",
            style: TextStyle(
              color: nightBlue,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _RemoteJobsCounterGridItem extends StatelessWidget {
  const _RemoteJobsCounterGridItem({
    Key? key,
    required this.remoteJobsCount,
  }) : super(key: key);

  final int remoteJobsCount;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 170.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: bluishCyanFrenchPass,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.compass,
              size: 34.0,
              color: darkIndigo,
            ),
            Text(
              "$remoteJobsCount",
              style: const TextStyle(
                color: nightBlue,
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Text(
              "Remote Jobs",
              style: TextStyle(
                color: nightBlue,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar({
    Key? key,
    required this.fullUserName,
    required this.userProfilePictureUrl,
  }) : super(key: key);

  final String fullUserName;
  final String userProfilePictureUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            (fullUserName.isNotEmpty ? "Hello, \n$fullUserName" : "Welcome"),
            style: const TextStyle(
              color: nightBlue,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(child: Container()),
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: userProfilePictureUrl.isNotEmpty
              ? Image.network(
                  userProfilePictureUrl,
                  fit: BoxFit.fill,
                  height: 40.0,
                  width: 40.0,
                )
              : SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Container(color: nightBlue),
                ),
        ),
      ],
    );
  }
}

class _RecentJobList extends StatelessWidget {
  const _RecentJobList({
    Key? key,
    required this.recentJobs,
  }) : super(key: key);

  final List<JobPreview> recentJobs;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: recentJobs.length,
        itemBuilder: (context, position) {
          return _JobItem(job: recentJobs[position]);
        },
      ),
    );
  }
}

class _JobItem extends StatelessWidget {
  _JobItem({
    Key? key,
    required this.job,
  }) : super(key: key);

  final FluroRouter? router = FluroRouter.appRouter;
  final JobPreview job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => _navigateToJobDetailsScreen(context),
      child: JobListItemContainer(job: job),
    );
  }

  Future<void> _navigateToJobDetailsScreen(BuildContext context) async {
    router?.navigateTo(context, jobDescScreenNavRouteName,
        transition: TransitionType.cupertino);
  }
}

class _FindYourJobTitle extends StatelessWidget {
  const _FindYourJobTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topLeft,
      child: Text(
        "Find Your Job",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _OfferSlider extends StatelessWidget {
  const _OfferSlider({
    Key? key,
    required this.offers,
  }) : super(key: key);

  final List<Offer> offers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 17.0),
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: darkIndigo,
      ),
      child: offers.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Container()),
                Text(
                  offers.first.message,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 17.0),
                const SecondaryActionButton(buttonText: "Join Now"),
                Expanded(child: Container()),
              ],
            )
          : Container(),
    );
  }
}
