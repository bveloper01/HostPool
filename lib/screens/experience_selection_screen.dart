import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostpool/blocs/experience_bloc.dart';
import 'package:hostpool/blocs/experience_event.dart';
import 'package:hostpool/blocs/experience_state.dart';
import 'package:hostpool/widgets/experience_card.dart';

class ExperienceSelectionScreen extends StatelessWidget {
  const ExperienceSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ))
          ],
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: SingleChildScrollView(
          padding:
              EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.5),
          reverse: true,
          child: BlocBuilder<ExperienceBloc, ExperienceState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));
              }
              if (state.error != null) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                      child: Text(
                    'Error: ${state.error}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                );
              }
              return Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "What kind of hotspots do you want to host?",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.experiences.length,
                        itemBuilder: (context, index) {
                          final experience = state.experiences[index];
                          final isSelected =
                              state.selectedExperiences.contains(experience);
                          return ExperienceCard(
                            experience: experience,
                            isSelected: isSelected,
                            onTap: () {
                              if (isSelected) {
                                context
                                    .read<ExperienceBloc>()
                                    .add(DeselectExperience(experience));
                              } else {
                                context
                                    .read<ExperienceBloc>()
                                    .add(SelectExperience(experience));
                              }
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextField(
                        maxLines: 6,
                        cursorColor: Colors.white,
                        maxLength: 250,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          hintText: '/Describe your perfect hotspot',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          filled: true,
                          fillColor: Colors.grey[900],
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0XFF9196FF),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        style: const TextStyle(
                            color: Colors.white, fontFamily: 'SpaceGrotesk'),
                        onChanged: (value) {
                          context
                              .read<ExperienceBloc>()
                              .add(UpdateDescription(value));
                        },
                      ),
                    ),
                    state.description.isEmpty
                        ? Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white.withOpacity(0.1)),
                            child: ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(
                                    color: Colors.white24,
                                    width: 1.0,
                                  ),
                                ),
                                elevation: 0,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white24, fontSize: 16),
                                  ),
                                  SizedBox(width: 8.0),
                                  Icon(
                                    Icons.double_arrow,
                                    color: Colors.white24,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(bottom: 40),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              gradient: RadialGradient(
                                colors: [
                                  Colors.white.withOpacity(0.1),
                                  Colors.black,
                                ],
                                stops: const [0.0, 1.0],
                                center: Alignment.center,
                                radius: 4,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
  print('Selected Experiences: ${state.selectedExperiences}');
  print('Description: ${state.description}');
  Navigator.pushNamed(context, '/onboarding_question');
},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(
                                    color: Colors.white54,
                                    width: 1.0,
                                  ),
                                ),
                                elevation: 0,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  SizedBox(width: 8.0),
                                  Icon(
                                    Icons.double_arrow,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
