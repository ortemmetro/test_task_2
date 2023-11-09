import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinder_like_application/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:tinder_like_application/presentation/pages/main_page/widgets/user_image_widget.dart';

class UserInfoWidget extends StatefulWidget {
  const UserInfoWidget({
    super.key,
  });

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(
          GetUsersEvent(),
        );

    context.read<UsersBloc>().add(
          GetAlbumsEvent(),
        );
  }

  final String bullet = "\u2022";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is UsersError) {
            final snackBar = SnackBar(
              content: Text(state.errorMessage),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is UsersLoaded &&
              state.currentAlbumId != 0 &&
              !state.mapAlbumPhotos.containsKey(state.currentAlbumId)) {
            context.read<UsersBloc>().add(
                  GetPhotosEvent(
                    albumId: context.read<UsersBloc>().state.currentAlbumId,
                  ),
                );
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              const SizedBox(height: 16),
              UserImageWidget(
                currentAlbumId: state.currentAlbumId,
              ),
              const SizedBox(height: 20),
              Text(
                state.currentUser?.name ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                state.currentUser?.company.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$bullet City: ${state.currentUser?.address.city ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '$bullet Street: ${state.currentUser?.address.street ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '$bullet Suite: ${state.currentUser?.address.suite ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '$bullet ZipCode: ${state.currentUser?.address.zipcode ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '$bullet Email: ${state.currentUser?.email ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '$bullet Phone: ${state.currentUser?.phone ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '$bullet WebSite: ${state.currentUser?.website ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '$bullet Companys catch phrase: ${state.currentUser?.company.catchPhrase ?? ''}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
