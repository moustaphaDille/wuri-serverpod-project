/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:wuri_client/src/protocol/admin_application.dart' as _im8qqavm;
import 'package:wuri_client/src/protocol/app_user.dart' as _ickzx3kh;
import 'package:wuri_client/src/protocol/booking.dart' as _ikeyx6vq;
import 'package:wuri_client/src/protocol/greetings/greeting.dart' as _ih2qu9ow;
import 'package:wuri_client/src/protocol/host_booking_request.dart'
    as _idzklkdv;
import 'package:wuri_client/src/protocol/my_booking.dart' as _ii5svgo2;
import 'package:wuri_client/src/protocol/partner_application.dart' as _iqbqby5w;
import 'package:wuri_client/src/protocol/space.dart' as _ibf88rrb;
import 'package:wuri_client/src/protocol/space_image_upload.dart' as _iaf1btfm;
import 'package:wuri_client/src/protocol/space_type.dart' as _ijwim0hm;
import 'package:wuri_client/src/protocol/status.dart' as _iiy0r38s;
import 'package:wuri_client/src/protocol/user_role.dart' as _i5bpsm86;
import 'protocol.dart' as _il2as5qe;

/// Outils de l'administrateur. Réservé aux utilisateurs connectés.
/// {@category Endpoint}
class EndpointAdmin extends _isc.EndpointRef {
  EndpointAdmin(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  /// Devient administrateur en donnant le code secret du serveur.
  /// Le code est lu dans config/passwords.yaml (clé `adminSecret`).
  _ida.Future<_ickzx3kh.AppUser> claimAdmin(String secret) =>
      caller.callServerEndpoint<_ickzx3kh.AppUser>(
        'admin',
        'claimAdmin',
        {'secret': secret},
      );

  /// Les demandes des partenaires, les plus récentes d'abord.
  /// Sans filtre : toutes. Avec [status] : seulement ce statut.
  _ida.Future<List<_im8qqavm.AdminApplication>> listApplications({
    _iiy0r38s.ApplicationStatus? status,
  }) => caller.callServerEndpoint<List<_im8qqavm.AdminApplication>>(
    'admin',
    'listApplications',
    {'status': status},
  );

  /// Approuve ou refuse une demande en attente.
  _ida.Future<_iqbqby5w.PartnerApplication> reviewApplication({
    required int applicationId,
    required bool approve,
    String? reason,
  }) => caller.callServerEndpoint<_iqbqby5w.PartnerApplication>(
    'admin',
    'reviewApplication',
    {
      'applicationId': applicationId,
      'approve': approve,
      'reason': reason,
    },
  );

  /// Tous les profils, avec l'état d'activation de leur compte auth.
  _ida.Future<List<_ickzx3kh.AppUser>> listUsers() =>
      caller.callServerEndpoint<List<_ickzx3kh.AppUser>>(
        'admin',
        'listUsers',
        {},
      );

  /// Active ou désactive un compte client. Les partenaires sont gérés par
  /// leur demande de vérification et ne peuvent pas être bloqués ici.
  _ida.Future<_ickzx3kh.AppUser> setClientBlocked({
    required int userId,
    required bool blocked,
  }) => caller.callServerEndpoint<_ickzx3kh.AppUser>(
    'admin',
    'setClientBlocked',
    {
      'userId': userId,
      'blocked': blocked,
    },
  );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// Réservations vues par le client. Réservé aux utilisateurs connectés.
/// {@category Endpoint}
class EndpointBooking extends _isc.EndpointRef {
  EndpointBooking(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'booking';

  /// Crée une demande de réservation (statut "pending").
  /// Seuls les comptes clients peuvent réserver.
  _ida.Future<_ikeyx6vq.Booking> createBooking({
    required int placeId,
    required DateTime checkIn,
    required DateTime checkOut,
    required int guests,
  }) => caller.callServerEndpoint<_ikeyx6vq.Booking>(
    'booking',
    'createBooking',
    {
      'placeId': placeId,
      'checkIn': checkIn,
      'checkOut': checkOut,
      'guests': guests,
    },
  );

  /// Les réservations du client connecté, avec l'espace concerné.
  _ida.Future<List<_ii5svgo2.MyBooking>> listMyBookings() =>
      caller.callServerEndpoint<List<_ii5svgo2.MyBooking>>(
        'booking',
        'listMyBookings',
        {},
      );

  /// Annule une réservation (en attente ou acceptée) du client connecté.
  _ida.Future<_ikeyx6vq.Booking> cancelBooking(int bookingId) =>
      caller.callServerEndpoint<_ikeyx6vq.Booking>(
        'booking',
        'cancelBooking',
        {'bookingId': bookingId},
      );
}

/// Demandes reçues par un hôte. Réservé aux utilisateurs connectés.
/// {@category Endpoint}
class EndpointHostBooking extends _isc.EndpointRef {
  EndpointHostBooking(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'hostBooking';

  /// Les demandes de réservation pour les espaces de l'hôte connecté.
  _ida.Future<List<_idzklkdv.HostBookingRequest>> listRequests() =>
      caller.callServerEndpoint<List<_idzklkdv.HostBookingRequest>>(
        'hostBooking',
        'listRequests',
        {},
      );

  /// Accepte ou refuse une demande en attente.
  _ida.Future<_ikeyx6vq.Booking> respondToBooking({
    required int bookingId,
    required bool accept,
  }) => caller.callServerEndpoint<_ikeyx6vq.Booking>(
    'hostBooking',
    'respondToBooking',
    {
      'bookingId': bookingId,
      'accept': accept,
    },
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_ih2qu9ow.Greeting> hello(String name) =>
      caller.callServerEndpoint<_ih2qu9ow.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// Demande de vérification d'un partenaire. Réservé aux utilisateurs connectés.
/// {@category Endpoint}
class EndpointPartner extends _isc.EndpointRef {
  EndpointPartner(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'partner';

  /// La demande du partenaire connecté (null s'il n'en a pas encore envoyé).
  _ida.Future<_iqbqby5w.PartnerApplication?> getMyApplication() =>
      caller.callServerEndpoint<_iqbqby5w.PartnerApplication?>(
        'partner',
        'getMyApplication',
        {},
      );

  /// Envoie la demande de vérification (une seule fois).
  _ida.Future<_iqbqby5w.PartnerApplication> submitApplication({
    required String businessName,
    required _ijwim0hm.SpaceType businessType,
    required String city,
    required String address,
    required String registrationNumber,
  }) => caller.callServerEndpoint<_iqbqby5w.PartnerApplication>(
    'partner',
    'submitApplication',
    {
      'businessName': businessName,
      'businessType': businessType,
      'city': city,
      'address': address,
      'registrationNumber': registrationNumber,
    },
  );
}

/// Gère le profil (nom, prénom, téléphone, rôle) de l'utilisateur connecté.
/// {@category Endpoint}
class EndpointProfile extends _isc.EndpointRef {
  EndpointProfile(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'profile';

  /// Renvoie le profil de l'utilisateur connecté, ou null s'il n'existe pas encore.
  _ida.Future<_ickzx3kh.AppUser?> getMyProfile() =>
      caller.callServerEndpoint<_ickzx3kh.AppUser?>(
        'profile',
        'getMyProfile',
        {},
      );

  /// Crée le profil de l'utilisateur connecté (une seule fois).
  /// Le rôle choisi ne peut être que client ou partenaire. Seul l'email
  /// configuré donne le rôle administrateur.
  _ida.Future<_ickzx3kh.AppUser> createMyProfile(
    String firstName,
    String lastName,
    String phone,
    String language,
    _i5bpsm86.UserRole role,
  ) => caller.callServerEndpoint<_ickzx3kh.AppUser>(
    'profile',
    'createMyProfile',
    {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'language': language,
      'role': role,
    },
  );

  _ida.Future<_ickzx3kh.AppUser> updateMyProfile(
    String firstName,
    String lastName,
    String phone,
    String language,
  ) => caller.callServerEndpoint<_ickzx3kh.AppUser>(
    'profile',
    'updateMyProfile',
    {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'language': language,
    },
  );
}

/// Gestion des espaces par leur propriétaire. Réservé aux utilisateurs connectés.
/// {@category Endpoint}
class EndpointHostSpace extends _isc.EndpointRef {
  EndpointHostSpace(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'hostSpace';

  _ida.Future<_iaf1btfm.SpaceImageUpload> getSpaceImageUploadDescription(
    String extension,
  ) => caller.callServerEndpoint<_iaf1btfm.SpaceImageUpload>(
    'hostSpace',
    'getSpaceImageUploadDescription',
    {'extension': extension},
  );

  _ida.Future<String> verifySpaceImageUpload(String path) =>
      caller.callServerEndpoint<String>(
        'hostSpace',
        'verifySpaceImageUpload',
        {'path': path},
      );

  /// Les espaces de l'hôte connecté.
  _ida.Future<List<_ibf88rrb.Space>> listMySpaces() =>
      caller.callServerEndpoint<List<_ibf88rrb.Space>>(
        'hostSpace',
        'listMySpaces',
        {},
      );

  /// Publie un nouvel espace.
  _ida.Future<_ibf88rrb.Space> createSpace({
    required String name,
    required _ijwim0hm.SpaceType type,
    required String description,
    required String city,
    required double latitude,
    required double longitude,
    required int pricePerNight,
    required int maxGuests,
    required List<String> photoUrls,
  }) => caller.callServerEndpoint<_ibf88rrb.Space>(
    'hostSpace',
    'createSpace',
    {
      'name': name,
      'type': type,
      'description': description,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'pricePerNight': pricePerNight,
      'maxGuests': maxGuests,
      'photoUrls': photoUrls,
    },
  );
}

/// Parcourir les espaces. Public : pas besoin d'être connecté.
/// {@category Endpoint}
class EndpointSpace extends _isc.EndpointRef {
  EndpointSpace(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'space';

  /// Liste les espaces actifs, avec filtres facultatifs par ville et type.
  _ida.Future<List<_ibf88rrb.Space>> listSpaces({
    String? city,
    _ijwim0hm.SpaceType? type,
  }) => caller.callServerEndpoint<List<_ibf88rrb.Space>>(
    'space',
    'listSpaces',
    {
      'city': city,
      'type': type,
    },
  );

  /// Renvoie un espace par son identifiant, ou null s'il n'existe pas.
  _ida.Future<_ibf88rrb.Space?> getSpace(int id) =>
      caller.callServerEndpoint<_ibf88rrb.Space?>(
        'space',
        'getSpace',
        {'id': id},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    admin = EndpointAdmin(this);
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    booking = EndpointBooking(this);
    hostBooking = EndpointHostBooking(this);
    greeting = EndpointGreeting(this);
    partner = EndpointPartner(this);
    profile = EndpointProfile(this);
    hostSpace = EndpointHostSpace(this);
    space = EndpointSpace(this);
    modules = Modules(this);
  }

  late final EndpointAdmin admin;

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointBooking booking;

  late final EndpointHostBooking hostBooking;

  late final EndpointGreeting greeting;

  late final EndpointPartner partner;

  late final EndpointProfile profile;

  late final EndpointHostSpace hostSpace;

  late final EndpointSpace space;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'admin': admin,
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'booking': booking,
    'hostBooking': hostBooking,
    'greeting': greeting,
    'partner': partner,
    'profile': profile,
    'hostSpace': hostSpace,
    'space': space,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
