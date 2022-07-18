// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

// ignore: non_constant_identifier_names
final LOCAL_BASE_API_URL =
    (kIsWeb || defaultTargetPlatform == TargetPlatform.iOS)
        ? 'http://127.0.0.1'
        : 'http://10.0.2.2';
const LOCAL_PORT = 6565;

const REMOTE_BASE_API_URL = 'https://mes-sii-project-api.herokuapp.com';

const API_VERSION = 0.1;
