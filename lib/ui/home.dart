import 'package:flutter/material.dart';
import 'package:portfolio_app/constants/assets.dart';
import 'package:portfolio_app/constants/fonts.dart';
import 'package:portfolio_app/constants/strings.dart';
import 'package:portfolio_app/constants/text_styles.dart';
import 'package:portfolio_app/models/education.dart';
import 'package:portfolio_app/models/experience.dart';
import 'package:portfolio_app/models/projects.dart';
import 'package:portfolio_app/utils/screen/screen_utils.dart';
import 'package:portfolio_app/widgets/responsive_widget.dart';
import 'dart:html' as html;

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF7F8FA),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (ScreenUtil.getInstance().setWidth(90))), //144
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(context),
          drawer: _buildDrawer(context),
          body: LayoutBuilder(builder: (context, constraints) {
            return _buildBody(context, constraints);
          }),
        ),
      ),
    );
  }


  AppBar? _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: ResponsiveWidget.isSmallScreen(context)? true : false,
      titleSpacing: 0.0,
      title: _buildTitle(),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions:
          !ResponsiveWidget.isSmallScreen(context) ? _buildActions() : null,
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Strings.portfoli,
            style: TextStyles.logo,
          ),
          TextSpan(
            text: Strings.o,
            style: TextStyles.logo.copyWith(
              color: const Color(0xFF50AFC0),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      MaterialButton(
        child: Text(
          Strings.downloadResume,
          style: TextStyles.menuItem.copyWith(
            color: const Color(0xFF50AFC0),
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
            html.window.open("https://drive.google.com/file/d/1Q0n4ef_XDAtDPVq_LOqZ8CJVy-OMXryV/view?usp=sharing", "Resume");
        },
      ),
    ];
  }


  Drawer? _buildDrawer(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Drawer(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: _buildActions(),
            ),
          )
        : null;
  }


  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
        child: ResponsiveWidget(
          largeScreen: _buildLargeScreen(context),
          mediumScreen: _buildMediumScreen(context),
          smallScreen: _buildSmallScreen(context),
        ),
      ),
    );
  }


  Widget _buildLargeScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildContent(context)),
                // _buildIllustration(),
              ],
            ),
          ),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildMediumScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildContent(context)),
              ],
            ),
          ),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildSmallScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(flex: 1, child: _buildContent(context)),
          const Divider(),
          _buildCopyRightText(context),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
          _buildSocialIcons(),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
        ],
      ),
    );
  }


  Widget _buildIllustration() {
    return Image.network(
      Assets.programmer3,
      height: ScreenUtil.getInstance().setWidth(250), //480.0
    );
  }

  Widget _buildIntroSection(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 0.0),
        _buildAboutMe(context),
        const SizedBox(height: 4.0),
        _buildHeadline(context),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 24.0),
        _buildSummary(),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 48.0),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ResponsiveWidget.isSmallScreen(context) 
          ? _buildIntroSection(context)
          : Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildIntroSection(context)),
                _buildIllustration(),
              ],
            ),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 24.0),
        ResponsiveWidget.isSmallScreen(context)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildExperience(),
                const SizedBox(height: 24.0),
                _buildEducation(),
                const SizedBox(height: 24.0),
                _buildProjects(),
                const SizedBox(height: 24.0),
                _buildSkills(context),
              ],
            )
          : _buildSkillsAndEducation(context)
      ],
    );
  }

  Widget _buildAboutMe(BuildContext context) {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Strings.about,
            style: TextStyles.heading.copyWith(
              fontFamily: Fonts.nexaLight,
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
          TextSpan(
            text: Strings.me,
            style: TextStyles.heading.copyWith(
              color: const Color(0xFF50AFC0),
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Text(
      ResponsiveWidget.isSmallScreen(context)
          ? Strings.headline
          : Strings.headline.replaceFirst(RegExp(r" f"), "\nf"),
      style: TextStyles.subHeading,
    );
  }

  Widget _buildSummary() {
    return Padding(
      padding: const EdgeInsets.only(right: 80.0),
      child: Text(
        Strings.summary,
        style: TextStyles.body,
      ),
    );
  }

  Widget _buildSkillsAndEducation(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _buildExperience(),
            ),
            const SizedBox(width: 40.0),
            Expanded(
              flex: 1,
              child: _buildEducation(),
            ),
            const SizedBox(width: 40.0),
            Expanded(
              flex: 1,
              child: _buildSkills(context),
            ),
          ],
        ),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 30.0),
        _buildProjects(),
      ],
    );
  }


  final technicalSkills = [
    "Java",
    "Dart",
    "Flutter",
    "Android Development",
    "Azure",
    "Python",
    "Fast API",
    "GitHub",
  ];

  final softSkills = [
    "Communication",
    "Management",
    "Decision Making",
    "Teamwork",
    "Problem Solving",
  ];

  Widget _buildSkills(BuildContext context) {
    final List<Widget> techWidgets = technicalSkills
        .map((skill) => Padding(
              padding: const EdgeInsets.only(top:4.0, right: 8.0),
              child: _buildSkillChip(context, skill),
            ))
        .toList();

    final List<Widget> softWidgets = softSkills
        .map((skill) => Padding(
              padding: const EdgeInsets.only(top:4.0, right: 8.0),
              child: _buildSkillChip(context, skill),
            ))
        .toList();
      
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSkillsContainerHeading(Strings.technicalSkillsIHave),
        Wrap(children: techWidgets),
        const SizedBox(height: 24.0),
        _buildSkillsContainerHeading(Strings.softSkillsIHave),
        Wrap(children: softWidgets),
      ],
    );
  }

  Widget _buildSkillsContainerHeading(String heading) {
    return Text(
      heading,
      style: TextStyles.subHeading,
    );
  }

  Widget _buildSkillChip(BuildContext context, String label) {
    return Chip(
      label: Text(
        label,
        style: TextStyles.chip.copyWith(
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.0 : 11.0,
        ),
      ),
    );
  }


  final experienceList = [
    Experience(
      "Jan 2022",
      "Present",
      "Hewlett Packard Enterprise, Bengaluru, India",
      "Research and Development Intern",
    ),
    Experience(
      "Feb 2022",
      "July 2022",
      "Hewlett Packard Enterprise",
      "CTY Fellow",
    ),
  ];

  Widget _buildExperience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildExperienceContainerHeading(),
        _buildExperienceSummary(),
        const SizedBox(height: 8.0),
        _buildExperienceTimeline(),
      ],
    );
  }

  Widget _buildExperienceContainerHeading() {
    return Text(
      Strings.experience,
      style: TextStyles.subHeading.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildExperienceSummary() {
    return Text(
      "My experience in the field of software development, product management and machine learning.",
      style: TextStyles.body,
    );
  }

  Widget _buildExperienceTimeline() {
    final List<Widget> widgets = experienceList
        .map((experience) => _buildExperienceTile(experience))
        .toList();
    return Column(children: widgets);
  }

  Widget _buildExperienceTile(Experience experience) {
    Color color = const Color(0xFF45405B);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            experience.jobTitle,
            style: TextStyles.company.copyWith(
              color: color,
            ),
          ),
          Text(
            experience.organization,
            style: TextStyles.body.copyWith(
              color: color,
            ),
          ),
          Text(
            "${experience.from}-${experience.to}",
            style: TextStyles.body,
          ),
        ],
      ),
    );
  }

  final educationList = [
    Education(
      "B.Tech in CSE",
      "Vellore Institute of Technology, Bhopal",
      "June 2019",
      "Present",
      "8.70/10",
    ),
    Education(
      "Higher Secondary School",
      "City Montessori School, Lucknow",
      "Apr 2018",
      "May 2019",
      "90%",
    ),
  ];

  Widget _buildEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildEducationContainerHeading(),
        _buildEducationSummary(),
        const SizedBox(height: 8.0),
        _buildEducationTimeline(),
      ],
    );
  }

  Widget _buildEducationContainerHeading() {
    return Text(
      Strings.education,
      style: TextStyles.subHeading.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildEducationSummary() {
    return Text(
      "My education and work experience are primarily in the CSE domain.",
      style: TextStyles.body,
    );
  }

  Widget _buildEducationTimeline() {
    final List<Widget> widgets = educationList
        .map((education) => _buildEducationTile(education))
        .toList();
    return Column(children: widgets);
  }

  Widget _buildEducationTile(Education education) {
    Color color = const Color(0xFF45405B);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            education.degree,
            style: TextStyles.company.copyWith(
              color: color,
            ),
          ),
          Text(
            education.organization,
            style: TextStyles.body.copyWith(
              color: color,
            ),
          ),
          Text(
            "${education.from}-${education.to}",
            style: TextStyles.body,
          ),
          Text(
            "Grade: ${education.grade}",
            style: TextStyles.body.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }


  final projectsList = [
    Projects(
      "Time Series Forecast for User's Cloud Data Consumption",
      "A web application in the ML domain that uses Time Series Forecasting to predict a user's cloud data consumption while using different SaaS Services.",
      "https://github.com/Janhvi-s/HPE_CTY_data_consumption_tsa",
    ),
    Projects(
      "AI Radio App",
      "A Radio App with an integrated AI-powered - Voice assistant, made using Flutter which helps the user to play genre-specific songs.",
      "https://github.com/Janhvi-s/RadioApp",
    ),
    Projects(
      "StayFit",
      "An ML-powered Yoga app (for MLOps for Good Hackathon) that detects the user's yoga pose in their daily yoga routine and are rewarded with our in-app tokens",
      "https://github.com/Janhvi-s/StayFit",
    ),
  ];

  Widget _buildProjects() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildProjectsContainerHeading(),
        _buildProjectsSummary(),
        const SizedBox(height: 8.0),
        _buildProjectsTimeline(),
      ],
    );
  }

  Widget _buildProjectsContainerHeading() {
    return Text(
      Strings.projects,
      style: TextStyles.subHeading.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProjectsSummary() {
    return Text(
      "My projects range in app development and AI-ML domain.",
      style: TextStyles.body,
    );
  }

  Widget _buildProjectsTimeline() {
    final List<Widget> widgets = projectsList
        .map((project) => _buildProjectsTile(project))
        .toList();
    return Column(children: widgets);
  }

  Widget _buildProjectsTile(Projects project) {
    Color color = const Color(0xFF45405B);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            project.name,
            style: TextStyles.company.copyWith(
              color: color,
            ),
          ),
          Text(
            project.description,
            style: TextStyles.body.copyWith(
              color: color,
            ),
          ),
          GestureDetector(
            child: Text(
              "Project Link",
              style: TextStyles.body.copyWith(
                color: Colors.blue.shade800,
              ),
            ),
            onTap: () {
              html.window
                  .open(project.link, "Project Link");
            },
          )
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: _buildCopyRightText(context),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _buildSocialIcons(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCopyRightText(BuildContext context) {
    return Text(
      Strings.rightsReserved,
      style: TextStyles.body1.copyWith(
        fontSize: ResponsiveWidget.isSmallScreen(context) ? 8 : 10.0,
      ),
    );
  }

  Widget _buildSocialIcons() {
    double size = 35.0;
    Color color = const Color(0xFF45405B);

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            html.window.open("https://github.com/janhvi-s", "GitHub");
          },
          child: Image.network(
            Assets.google,
            color: color,
            height: size,
            width: size,
          ),
        ),
        const SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {
            html.window
                .open("https://www.linkedin.com/in/janhvi-singh1110/", "LinkedIn");
          },
          child: Image.network(
            Assets.linkedin,
            color: color,
            height: size,
            width: size,
          ),
        ),
      ],
    );
  }
}
