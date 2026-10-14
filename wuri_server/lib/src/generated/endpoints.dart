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
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'package:wuri_server/src/generated/space_type.dart' as _i1qf00eb;
import 'package:wuri_server/src/generated/status.dart' as _iv2r69il;
import 'package:wuri_server/src/generated/user_role.dart' as _im3vef5w;
import '../admin/admin_endpoint.dart' as _ido5l6pj;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../bookings/booking_endpoint.dart' as _i7f5j1eo;
import '../bookings/host_booking_endpoint.dart' as _innymah4;
import '../greetings/greeting_endpoint.dart' as _il624ik7;
import '../partners/partner_endpoint.dart' as _iv77y31w;
import '../profile/profile_endpoint.dart' as _i6ky944g;
import '../spaces/host_space_endpoint.dart' as _iz16te8y;
import '../spaces/space_endpoint.dart' as _i9bw6oc8;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'admin': _ido5l6pj.AdminEndpoint()
        ..initialize(
          server,
          'admin',
          null,
        ),
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'booking': _i7f5j1eo.BookingEndpoint()
        ..initialize(
          server,
          'booking',
          null,
        ),
      'hostBooking': _innymah4.HostBookingEndpoint()
        ..initialize(
          server,
          'hostBooking',
          null,
        ),
      'greeting': _il624ik7.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'partner': _iv77y31w.PartnerEndpoint()
        ..initialize(
          server,
          'partner',
          null,
        ),
      'profile': _i6ky944g.ProfileEndpoint()
        ..initialize(
          server,
          'profile',
          null,
        ),
      'hostSpace': _iz16te8y.HostSpaceEndpoint()
        ..initialize(
          server,
          'hostSpace',
          null,
        ),
      'space': _i9bw6oc8.SpaceEndpoint()
        ..initialize(
          server,
          'space',
          null,
        ),
    };
    connectors['admin'] = _is.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'claimAdmin': _is.MethodConnector(
          name: 'claimAdmin',
          params: {
            'secret': _is.ParameterDescription(
              name: 'secret',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['admin'] as _ido5l6pj.AdminEndpoint).claimAdmin(
                    session,
                    params['secret'],
                  ),
        ),
        'listApplications': _is.MethodConnector(
          name: 'listApplications',
          params: {
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_iv2r69il.ApplicationStatus?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .listApplications(
                    session,
                    status: params['status'],
                  ),
        ),
        'reviewApplication': _is.MethodConnector(
          name: 'reviewApplication',
          params: {
            'applicationId': _is.ParameterDescription(
              name: 'applicationId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'approve': _is.ParameterDescription(
              name: 'approve',
              type: _is.getType<bool>(),
              nullable: false,
            ),
            'reason': _is.ParameterDescription(
              name: 'reason',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .reviewApplication(
                    session,
                    applicationId: params['applicationId'],
                    approve: params['approve'],
                    reason: params['reason'],
                  ),
        ),
        'listUsers': _is.MethodConnector(
          name: 'listUsers',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .listUsers(session),
        ),
        'setClientBlocked': _is.MethodConnector(
          name: 'setClientBlocked',
          params: {
            'userId': _is.ParameterDescription(
              name: 'userId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'blocked': _is.ParameterDescription(
              name: 'blocked',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['admin'] as _ido5l6pj.AdminEndpoint)
                  .setClientBlocked(
                    session,
                    userId: params['userId'],
                    blocked: params['blocked'],
                  ),
        ),
      },
    );
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['booking'] = _is.EndpointConnector(
      name: 'booking',
      endpoint: endpoints['booking']!,
      methodConnectors: {
        'createBooking': _is.MethodConnector(
          name: 'createBooking',
          params: {
            'placeId': _is.ParameterDescription(
              name: 'placeId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'checkIn': _is.ParameterDescription(
              name: 'checkIn',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'checkOut': _is.ParameterDescription(
              name: 'checkOut',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'guests': _is.ParameterDescription(
              name: 'guests',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['booking'] as _i7f5j1eo.BookingEndpoint)
                  .createBooking(
                    session,
                    placeId: params['placeId'],
                    checkIn: params['checkIn'],
                    checkOut: params['checkOut'],
                    guests: params['guests'],
                  ),
        ),
        'listMyBookings': _is.MethodConnector(
          name: 'listMyBookings',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['booking'] as _i7f5j1eo.BookingEndpoint)
                  .listMyBookings(session),
        ),
        'cancelBooking': _is.MethodConnector(
          name: 'cancelBooking',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['booking'] as _i7f5j1eo.BookingEndpoint)
                  .cancelBooking(
                    session,
                    params['bookingId'],
                  ),
        ),
      },
    );
    connectors['hostBooking'] = _is.EndpointConnector(
      name: 'hostBooking',
      endpoint: endpoints['hostBooking']!,
      methodConnectors: {
        'listRequests': _is.MethodConnector(
          name: 'listRequests',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hostBooking'] as _innymah4.HostBookingEndpoint)
                      .listRequests(session),
        ),
        'respondToBooking': _is.MethodConnector(
          name: 'respondToBooking',
          params: {
            'bookingId': _is.ParameterDescription(
              name: 'bookingId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'accept': _is.ParameterDescription(
              name: 'accept',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['hostBooking'] as _innymah4.HostBookingEndpoint)
                      .respondToBooking(
                        session,
                        bookingId: params['bookingId'],
                        accept: params['accept'],
                      ),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _il624ik7.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['partner'] = _is.EndpointConnector(
      name: 'partner',
      endpoint: endpoints['partner']!,
      methodConnectors: {
        'getMyApplication': _is.MethodConnector(
          name: 'getMyApplication',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['partner'] as _iv77y31w.PartnerEndpoint)
                  .getMyApplication(session),
        ),
        'submitApplication': _is.MethodConnector(
          name: 'submitApplication',
          params: {
            'businessName': _is.ParameterDescription(
              name: 'businessName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'businessType': _is.ParameterDescription(
              name: 'businessType',
              type: _is.getType<_i1qf00eb.SpaceType>(),
              nullable: false,
            ),
            'city': _is.ParameterDescription(
              name: 'city',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'address': _is.ParameterDescription(
              name: 'address',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'registrationNumber': _is.ParameterDescription(
              name: 'registrationNumber',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['partner'] as _iv77y31w.PartnerEndpoint)
                  .submitApplication(
                    session,
                    businessName: params['businessName'],
                    businessType: params['businessType'],
                    city: params['city'],
                    address: params['address'],
                    registrationNumber: params['registrationNumber'],
                  ),
        ),
      },
    );
    connectors['profile'] = _is.EndpointConnector(
      name: 'profile',
      endpoint: endpoints['profile']!,
      methodConnectors: {
        'getMyProfile': _is.MethodConnector(
          name: 'getMyProfile',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i6ky944g.ProfileEndpoint)
                  .getMyProfile(session),
        ),
        'createMyProfile': _is.MethodConnector(
          name: 'createMyProfile',
          params: {
            'firstName': _is.ParameterDescription(
              name: 'firstName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'lastName': _is.ParameterDescription(
              name: 'lastName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'phone': _is.ParameterDescription(
              name: 'phone',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'language': _is.ParameterDescription(
              name: 'language',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<_im3vef5w.UserRole>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i6ky944g.ProfileEndpoint)
                  .createMyProfile(
                    session,
                    params['firstName'],
                    params['lastName'],
                    params['phone'],
                    params['language'],
                    params['role'],
                  ),
        ),
        'updateMyProfile': _is.MethodConnector(
          name: 'updateMyProfile',
          params: {
            'firstName': _is.ParameterDescription(
              name: 'firstName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'lastName': _is.ParameterDescription(
              name: 'lastName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'phone': _is.ParameterDescription(
              name: 'phone',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'language': _is.ParameterDescription(
              name: 'language',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['profile'] as _i6ky944g.ProfileEndpoint)
                  .updateMyProfile(
                    session,
                    params['firstName'],
                    params['lastName'],
                    params['phone'],
                    params['language'],
                  ),
        ),
      },
    );
    connectors['hostSpace'] = _is.EndpointConnector(
      name: 'hostSpace',
      endpoint: endpoints['hostSpace']!,
      methodConnectors: {
        'getSpaceImageUploadDescription': _is.MethodConnector(
          name: 'getSpaceImageUploadDescription',
          params: {
            'extension': _is.ParameterDescription(
              name: 'extension',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hostSpace'] as _iz16te8y.HostSpaceEndpoint)
                  .getSpaceImageUploadDescription(
                    session,
                    params['extension'],
                  ),
        ),
        'verifySpaceImageUpload': _is.MethodConnector(
          name: 'verifySpaceImageUpload',
          params: {
            'path': _is.ParameterDescription(
              name: 'path',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hostSpace'] as _iz16te8y.HostSpaceEndpoint)
                  .verifySpaceImageUpload(
                    session,
                    params['path'],
                  ),
        ),
        'listMySpaces': _is.MethodConnector(
          name: 'listMySpaces',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hostSpace'] as _iz16te8y.HostSpaceEndpoint)
                  .listMySpaces(session),
        ),
        'createSpace': _is.MethodConnector(
          name: 'createSpace',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'type': _is.ParameterDescription(
              name: 'type',
              type: _is.getType<_i1qf00eb.SpaceType>(),
              nullable: false,
            ),
            'description': _is.ParameterDescription(
              name: 'description',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'city': _is.ParameterDescription(
              name: 'city',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'latitude': _is.ParameterDescription(
              name: 'latitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'longitude': _is.ParameterDescription(
              name: 'longitude',
              type: _is.getType<double>(),
              nullable: false,
            ),
            'pricePerNight': _is.ParameterDescription(
              name: 'pricePerNight',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'maxGuests': _is.ParameterDescription(
              name: 'maxGuests',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'photoUrls': _is.ParameterDescription(
              name: 'photoUrls',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['hostSpace'] as _iz16te8y.HostSpaceEndpoint)
                  .createSpace(
                    session,
                    name: params['name'],
                    type: params['type'],
                    description: params['description'],
                    city: params['city'],
                    latitude: params['latitude'],
                    longitude: params['longitude'],
                    pricePerNight: params['pricePerNight'],
                    maxGuests: params['maxGuests'],
                    photoUrls: params['photoUrls'],
                  ),
        ),
      },
    );
    connectors['space'] = _is.EndpointConnector(
      name: 'space',
      endpoint: endpoints['space']!,
      methodConnectors: {
        'listSpaces': _is.MethodConnector(
          name: 'listSpaces',
          params: {
            'city': _is.ParameterDescription(
              name: 'city',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'type': _is.ParameterDescription(
              name: 'type',
              type: _is.getType<_i1qf00eb.SpaceType?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['space'] as _i9bw6oc8.SpaceEndpoint).listSpaces(
                    session,
                    city: params['city'],
                    type: params['type'],
                  ),
        ),
        'getSpace': _is.MethodConnector(
          name: 'getSpace',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['space'] as _i9bw6oc8.SpaceEndpoint).getSpace(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
