// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Wuri';

  @override
  String get tagline => 'Réservez votre espace au Niger';

  @override
  String get searchHint => 'Où aller au Niger ?';

  @override
  String get navSearch => 'Recherche';

  @override
  String get navFavorites => 'Favoris';

  @override
  String get navBookings => 'Réservations';

  @override
  String get navNotifications => 'Notifications';

  @override
  String get navProfile => 'Profil';

  @override
  String get navMySpaces => 'Mes espaces';

  @override
  String get navRequests => 'Demandes';

  @override
  String get typeAll => 'Tous';

  @override
  String get typeHotel => 'Hôtel';

  @override
  String get typeStay => 'Logement';

  @override
  String get typeWorkspace => 'Espace de travail';

  @override
  String perNight(String price) {
    return '$price FCFA / nuit';
  }

  @override
  String maxGuests(int count) {
    return 'Jusqu’à $count personnes';
  }

  @override
  String get descriptionTitle => 'Description';

  @override
  String get bookThisSpace => 'Réserver cet espace';

  @override
  String get noSpacesFound => 'Aucun espace ne correspond à votre recherche.';

  @override
  String get errorLoading => 'Impossible de charger les espaces.';

  @override
  String get retry => 'Réessayer';

  @override
  String get cancel => 'Annuler';

  @override
  String get spaceNotFound => 'Cet espace n’est pas disponible.';

  @override
  String get profileGuestTitle => 'Créez un compte pour réserver';

  @override
  String get profileGuestBody =>
      'Gardez vos favoris et suivez vos réservations. Cela ne prend qu’une minute.';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get logIn => 'Se connecter';

  @override
  String get signInTitle => 'Connexion';

  @override
  String get registerTitle => 'Créez votre compte';

  @override
  String get registerBody =>
      'Entrez votre email et choisissez un mot de passe. Nous vous enverrons un code pour vérifier votre email.';

  @override
  String get registerSubtitle =>
      'Nous vous enverrons un code pour vérifier votre email.';

  @override
  String stepLabel(int current, int total) {
    return 'Étape $current sur $total';
  }

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'vous@exemple.com';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get passwordHelper => 'Au moins 8 caractères';

  @override
  String get confirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get invalidEmail => 'Entrez une adresse email valide';

  @override
  String get passwordTooShort => 'Utilisez au moins 8 caractères';

  @override
  String get passwordsDontMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get sendCode => 'M’envoyer un code';

  @override
  String get verifyTitle => 'Vérifiez votre email';

  @override
  String verifyBody(String email) {
    return 'Nous avons envoyé un code à $email. Saisissez-le ci-dessous.';
  }

  @override
  String get codeLabel => 'Code de vérification';

  @override
  String get verifyAndCreate => 'Vérifier et créer mon compte';

  @override
  String get resendCode => 'Renvoyer le code';

  @override
  String get codeResent => 'Code renvoyé.';

  @override
  String get changeEmail => 'Changer d’email';

  @override
  String get haveAccount => 'Vous avez déjà un compte ?';

  @override
  String get noAccount => 'Pas encore de compte ?';

  @override
  String get loginTitle => 'Connexion';

  @override
  String get loginBody =>
      'Content de vous revoir. Entrez votre email et votre mot de passe.';

  @override
  String get loginHeadline => 'Content de vous revoir';

  @override
  String get loginSubtitle =>
      'Connectez-vous pour réserver votre prochain séjour.';

  @override
  String get loginFailed => 'Email ou mot de passe incorrect.';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get resetPasswordTitle => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordSubtitle =>
      'Entrez votre email pour recevoir un code.';

  @override
  String get verifyResetTitle => 'Vérifiez le code';

  @override
  String get newPasswordTitle => 'Nouveau mot de passe';

  @override
  String get newPasswordSubtitle => 'Choisissez un nouveau mot de passe.';

  @override
  String get sendResetCode => 'Envoyer le code';

  @override
  String get verifyCode => 'Vérifier le code';

  @override
  String get resetPassword => 'Réinitialiser';

  @override
  String get completeProfileTitle => 'Complétez votre profil';

  @override
  String get completeProfileBody =>
      'Quelques informations pour que les hôtes sachent qui réserve.';

  @override
  String get partnerOwnerBody =>
      'Vos informations de propriétaire. Ensuite, vous décrirez votre établissement.';

  @override
  String get firstName => 'Prénom';

  @override
  String get lastName => 'Nom';

  @override
  String get phone => 'Numéro de téléphone';

  @override
  String get phoneHint => '+227 90 00 00 00';

  @override
  String get continueLabel => 'Continuer';

  @override
  String get fieldRequired => 'Ce champ est obligatoire';

  @override
  String get invalidPhone => 'Entrez un numéro de téléphone valide';

  @override
  String get profileMissing => 'Votre profil n’est pas encore complet.';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get comingSoon => 'Bientôt disponible';

  @override
  String get genericError => 'Une erreur est survenue. Veuillez réessayer.';

  @override
  String get hostSpacesTitle => 'Mes espaces';

  @override
  String get addSpace => 'Ajouter un espace';

  @override
  String get noHostSpaces => 'Vous n’avez encore publié aucun espace.';

  @override
  String get spaceName => 'Nom';

  @override
  String get spaceTypeLabel => 'Type';

  @override
  String get cityLabel => 'Ville';

  @override
  String get pricePerNightLabel => 'Prix par nuit (FCFA)';

  @override
  String get maxGuestsLabel => 'Nombre maximum de personnes';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get locationLabel => 'Localisation exacte';

  @override
  String get locationHelp =>
      'Choisissez une région puis touchez la carte à l’emplacement exact de l’espace.';

  @override
  String get photoUrlLabel => 'Image de l’espace (obligatoire)';

  @override
  String get photoUrlHelp => 'Collez un lien direct vers au moins une image.';

  @override
  String get invalidNumber => 'Entrez un nombre supérieur à 0';

  @override
  String get invalidLink => 'Entrez un lien valide commençant par http';

  @override
  String get publishSpace => 'Publier l’espace';

  @override
  String get spacePublished => 'Espace publié.';

  @override
  String get bookingTitle => 'Vos dates';

  @override
  String get checkIn => 'Arrivée';

  @override
  String get checkOut => 'Départ';

  @override
  String get selectDates => 'Choisissez vos dates';

  @override
  String get guestsLabel => 'Personnes';

  @override
  String nightsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nuits',
      one: '1 nuit',
    );
    return '$_temp0';
  }

  @override
  String guestsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count personnes',
      one: '1 personne',
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
  String get continueToPayment => 'Continuer vers le paiement';

  @override
  String get datesRequired => 'Choisissez vos dates d’arrivée et de départ.';

  @override
  String get paymentTitle => 'Paiement';

  @override
  String get payAtProperty => 'Payer sur place';

  @override
  String get availableNow => 'Disponible maintenant';

  @override
  String get mobileMoney => 'Mobile Money';

  @override
  String get card => 'Carte bancaire';

  @override
  String get noMoneyTaken =>
      'Aucun argent n’est prélevé dans ce prototype. Vous payez l’hôte directement sur place.';

  @override
  String get confirmRequest => 'Confirmer la demande';

  @override
  String get requestSent => 'Demande envoyée. L’hôte vous répondra bientôt.';

  @override
  String get statusPending => 'En attente';

  @override
  String get statusAccepted => 'Acceptée';

  @override
  String get statusDeclined => 'Refusée';

  @override
  String get statusCancelled => 'Annulée';

  @override
  String get myBookingsTitle => 'Mes réservations';

  @override
  String get noBookings => 'Vous n’avez pas encore de réservation.';

  @override
  String get cancelBooking => 'Annuler la réservation';

  @override
  String get cancelConfirmTitle => 'Annuler cette réservation ?';

  @override
  String get cancelConfirmBody => 'Cette action est définitive.';

  @override
  String get keepBooking => 'La garder';

  @override
  String get bookingCancelled => 'Réservation annulée.';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get noNotifications => 'Aucune notification pour le moment.';

  @override
  String notifAccepted(String space) {
    return 'Bonne nouvelle ! Votre demande pour $space a été acceptée.';
  }

  @override
  String notifDeclined(String space) {
    return 'Votre demande pour $space a été refusée.';
  }

  @override
  String notifCancelled(String space) {
    return 'Vous avez annulé votre réservation pour $space.';
  }

  @override
  String get hostRequestsTitle => 'Demandes de réservation';

  @override
  String get noRequests => 'Aucune demande de réservation pour le moment.';

  @override
  String get accept => 'Accepter';

  @override
  String get decline => 'Refuser';

  @override
  String get requestAccepted => 'Demande acceptée.';

  @override
  String get requestDeclined => 'Demande refusée.';

  @override
  String get favoritesTitle => 'Favoris';

  @override
  String get noFavorites => 'Aucun favori pour le moment.';

  @override
  String get noFavoritesBody =>
      'Touchez le cœur d’un espace pour le garder ici.';

  @override
  String get addFavorite => 'Ajouter aux favoris';

  @override
  String get removeFavorite => 'Retirer des favoris';

  @override
  String get viewList => 'Liste';

  @override
  String get viewMap => 'Carte';

  @override
  String get chooseRoleTitle => 'Comment allez-vous utiliser Wuri ?';

  @override
  String get chooseRoleBody =>
      'Votre email est vérifié. Choisissez votre profil.';

  @override
  String get roleClientTitle => 'Je cherche un espace';

  @override
  String get roleClientBody =>
      'Parcourez et réservez des hôtels, résidences et espaces de travail.';

  @override
  String get rolePartnerTitle => 'Je possède un espace';

  @override
  String get rolePartnerBody =>
      'Publiez votre espace. Votre compte est vérifié avant que vous puissiez publier.';

  @override
  String get roleClient => 'Client';

  @override
  String get rolePartner => 'Partenaire';

  @override
  String get roleAdmin => 'Administrateur';

  @override
  String get businessTitle => 'Votre établissement';

  @override
  String get businessBody =>
      'Parlez-nous de votre établissement. L’équipe Wuri le vérifie avant que vous puissiez publier.';

  @override
  String get businessName => 'Nom de l’établissement';

  @override
  String get addressLabel => 'Adresse';

  @override
  String get registrationNumber => 'Numéro RCCM / NIF';

  @override
  String get sendForVerification => 'Envoyer pour vérification';

  @override
  String get applicationSent => 'Demande envoyée. Nous l’examinerons bientôt.';

  @override
  String get verificationTitle => 'Vérification';

  @override
  String get verificationNeeded =>
      'Décrivez votre établissement pour que nous puissions vérifier votre compte.';

  @override
  String get verificationPending =>
      'Nous vérifions vos informations. Vous pourrez publier votre espace une fois la demande approuvée.';

  @override
  String get verificationApproved =>
      'Votre compte est vérifié. Vous pouvez publier vos espaces.';

  @override
  String get verificationRejected => 'Votre demande n’a pas été approuvée.';

  @override
  String rejectionReason(String reason) {
    return 'Motif : $reason';
  }

  @override
  String get spacesLockedTitle => 'La publication est verrouillée';

  @override
  String get spacesLockedBody =>
      'Vous pourrez ajouter des espaces une fois votre compte vérifié.';

  @override
  String get partnerRequestsTitle => 'Demandes de partenaires';

  @override
  String get noPartnerRequests => 'Aucune demande de partenaire en attente.';

  @override
  String ownerLabel(String name) {
    return 'Propriétaire : $name';
  }

  @override
  String get approve => 'Approuver';

  @override
  String get reject => 'Refuser';

  @override
  String get rejectDialogTitle => 'Refuser cette demande ?';

  @override
  String get rejectReasonHint => 'Motif (facultatif)';

  @override
  String get applicationApproved => 'Partenaire approuvé.';

  @override
  String get applicationRejected => 'Partenaire refusé.';

  @override
  String get onlyClientsCanBook =>
      'Seuls les comptes clients peuvent réserver un espace.';

  @override
  String get profileInformation => 'Mes informations';

  @override
  String get viewAllInformation => 'Voir toutes les informations du compte';

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get changePassword => 'Changer le mot de passe';

  @override
  String get changePasswordTitle => 'Changer votre mot de passe';

  @override
  String get settings => 'Paramètres';

  @override
  String get accountType => 'Type de compte';

  @override
  String get languageLabel => 'Langue';

  @override
  String get memberSince => 'Membre depuis';

  @override
  String get loadingLabel => 'Chargement...';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get usersTitle => 'Utilisateurs';

  @override
  String get noUsers => 'Aucun utilisateur.';

  @override
  String get accountActive => 'Compte actif';

  @override
  String get accountInactive => 'Compte désactivé';

  @override
  String get activateAccount => 'Activer';

  @override
  String get deactivateAccount => 'Désactiver';

  @override
  String get userActivated => 'Compte activé.';

  @override
  String get userDeactivated => 'Compte désactivé.';

  @override
  String get partnerAccountManagedByVerification =>
      'Géré par la vérification partenaire';
}
