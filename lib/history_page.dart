// todo last
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_app_bloc/Bloc/pet_bloc.dart';
import 'details_page.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('HISTORY'),
      ),
      body: BlocBuilder<PetBloc, PetState>(
        builder: (context, state) {
          print('History page state is $state');
          if (state is AdoptedPetsLoadedState) {
            final adoptedPets = state.adoptedPets;
            if (adoptedPets.isNotEmpty) {
              return ListView.builder(
                itemCount: adoptedPets.length,
                itemBuilder: (context, index) {
                  final pet = adoptedPets[index];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(pet.imageAssetPath),
                        ),
                        title: Text(pet.name),
                        subtitle: Text(pet.category),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(pet: pet),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text('No adopted pets yet.'),
              );
            }
          } else {
            return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(80.0),
                        child: Image.asset('assets/oops.png'),
                      ),
                      const SizedBox(height: 20,),
                      Text('You have\'nt adopted any pet yet!!!' ,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.akatab(
                        color:Colors.grey[500],
                        decoration: TextDecoration.none,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        textBaseline: null
                      ),
                      ),
                    ],
                  ),
                );
            }
        },
      ),
    );
  }
}

