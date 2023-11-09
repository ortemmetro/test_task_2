import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_like_application/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:tinder_like_application/presentation/pages/main_page/widgets/photos_dialog_widget.dart';

class UserImageWidget extends StatefulWidget {
  const UserImageWidget({
    super.key,
    required this.currentAlbumId,
  });

  final int currentAlbumId;

  @override
  State<UserImageWidget> createState() => _UserImageWidgetState();
}

class _UserImageWidgetState extends State<UserImageWidget> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(const Size.fromHeight(280)),
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoaded && state.mapAlbumPhotos.isNotEmpty) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context.read<UsersBloc>().add(GetAllPhotosEvent());
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const PhotosDialogWidget();
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: Image.network(
                  state.mapAlbumPhotos[state.currentAlbumId]![0].url,
                ),
              ),
            );
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        },
      ),
    );
  }
}
