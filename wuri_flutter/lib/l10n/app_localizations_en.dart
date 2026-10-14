// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Wuri';

  @override
  String get tagline => 'Book your space in Niger';

  @override
  String get searchHint => 'Where to in Niger?';

  @override
  String get navSearch => 'Search';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navBookings => 'Bookings';

  @override
  String get navNotifications => 'Notifications';

  @override
  String get navProfile => 'Profile';

  @override
  String get navMySpaces => 'My spaces';

  @override
  String get navRequests => 'Requests';

  @override
  String get typeAll => 'All';

  @override
  String get typeHotel => 'Hotel';

  @override
  String get typeStay => 'Stay';

  @override
  String get typeWorkspace => 'Workspace';

  @override
  String perNight(String price) {
    return '$price FCFA / night';
  }

  @override
  String maxGuests(int count) {
    return 'Up to $count guests';
  }

  @override
  String get descriptionTitle => 'Description';

  @override
  String get bookThisSpace => 'Book this space';

  @override
  String get noSpacesFound => 'No spaces match your search.';

  @override
  String get errorLoading => 'Could not load the spaces.';

  @override
  String get retry => 'Try again';

  @override
  String get cancel => 'Cancel';

  @override
  String get spaceNotFound => 'This space is not available.';

  @override
  String get profileGuestTitle => 'Create an account to book';

  @override
  String get profileGuestBody =>
      'Save your favorites and follow your bookings. It only takes a minute.';

  @override
  String get createAccount => 'Create account';

  @override
  String get logIn => 'Log in';

  @override
  String get signInTitle => 'Sign in';

  @override
  String get registerTitle => 'Create your account';

  @override
  String get registerBody =>
      'Enter your email and choose a password. We will send you a code to verify your email.';

  @override
  String get registerSubtitle => 'We will send a code to verify your email.';

  @override
  String stepLabel(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'you@example.com';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHelper => 'At least 8 characters';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get invalidEmail => 'Enter a valid email address';

  @override
  String get passwordTooShort => 'Use at least 8 characters';

  @override
  String get passwordsDontMatch => 'The passwords do not match';

  @override
  String get sendCode => 'Send me a code';

  @override
  String get verifyTitle => 'Verify your email';

  @override
  String verifyBody(String email) {
    return 'We sent a code to $email. Enter it below.';
  }

  @override
  String get codeLabel => 'Verification code';

  @override
  String get verifyAndCreate => 'Verify and create my account';

  @override
  String get resendCode => 'Resend the code';

  @override
  String get codeResent => 'Code sent again.';

  @override
  String get changeEmail => 'Change email';

  @override
  String get haveAccount => 'Already have an account?';

  @override
  String get noAccount => 'No account yet?';

  @override
  String get loginTitle => 'Log in';

  @override
  String get loginBody => 'Welcome back. Enter your email and password.';

  @override
  String get loginHeadline => 'Welcome back';

  @override
  String get loginSubtitle => 'Log in to book your next stay.';

  @override
  String get loginFailed => 'Incorrect email or password.';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get resetPasswordTitle => 'Reset your password';

  @override
  String get resetPasswordSubtitle => 'Enter your email to receive a code.';

  @override
  String get verifyResetTitle => 'Verify the code';

  @override
  String get newPasswordTitle => 'New password';

  @override
  String get newPasswordSubtitle => 'Choose a new password.';

  @override
  String get sendResetCode => 'Send code';

  @override
  String get verifyCode => 'Verify code';

  @override
  String get resetPassword => 'Reset password';

  @override
  String get completeProfileTitle => 'Complete your profile';

  @override
  String get completeProfileBody =>
      'We need a few details so hosts know who is booking.';

  @override
  String get partnerOwnerBody =>
      'Your details as the owner. Next, you will describe your business.';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get phone => 'Phone number';

  @override
  String get phoneHint => '+227 90 00 00 00';

  @override
  String get continueLabel => 'Continue';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidPhone => 'Enter a valid phone number';

  @override
  String get profileMissing => 'Your profile is not complete yet.';

  @override
  String get signOut => 'Sign out';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get genericError => 'Something went wrong. Please try again.';

  @override
  String get hostSpacesTitle => 'My spaces';

  @override
  String get addSpace => 'Add a space';

  @override
  String get noHostSpaces => 'You have not published any space yet.';

  @override
  String get spaceName => 'Name';

  @override
  String get spaceTypeLabel => 'Type';

  @override
  String get cityLabel => 'City';

  @override
  String get pricePerNightLabel => 'Price per night (FCFA)';

  @override
  String get maxGuestsLabel => 'Maximum guests';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get locationLabel => 'Exact location';

  @override
  String get locationHelp =>
      'Choose a region, then tap the map at the exact location of the space.';

  @override
  String get photoUrlLabel => 'Space image (required)';

  @override
  String get photoUrlHelp => 'Paste a direct link to at least one image.';

  @override
  String get invalidNumber => 'Enter a number greater than 0';

  @override
  String get invalidLink => 'Enter a valid link starting with http';

  @override
  String get publishSpace => 'Publish space';

  @override
  String get spacePublished => 'Space published.';

  @override
  String get bookingTitle => 'Your dates';

  @override
  String get checkIn => 'Check-in';

  @override
  String get checkOut => 'Check-out';

  @override
  String get selectDates => 'Select your dates';

  @override
  String get guestsLabel => 'Guests';

  @override
  String nightsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nights',
      one: '1 night',
    );
    return '$_temp0';
  }

  @override
  String guestsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count guests',
      one: '1 guest',
    );
    return '$_temp0';
  }

  @override
  String get totalLabel => 'Total';

  @override
  String totalPrice(String price) {
    return '$price FCFA';
  }

  @override
  String get continueToPayment => 'Continue to payment';

  @override
  String get datesRequired => 'Choose your check-in and check-out dates.';

  @override
  String get paymentTitle => 'Payment';

  @override
  String get payAtProperty => 'Pay at the property';

  @override
  String get availableNow => 'Available now';

  @override
  String get mobileMoney => 'Mobile Money';

  @override
  String get card => 'Card';

  @override
  String get noMoneyTaken =>
      'No money is taken in this prototype. You pay the host directly at the property.';

  @override
  String get confirmRequest => 'Confirm request';

  @override
  String get requestSent => 'Request sent. The host will reply soon.';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusAccepted => 'Accepted';

  @override
  String get statusDeclined => 'Declined';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get myBookingsTitle => 'My bookings';

  @override
  String get noBookings => 'You have no bookings yet.';

  @override
  String get cancelBooking => 'Cancel booking';

  @override
  String get cancelConfirmTitle => 'Cancel this booking?';

  @override
  String get cancelConfirmBody => 'This cannot be undone.';

  @override
  String get keepBooking => 'Keep it';

  @override
  String get bookingCancelled => 'Booking cancelled.';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get noNotifications => 'No notifications yet.';

  @override
  String notifAccepted(String space) {
    return 'Good news! Your request for $space was accepted.';
  }

  @override
  String notifDeclined(String space) {
    return 'Your request for $space was declined.';
  }

  @override
  String notifCancelled(String space) {
    return 'You cancelled your booking for $space.';
  }

  @override
  String get hostRequestsTitle => 'Booking requests';

  @override
  String get noRequests => 'No booking requests yet.';

  @override
  String get accept => 'Accept';

  @override
  String get decline => 'Decline';

  @override
  String get requestAccepted => 'Request accepted.';

  @override
  String get requestDeclined => 'Request declined.';

  @override
  String get favoritesTitle => 'Favorites';

  @override
  String get noFavorites => 'No favorites yet.';

  @override
  String get noFavoritesBody => 'Tap the heart on a space to save it here.';

  @override
  String get addFavorite => 'Add to favorites';

  @override
  String get removeFavorite => 'Remove from favorites';

  @override
  String get viewList => 'List';

  @override
  String get viewMap => 'Map';

  @override
  String get chooseRoleTitle => 'How will you use Wuri?';

  @override
  String get chooseRoleBody => 'Your email is verified. Choose your profile.';

  @override
  String get roleClientTitle => 'I am looking for a space';

  @override
  String get roleClientBody =>
      'Browse and book hotels, residences and workspaces.';

  @override
  String get rolePartnerTitle => 'I own a space';

  @override
  String get rolePartnerBody =>
      'Publish your space. Your account is verified before you can publish.';

  @override
  String get roleClient => 'Client';

  @override
  String get rolePartner => 'Partner';

  @override
  String get roleAdmin => 'Administrator';

  @override
  String get businessTitle => 'Your business';

  @override
  String get businessBody =>
      'Tell us about your business. The Wuri team verifies it before you can publish.';

  @override
  String get businessName => 'Business name';

  @override
  String get addressLabel => 'Address';

  @override
  String get registrationNumber => 'RCCM / NIF number';

  @override
  String get sendForVerification => 'Send for verification';

  @override
  String get applicationSent => 'Application sent. We will review it soon.';

  @override
  String get verificationTitle => 'Verification';

  @override
  String get verificationNeeded =>
      'Describe your business so we can verify your account.';

  @override
  String get verificationPending =>
      'We are checking your information. You will be able to publish your space once it is approved.';

  @override
  String get verificationApproved =>
      'Your account is verified. You can publish your spaces.';

  @override
  String get verificationRejected => 'Your application was not approved.';

  @override
  String rejectionReason(String reason) {
    return 'Reason: $reason';
  }

  @override
  String get spacesLockedTitle => 'Publishing is locked';

  @override
  String get spacesLockedBody =>
      'You will be able to add spaces once your account is verified.';

  @override
  String get partnerRequestsTitle => 'Partner requests';

  @override
  String get noPartnerRequests => 'No pending partner requests.';

  @override
  String ownerLabel(String name) {
    return 'Owner: $name';
  }

  @override
  String get approve => 'Approve';

  @override
  String get reject => 'Reject';

  @override
  String get rejectDialogTitle => 'Reject this application?';

  @override
  String get rejectReasonHint => 'Reason (optional)';

  @override
  String get applicationApproved => 'Partner approved.';

  @override
  String get applicationRejected => 'Partner rejected.';

  @override
  String get onlyClientsCanBook => 'Only client accounts can book a space.';

  @override
  String get profileInformation => 'My information';

  @override
  String get viewAllInformation => 'View all account information';

  @override
  String get editProfile => 'Edit profile';

  @override
  String get changePassword => 'Change password';

  @override
  String get changePasswordTitle => 'Change your password';

  @override
  String get settings => 'Settings';

  @override
  String get accountType => 'Account type';

  @override
  String get languageLabel => 'Language';

  @override
  String get memberSince => 'Member since';

  @override
  String get loadingLabel => 'Loading...';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get usersTitle => 'Users';

  @override
  String get noUsers => 'No users.';

  @override
  String get accountActive => 'Active account';

  @override
  String get accountInactive => 'Account disabled';

  @override
  String get activateAccount => 'Activate';

  @override
  String get deactivateAccount => 'Deactivate';

  @override
  String get userActivated => 'Account activated.';

  @override
  String get userDeactivated => 'Account disabled.';

  @override
  String get partnerAccountManagedByVerification =>
      'Managed by partner verification';
}
