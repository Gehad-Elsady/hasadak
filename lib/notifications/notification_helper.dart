import 'package:googleapis_auth/auth_io.dart';

class get_server_key {
  Future<String> server_token() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "hasadak-e13f0",
          "private_key_id": "d652c575c295f632ee75f912bc9cee8f66829602",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCt78BeCf4AwLTK\nZ/5ENRj6x7Cl8zw1HsamlgtxypMCQSUkwxivqolst/BfX7dwmaF0Z+IkI2MT/+pA\ngNMNd5PqhKWZLkbxScMIOwleWihRIx9DS0kDa8o3Auhnkuv6NTOseFYR73lA0JLW\nr86S+IpaEoVoYoYDSwSMRVeX3jR1CZUmT0WFv/yjlfamqE080ySr990rVkThstch\nRx0YWa1HlZ2xA7kFxLuscXyOWew8Yd2dVVJtbwj6cnFVVbERsMhdE2KdV9YccFtM\nCNNn9Keu4zOA/PzY+8JJHJJ2LkquAeb4IHbVWarIvG+Oo1Kx+kb9CMPuyFHF4EBG\nri4Qj5eDAgMBAAECggEAKs7ab+qSppnHBRfCFwRgcPwrqDQsicBY0NAV4fwi4Ueq\nPhl8HmPg7a55jOeQTLiq6WzV1eIVtOrjuttZ1jMrZukdno0qraDjTMfG3v9ec9Wq\nkJPbVOm2+4IOM8uPo2VrodN+D2z6US7kLM1ZEIf1+QQc7FtvMylH5cP9MmXgUDtT\nGVWNp54gSE/EA3Vtq7kaBl4+QxwBmYGY6bhT+jnhe7Nxq9ukswh4EQ0v1QlrNpQ+\nvm8mGCEUl1aCBSyOUdwW8EjD4fy4rtuAaP4ZuzvySQ/efdmv9UAB3YadengbVj6L\nc8dfGjNUBFsREUH6DhoC0evrkiomW4rhssdPdt0abQKBgQDaYc371n6aJ1DH/Eo+\nkcgu6y/MdTJ0NWXWvwLF50kOmA00Sx87c567M+aGcNMgqZCIIQKVIPes/EjsVxpm\nFL65xR23/v145X81mUu/xoHr0HznA+Hn/X2DeW6k12jGXV8JN0i4FZl1bxH1MxN9\ndUh4B4kdkUR684iuOjn+BjcwnwKBgQDL5f3XBJebwkVaCfJd6Y51rZq77ZU2xkN0\nv7sKa4/NmcQlcnlC8Emt8kwcp+QBOi8K1LzAwRhxrLU3EaIj/jd5cVtYR+xAqxxc\neJG4UwYqDokYphVQsbAkxgGKFqPXLLqNJwjSYYfQOMllncj/TakCR9osXgsObrZu\nTat8+ZV6nQKBgQDUWqbibQFPBUwYK8xGa5wtg6VHO++D8SjGWZdoui7gchrk7ue/\n9/4yK5XOxYeIC1rwBKluOlCddfWzXD/fY+zS2Eq90MbJ+OBqTlbKdU2A8YuDWNMj\ns+uJHVvqD01jFwiC/a9I0jgXaZocxT3+kT2W+jzq84eTx5zxTs11prWkIQKBgQC0\nw3hwSGT0NJ3xPgI92dJvZ3JXi0CO5+Rju5rhmQxLFTg8jqkMfCSF7tolSX6sy91q\nt8GDDW1TUe7yHFLnn/ekVafKszCzAD/LhySBCjHb1TkbvhoFiRIE9/njZ0DngYL9\noo6CnO6f3chGq0THeh0MpZC5ZsJckDBxx6/xwv8PTQKBgQDDv/d9fG584VKFjQUu\neHO+Rz8AeUCRGItmY5V9NEdT4kvqYqA/1BJJQnv3jYGdHlW2GWUJXVSWIdj/LeX9\nJImZ9T5NbghWg9Llm/tfK8EILfqlLXJi4zP3i8ohIqr85K19rZoQ7TsfzGk5F3YP\nbLSuaylY2BRQlQpoGDUVFBVDlg==\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-j1kny@hasadak-e13f0.iam.gserviceaccount.com",
          "client_id": "103425079583260883956",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-j1kny%40hasadak-e13f0.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }
}
