import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hostpool/blocs/experience_bloc.dart';
import 'package:hostpool/blocs/experience_event.dart';
import 'package:hostpool/screens/experience_selection_screen.dart';
import 'package:hostpool/screens/onboarding_question_screen.dart';
import 'package:hostpool/services/experience_api_service.dart';

void main() async{
  await dotenv.load(fileName: '.env');
  runApp(HostPool());
}

class HostPool extends StatelessWidget {
  HostPool({super.key});
  final ExperienceApi experienceApi = ExperienceApi();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExperienceBloc(experienceApi)..add(FetchExperiences()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotspot Host',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              color: Color(0XFF101010), surfaceTintColor: Colors.white60),
          scaffoldBackgroundColor: const Color(0XFF101010),
          fontFamily: 'SpaceGrotesk',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const ExperienceSelectionScreen(),
          '/onboarding_question': (context) => OnboardingQuestionScreen(),
        },
      ),
    );
  }
}
