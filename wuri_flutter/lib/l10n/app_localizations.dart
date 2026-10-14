import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Wuri'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Book your space in Niger'**
  String get tagline;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Where to in Niger?'**
  String get searchHint;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @navBookings.
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get navBookings;

  /// No description provided for @navNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get navNotifications;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @navMySpaces.
  ///
  /// In en, this message translates to:
  /// **'My spaces'**
  String get navMySpaces;

  /// No description provided for @navRequests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get navRequests;

  /// No description provided for @typeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get typeAll;

  /// No description provided for @typeHotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get typeHotel;

  /// No description provided for @typeStay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get typeStay;

  /// No description provided for @typeWorkspace.
  ///
  /// In en, this message translates to:
  /// **'Workspace'**
  String get typeWorkspace;

  /// No description provided for @perNight.
  ///
  /// In en, this message translates to:
  /// **'{price} FCFA / night'**
  String perNight(String price);

  /// No description provided for @maxGuests.
  ///
  /// In en, this message translates to:
  /// **'Up to {count} guests'**
  String maxGuests(int count);

  /// No description provided for @descriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionTitle;

  /// No description provided for @bookThisSpace.
  ///
  /// In en, this message translates to:
  /// **'Book this space'**
  String get bookThisSpace;

  /// No description provided for @noSpacesFound.
  ///
  /// In en, this message translates to:
  /// **'No spaces match your search.'**
  String get noSpacesFound;

  /// No description provided for @errorLoading.
  ///
  /// In en, this message translates to:
  /// **'Could not load the spaces.'**
  String get errorLoading;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @spaceNotFound.
  ///
  /// In en, this message translates to:
  /// **'This space is not available.'**
  String get spaceNotFound;

  /// No description provided for @profileGuestTitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account to book'**
  String get profileGuestTitle;

  /// No description provided for @profileGuestBody.
  ///
  /// In en, this message translates to:
  /// **'Save your favorites and follow your bookings. It only takes a minute.'**
  String get profileGuestBody;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @signInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signInTitle;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get registerTitle;

  /// No description provided for @registerBody.
  ///
  /// In en, this message translates to:
  /// **'Enter your email and choose a password. We will send you a code to verify your email.'**
  String get registerBody;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We will send a code to verify your email.'**
  String get registerSubtitle;

  /// No description provided for @stepLabel.
  ///
  /// In en, this message translates to:
  /// **'Step {current} of {total}'**
  String stepLabel(int current, int total);

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get emailHint;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHelper.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get passwordHelper;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'The passwords do not match'**
  String get passwordsDontMatch;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send me a code'**
  String get sendCode;

  /// No description provided for @verifyTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify your email'**
  String get verifyTitle;

  /// No description provided for @verifyBody.
  ///
  /// In en, this message translates to:
  /// **'We sent a code to {email}. Enter it below.'**
  String verifyBody(String email);

  /// No description provided for @codeLabel.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get codeLabel;

  /// No description provided for @verifyAndCreate.
  ///
  /// In en, this message translates to:
  /// **'Verify and create my account'**
  String get verifyAndCreate;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend the code'**
  String get resendCode;

  /// No description provided for @codeResent.
  ///
  /// In en, this message translates to:
  /// **'Code sent again.'**
  String get codeResent;

  /// No description provided for @changeEmail.
  ///
  /// In en, this message translates to:
  /// **'Change email'**
  String get changeEmail;

  /// No description provided for @haveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccount;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'No account yet?'**
  String get noAccount;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get loginTitle;

  /// No description provided for @loginBody.
  ///
  /// In en, this message translates to:
  /// **'Welcome back. Enter your email and password.'**
  String get loginBody;

  /// No description provided for @loginHeadline.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get loginHeadline;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to book your next stay.'**
  String get loginSubtitle;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password.'**
  String get loginFailed;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset your password'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive a code.'**
  String get resetPasswordSubtitle;

  /// No description provided for @verifyResetTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify the code'**
  String get verifyResetTitle;

  /// No description provided for @newPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get newPasswordTitle;

  /// No description provided for @newPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a new password.'**
  String get newPasswordSubtitle;

  /// No description provided for @sendResetCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get sendResetCode;

  /// No description provided for @verifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get verifyCode;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get resetPassword;

  /// No description provided for @completeProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your profile'**
  String get completeProfileTitle;

  /// No description provided for @completeProfileBody.
  ///
  /// In en, this message translates to:
  /// **'We need a few details so hosts know who is booking.'**
  String get completeProfileBody;

  /// No description provided for @partnerOwnerBody.
  ///
  /// In en, this message translates to:
  /// **'Your details as the owner. Next, you will describe your business.'**
  String get partnerOwnerBody;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phone;

  /// No description provided for @phoneHint.
  ///
  /// In en, this message translates to:
  /// **'+227 90 00 00 00'**
  String get phoneHint;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get invalidPhone;

  /// No description provided for @profileMissing.
  ///
  /// In en, this message translates to:
  /// **'Your profile is not complete yet.'**
  String get profileMissing;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @genericError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get genericError;

  /// No description provided for @hostSpacesTitle.
  ///
  /// In en, this message translates to:
  /// **'My spaces'**
  String get hostSpacesTitle;

  /// No description provided for @addSpace.
  ///
  /// In en, this message translates to:
  /// **'Add a space'**
  String get addSpace;

  /// No description provided for @noHostSpaces.
  ///
  /// In en, this message translates to:
  /// **'You have not published any space yet.'**
  String get noHostSpaces;

  /// No description provided for @spaceName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get spaceName;

  /// No description provided for @spaceTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get spaceTypeLabel;

  /// No description provided for @cityLabel.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get cityLabel;

  /// No description provided for @pricePerNightLabel.
  ///
  /// In en, this message translates to:
  /// **'Price per night (FCFA)'**
  String get pricePerNightLabel;

  /// No description provided for @maxGuestsLabel.
  ///
  /// In en, this message translates to:
  /// **'Maximum guests'**
  String get maxGuestsLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Exact location'**
  String get locationLabel;

  /// No description provided for @locationHelp.
  ///
  /// In en, this message translates to:
  /// **'Choose a region, then tap the map at the exact location of the space.'**
  String get locationHelp;

  /// No description provided for @photoUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'Space image (required)'**
  String get photoUrlLabel;

  /// No description provided for @photoUrlHelp.
  ///
  /// In en, this message translates to:
  /// **'Paste a direct link to at least one image.'**
  String get photoUrlHelp;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter a number greater than 0'**
  String get invalidNumber;

  /// No description provided for @invalidLink.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid link starting with http'**
  String get invalidLink;

  /// No description provided for @publishSpace.
  ///
  /// In en, this message translates to:
  /// **'Publish space'**
  String get publishSpace;

  /// No description provided for @spacePublished.
  ///
  /// In en, this message translates to:
  /// **'Space published.'**
  String get spacePublished;

  /// No description provided for @bookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Your dates'**
  String get bookingTitle;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check-in'**
  String get checkIn;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check-out'**
  String get checkOut;

  /// No description provided for @selectDates.
  ///
  /// In en, this message translates to:
  /// **'Select your dates'**
  String get selectDates;

  /// No description provided for @guestsLabel.
  ///
  /// In en, this message translates to:
  /// **'Guests'**
  String get guestsLabel;

  /// No description provided for @nightsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 night} other{{count} nights}}'**
  String nightsCount(int count);

  /// No description provided for @guestsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 guest} other{{count} guests}}'**
  String guestsCount(int count);

  /// No description provided for @totalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get totalLabel;

  /// No description provided for @totalPrice.
  ///
  /// In en, this message translates to:
  /// **'{price} FCFA'**
  String totalPrice(String price);

  /// No description provided for @continueToPayment.
  ///
  /// In en, this message translates to:
  /// **'Continue to payment'**
  String get continueToPayment;

  /// No description provided for @datesRequired.
  ///
  /// In en, this message translates to:
  /// **'Choose your check-in and check-out dates.'**
  String get datesRequired;

  /// No description provided for @paymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get paymentTitle;

  /// No description provided for @payAtProperty.
  ///
  /// In en, this message translates to:
  /// **'Pay at the property'**
  String get payAtProperty;

  /// No description provided for @availableNow.
  ///
  /// In en, this message translates to:
  /// **'Available now'**
  String get availableNow;

  /// No description provided for @mobileMoney.
  ///
  /// In en, this message translates to:
  /// **'Mobile Money'**
  String get mobileMoney;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @noMoneyTaken.
  ///
  /// In en, this message translates to:
  /// **'No money is taken in this prototype. You pay the host directly at the property.'**
  String get noMoneyTaken;

  /// No description provided for @confirmRequest.
  ///
  /// In en, this message translates to:
  /// **'Confirm request'**
  String get confirmRequest;

  /// No description provided for @requestSent.
  ///
  /// In en, this message translates to:
  /// **'Request sent. The host will reply soon.'**
  String get requestSent;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @statusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get statusAccepted;

  /// No description provided for @statusDeclined.
  ///
  /// In en, this message translates to:
  /// **'Declined'**
  String get statusDeclined;

  /// No description provided for @statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get statusCancelled;

  /// No description provided for @myBookingsTitle.
  ///
  /// In en, this message translates to:
  /// **'My bookings'**
  String get myBookingsTitle;

  /// No description provided for @noBookings.
  ///
  /// In en, this message translates to:
  /// **'You have no bookings yet.'**
  String get noBookings;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel booking'**
  String get cancelBooking;

  /// No description provided for @cancelConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel this booking?'**
  String get cancelConfirmTitle;

  /// No description provided for @cancelConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get cancelConfirmBody;

  /// No description provided for @keepBooking.
  ///
  /// In en, this message translates to:
  /// **'Keep it'**
  String get keepBooking;

  /// No description provided for @bookingCancelled.
  ///
  /// In en, this message translates to:
  /// **'Booking cancelled.'**
  String get bookingCancelled;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet.'**
  String get noNotifications;

  /// No description provided for @notifAccepted.
  ///
  /// In en, this message translates to:
  /// **'Good news! Your request for {space} was accepted.'**
  String notifAccepted(String space);

  /// No description provided for @notifDeclined.
  ///
  /// In en, this message translates to:
  /// **'Your request for {space} was declined.'**
  String notifDeclined(String space);

  /// No description provided for @notifCancelled.
  ///
  /// In en, this message translates to:
  /// **'You cancelled your booking for {space}.'**
  String notifCancelled(String space);

  /// No description provided for @hostRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking requests'**
  String get hostRequestsTitle;

  /// No description provided for @noRequests.
  ///
  /// In en, this message translates to:
  /// **'No booking requests yet.'**
  String get noRequests;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @requestAccepted.
  ///
  /// In en, this message translates to:
  /// **'Request accepted.'**
  String get requestAccepted;

  /// No description provided for @requestDeclined.
  ///
  /// In en, this message translates to:
  /// **'Request declined.'**
  String get requestDeclined;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favoritesTitle;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet.'**
  String get noFavorites;

  /// No description provided for @noFavoritesBody.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on a space to save it here.'**
  String get noFavoritesBody;

  /// No description provided for @addFavorite.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get addFavorite;

  /// No description provided for @removeFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFavorite;

  /// No description provided for @viewList.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get viewList;

  /// No description provided for @viewMap.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get viewMap;

  /// No description provided for @chooseRoleTitle.
  ///
  /// In en, this message translates to:
  /// **'How will you use Wuri?'**
  String get chooseRoleTitle;

  /// No description provided for @chooseRoleBody.
  ///
  /// In en, this message translates to:
  /// **'Your email is verified. Choose your profile.'**
  String get chooseRoleBody;

  /// No description provided for @roleClientTitle.
  ///
  /// In en, this message translates to:
  /// **'I am looking for a space'**
  String get roleClientTitle;

  /// No description provided for @roleClientBody.
  ///
  /// In en, this message translates to:
  /// **'Browse and book hotels, residences and workspaces.'**
  String get roleClientBody;

  /// No description provided for @rolePartnerTitle.
  ///
  /// In en, this message translates to:
  /// **'I own a space'**
  String get rolePartnerTitle;

  /// No description provided for @rolePartnerBody.
  ///
  /// In en, this message translates to:
  /// **'Publish your space. Your account is verified before you can publish.'**
  String get rolePartnerBody;

  /// No description provided for @roleClient.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get roleClient;

  /// No description provided for @rolePartner.
  ///
  /// In en, this message translates to:
  /// **'Partner'**
  String get rolePartner;

  /// No description provided for @roleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get roleAdmin;

  /// No description provided for @businessTitle.
  ///
  /// In en, this message translates to:
  /// **'Your business'**
  String get businessTitle;

  /// No description provided for @businessBody.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your business. The Wuri team verifies it before you can publish.'**
  String get businessBody;

  /// No description provided for @businessName.
  ///
  /// In en, this message translates to:
  /// **'Business name'**
  String get businessName;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressLabel;

  /// No description provided for @registrationNumber.
  ///
  /// In en, this message translates to:
  /// **'RCCM / NIF number'**
  String get registrationNumber;

  /// No description provided for @sendForVerification.
  ///
  /// In en, this message translates to:
  /// **'Send for verification'**
  String get sendForVerification;

  /// No description provided for @applicationSent.
  ///
  /// In en, this message translates to:
  /// **'Application sent. We will review it soon.'**
  String get applicationSent;

  /// No description provided for @verificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification'**
  String get verificationTitle;

  /// No description provided for @verificationNeeded.
  ///
  /// In en, this message translates to:
  /// **'Describe your business so we can verify your account.'**
  String get verificationNeeded;

  /// No description provided for @verificationPending.
  ///
  /// In en, this message translates to:
  /// **'We are checking your information. You will be able to publish your space once it is approved.'**
  String get verificationPending;

  /// No description provided for @verificationApproved.
  ///
  /// In en, this message translates to:
  /// **'Your account is verified. You can publish your spaces.'**
  String get verificationApproved;

  /// No description provided for @verificationRejected.
  ///
  /// In en, this message translates to:
  /// **'Your application was not approved.'**
  String get verificationRejected;

  /// No description provided for @rejectionReason.
  ///
  /// In en, this message translates to:
  /// **'Reason: {reason}'**
  String rejectionReason(String reason);

  /// No description provided for @spacesLockedTitle.
  ///
  /// In en, this message translates to:
  /// **'Publishing is locked'**
  String get spacesLockedTitle;

  /// No description provided for @spacesLockedBody.
  ///
  /// In en, this message translates to:
  /// **'You will be able to add spaces once your account is verified.'**
  String get spacesLockedBody;

  /// No description provided for @partnerRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Partner requests'**
  String get partnerRequestsTitle;

  /// No description provided for @noPartnerRequests.
  ///
  /// In en, this message translates to:
  /// **'No pending partner requests.'**
  String get noPartnerRequests;

  /// No description provided for @ownerLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner: {name}'**
  String ownerLabel(String name);

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @rejectDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Reject this application?'**
  String get rejectDialogTitle;

  /// No description provided for @rejectReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Reason (optional)'**
  String get rejectReasonHint;

  /// No description provided for @applicationApproved.
  ///
  /// In en, this message translates to:
  /// **'Partner approved.'**
  String get applicationApproved;

  /// No description provided for @applicationRejected.
  ///
  /// In en, this message translates to:
  /// **'Partner rejected.'**
  String get applicationRejected;

  /// No description provided for @onlyClientsCanBook.
  ///
  /// In en, this message translates to:
  /// **'Only client accounts can book a space.'**
  String get onlyClientsCanBook;

  /// No description provided for @profileInformation.
  ///
  /// In en, this message translates to:
  /// **'My information'**
  String get profileInformation;

  /// No description provided for @viewAllInformation.
  ///
  /// In en, this message translates to:
  /// **'View all account information'**
  String get viewAllInformation;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change your password'**
  String get changePasswordTitle;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @accountType.
  ///
  /// In en, this message translates to:
  /// **'Account type'**
  String get accountType;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since'**
  String get memberSince;

  /// No description provided for @loadingLabel.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loadingLabel;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @usersTitle.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get usersTitle;

  /// No description provided for @noUsers.
  ///
  /// In en, this message translates to:
  /// **'No users.'**
  String get noUsers;

  /// No description provided for @accountActive.
  ///
  /// In en, this message translates to:
  /// **'Active account'**
  String get accountActive;

  /// No description provided for @accountInactive.
  ///
  /// In en, this message translates to:
  /// **'Account disabled'**
  String get accountInactive;

  /// No description provided for @activateAccount.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activateAccount;

  /// No description provided for @deactivateAccount.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get deactivateAccount;

  /// No description provided for @userActivated.
  ///
  /// In en, this message translates to:
  /// **'Account activated.'**
  String get userActivated;

  /// No description provided for @userDeactivated.
  ///
  /// In en, this message translates to:
  /// **'Account disabled.'**
  String get userDeactivated;

  /// No description provided for @partnerAccountManagedByVerification.
  ///
  /// In en, this message translates to:
  /// **'Managed by partner verification'**
  String get partnerAccountManagedByVerification;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
