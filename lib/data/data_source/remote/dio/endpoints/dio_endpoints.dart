class DioEndpoints {
  DioEndpoints._();

  static const userEndpoint = 'https://jsonplaceholder.typicode.com/users';

  static const albumsEndpoint = 'https://jsonplaceholder.typicode.com/albums';

  static photosEndpoint(int albumId) =>
      'https://jsonplaceholder.typicode.com/albums/$albumId/photos';
}
