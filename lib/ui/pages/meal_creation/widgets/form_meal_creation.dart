// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pic_2_plate_ai/domain/cubit/meal/meal_cubit.dart';
import '../widgets/tambah_bahan.dart';

class FormMealCreation extends StatelessWidget {
  final MealSettingsParameters state;

  FormMealCreation({required this.state, super.key});

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Text(
                    "Berapa banyak orang yang ingin mengkonsumsi",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Color(0xFF0A6847), // Custom active color
                      inactiveTrackColor: Color(0xFFB2B2B2), // Custom inactive color
                      thumbColor: Color(0xFF0A6847), // Custom thumb color
                      overlayColor: Color(0x290A6847), // Custom overlay color
                      trackHeight: 3.0, // Optional: customize the track height
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0), // Optional: customize the thumb shape
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0), // Optional: customize the overlay shape
                      valueIndicatorTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                      ), // Set the label text color to white
                      valueIndicatorColor: Color(0xFF0A6847), // Optional: set the background color of the value indicator
                    ),
                    child: Slider(
                      divisions: 5,
                      label: "${state.people} orang",
                      value: state.people.toDouble(),
                      min: 1,
                      max: 6,
                      onChanged: (double value) => context.read<MealCubit>().setPeople(value.toInt()),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "Berapa lama waktu yang kamu inginkan untuk memasak",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  SegmentedButton<int>(
                    showSelectedIcon: false,
                    multiSelectionEnabled: false,
                    segments: const [
                      ButtonSegment(label: Text("15 m"), value: 15),
                      ButtonSegment(label: Text("30 m"), value: 30),
                      ButtonSegment(label: Text("45 m"), value: 45),
                      ButtonSegment(label: Text("60 m"), value: 60),
                    ],
                    selected: {state.maxTimeCooking},
                    onSelectionChanged: (selections) => context.read<MealCubit>().setMaxTimeCooking(selections.first),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Color(0xFF0A6847); // Background color when selected
                        } else {
                          return Color(0xFFFFFFFF); // Background color when unselected
                        }
                      }),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.white; // Text color when selected
                        } else {
                          return Colors.black; // Text color when unselected
                        }
                      }),
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 16.0)), // Optional: customize padding
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // Optional: customize border radius
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Text(
                    'Unggah atau ambil gambar bahan pangan yang anda miliki',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  // const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilledButton.tonalIcon(
                        icon: const Icon(Icons.photo_size_select_actual_rounded),
                        onPressed: () async {
                          final XFile? image = await picker.pickImage(source: ImageSource.gallery);

                          if (image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Something went wrong'),
                              ),
                            );
                            return;
                          }

                          context.read<MealCubit>().setPicture(image);
                        },
                        label: Text(
                          "Buka Galeri",
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: Color(0xFF0A6847), // Background color
                          foregroundColor: Colors.white, // Text and icon color
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Padding inside the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0), // Rounded corners
                          ),
                          // side: BorderSide(color: Colors.greenAccent, width: 2.0), // Optional: Border side
                        ),
                      ),
                      FilledButton.tonalIcon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Color(0xFF0A6847), // Background color
                          foregroundColor: Colors.white, // Text and icon color
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Padding inside the button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0), // Rounded corners
                          ),
                          // side: BorderSide(color: Colors.greenAccent, width: 2.0), // Optional: Border side
                        ),
                        label: Text(
                          "Ambil Gambar",
                        ),
                        onPressed: () async {
                          final XFile? image = await picker.pickImage(source: ImageSource.camera);

                          if (image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Something went wrong'),
                              ),
                            );
                            return;
                          }

                          context.read<MealCubit>().setPicture(image);
                        },
                        icon: const Icon(Icons.camera_alt_rounded),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: ElevatedButton.icon(
            onPressed: state.isReadyToGenerate() ? () => context.read<MealCubit>().getMeal() : null,
            // onPressed: state.isReadyToGenerate()
            //     ? () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => MyApp()),
            //   );
            // }
            // : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF0A6847), // Background color of the button
              minimumSize: const Size(320, 50),
            ),
            label: Text(
              "Buat Resep",
              style: TextStyle(
                color: Colors.white, // Text color
                fontSize: 16, // Optional: adjust the font size
                fontWeight: FontWeight.bold, // Optional: adjust the font weight
              ),
            ),
          ),
        )
      ],
    );
  }
}

// Flexible(
// flex: 1,
// child: ElevatedButton.icon(
// icon: Icon(Icons.set_meal_rounded, color: Theme.of(context).colorScheme.onPrimary),
// onPressed: state.isReadyToGenerate() ? () => context.read<MealCubit>().getMeal() : null,
// style: ElevatedButton.styleFrom(
// backgroundColor: Theme.of(context).colorScheme.primary,
// minimumSize: const Size(320, 50),
// ),
// label: Text(
// "Lanjut",
// ),
// ),
// ),
