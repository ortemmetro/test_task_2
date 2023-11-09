import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_like_application/presentation/bloc/users_bloc/users_bloc.dart';

class PhotosDialogWidget extends StatelessWidget {
  const PhotosDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 300,
        height: 300,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state.currentUserPhotos.isEmpty) {
              return const CircularProgressIndicator.adaptive();
            } else {
              return GridView.builder(
                itemCount: state.currentUserPhotos.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    state.currentUserPhotos[index].url,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
