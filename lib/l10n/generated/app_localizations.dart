import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
    Locale('pt'),
  ];

  /// App title shown in the OS task switcher and window title
  ///
  /// In pt, this message translates to:
  /// **'Mina do Padre Libério'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In pt, this message translates to:
  /// **'Início'**
  String get navHome;

  /// No description provided for @navCamera.
  ///
  /// In pt, this message translates to:
  /// **'Câmera ao Vivo'**
  String get navCamera;

  /// No description provided for @navSchedule.
  ///
  /// In pt, this message translates to:
  /// **'Horários das Missas e Lives'**
  String get navSchedule;

  /// No description provided for @navVelario.
  ///
  /// In pt, this message translates to:
  /// **'Velário Virtual'**
  String get navVelario;

  /// No description provided for @navAbout.
  ///
  /// In pt, this message translates to:
  /// **'Sobre'**
  String get navAbout;

  /// No description provided for @navHistory.
  ///
  /// In pt, this message translates to:
  /// **'História'**
  String get navHistory;

  /// No description provided for @navVisit.
  ///
  /// In pt, this message translates to:
  /// **'Visitar'**
  String get navVisit;

  /// No description provided for @navDonation.
  ///
  /// In pt, this message translates to:
  /// **'Doação'**
  String get navDonation;

  /// No description provided for @navMore.
  ///
  /// In pt, this message translates to:
  /// **'Outros'**
  String get navMore;

  /// Placeholder body shown for a section not yet implemented
  ///
  /// In pt, this message translates to:
  /// **'Este conteúdo será adicionado na próxima etapa.'**
  String get sectionPlaceholder;

  /// Placeholder body for the Velario section while it's on hold
  ///
  /// In pt, this message translates to:
  /// **'Ainda não disponível.'**
  String get velarioNotAvailable;

  /// No description provided for @liveMassTitle.
  ///
  /// In pt, this message translates to:
  /// **'Missa Ao Vivo'**
  String get liveMassTitle;

  /// No description provided for @livePadreTitle.
  ///
  /// In pt, this message translates to:
  /// **'Live do Padre Geraldo Gabriel'**
  String get livePadreTitle;

  /// No description provided for @liveFallbackButton.
  ///
  /// In pt, this message translates to:
  /// **'Ver câmera e rádio'**
  String get liveFallbackButton;

  /// No description provided for @liveMassBannerText.
  ///
  /// In pt, this message translates to:
  /// **'Missa ao vivo agora — toque para assistir'**
  String get liveMassBannerText;

  /// No description provided for @livePadreBannerText.
  ///
  /// In pt, this message translates to:
  /// **'Live do Padre Geraldo Gabriel agora — toque para assistir'**
  String get livePadreBannerText;

  /// No description provided for @radioLiveLabel.
  ///
  /// In pt, this message translates to:
  /// **'Rádio Santa Cruz FM — ao vivo'**
  String get radioLiveLabel;

  /// No description provided for @noLiveNotice.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma missa ou transmissão da paróquia está acontecendo agora 😔'**
  String get noLiveNotice;

  /// No description provided for @scheduleMassesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Horários de Missa'**
  String get scheduleMassesTitle;

  /// No description provided for @scheduleMassesText.
  ///
  /// In pt, this message translates to:
  /// **'Missas todo primeiro e terceiro domingo do mês, às 8h30 da manhã. Venha participar e renovar sua fé na presença de Padre Libério.'**
  String get scheduleMassesText;

  /// No description provided for @scheduleLivesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Lives'**
  String get scheduleLivesTitle;

  /// No description provided for @scheduleLivesComingSoon.
  ///
  /// In pt, this message translates to:
  /// **'Em breve, um calendário completo com os horários das lives e transmissões especiais.'**
  String get scheduleLivesComingSoon;

  /// No description provided for @aboutCard2Title.
  ///
  /// In pt, this message translates to:
  /// **'Entrada Gratuita'**
  String get aboutCard2Title;

  /// No description provided for @aboutCard2Text.
  ///
  /// In pt, this message translates to:
  /// **'Acesso completamente livre, sem agendamento. Venha a qualquer hora e desfrute da natureza e da espiritualidade do local.'**
  String get aboutCard2Text;

  /// No description provided for @aboutCard3Title.
  ///
  /// In pt, this message translates to:
  /// **'Turismo Religioso'**
  String get aboutCard3Title;

  /// No description provided for @aboutCard3Text.
  ///
  /// In pt, this message translates to:
  /// **'Missas, terços e encontros religiosos acontecem regularmente. São José da Varginha é referência no turismo religioso regional.'**
  String get aboutCard3Text;

  /// No description provided for @historyMilestone1Year.
  ///
  /// In pt, this message translates to:
  /// **'Séc. XIX'**
  String get historyMilestone1Year;

  /// No description provided for @historyMilestone1Text.
  ///
  /// In pt, this message translates to:
  /// **'Padre Antônio Moreira Barbosa funda o povoado às margens do Ribeirão de Lages. Pela devoção a São José e pela bela vargem, o lugar recebe o nome de São José da Varginha.'**
  String get historyMilestone1Text;

  /// No description provided for @historyMilestone2Year.
  ///
  /// In pt, this message translates to:
  /// **'1881'**
  String get historyMilestone2Year;

  /// No description provided for @historyMilestone2Text.
  ///
  /// In pt, this message translates to:
  /// **'O vilarejo é elevado à condição de distrito, vinculado ao município de Pará de Minas.'**
  String get historyMilestone2Text;

  /// No description provided for @historyMilestone3Year.
  ///
  /// In pt, this message translates to:
  /// **'Séc. XX'**
  String get historyMilestone3Year;

  /// No description provided for @historyMilestone3Text.
  ///
  /// In pt, this message translates to:
  /// **'Padre Libério abençoa a nascente, prometendo que suas águas jamais secariam. A fé popular transforma a mina em ponto de peregrinação e contemplação.'**
  String get historyMilestone3Text;

  /// No description provided for @historyMilestone4Year.
  ///
  /// In pt, this message translates to:
  /// **'1963'**
  String get historyMilestone4Year;

  /// No description provided for @historyMilestone4Text.
  ///
  /// In pt, this message translates to:
  /// **'Em 1º de março, São José da Varginha se emancipa, tornando-se município independente de Pará de Minas.'**
  String get historyMilestone4Text;

  /// No description provided for @historyMilestone5Year.
  ///
  /// In pt, this message translates to:
  /// **'Hoje'**
  String get historyMilestone5Year;

  /// No description provided for @historyMilestone5Text.
  ///
  /// In pt, this message translates to:
  /// **'A Mina do Padre Libério recebe visitantes de toda a região, unindo natureza, contemplação e espiritualidade em um só lugar.'**
  String get historyMilestone5Text;

  /// No description provided for @donationTitle.
  ///
  /// In pt, this message translates to:
  /// **'Apoie a Mina do Padre Libério'**
  String get donationTitle;

  /// No description provided for @donationSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Sua doação ajuda a conservar este patrimônio espiritual para as próximas gerações.'**
  String get donationSubtitle;

  /// No description provided for @donationInstruction.
  ///
  /// In pt, this message translates to:
  /// **'Escaneie o QR Code abaixo para doar via PIX'**
  String get donationInstruction;

  /// No description provided for @donationQrAlt.
  ///
  /// In pt, this message translates to:
  /// **'QR Code para doação via PIX'**
  String get donationQrAlt;

  /// No description provided for @footerDescription.
  ///
  /// In pt, this message translates to:
  /// **'Patrimônio natural e religioso de São José da Varginha — MG.'**
  String get footerDescription;

  /// No description provided for @footerCopyright.
  ///
  /// In pt, this message translates to:
  /// **'Mina do Padre Libério'**
  String get footerCopyright;

  /// No description provided for @footerDevPrefix.
  ///
  /// In pt, this message translates to:
  /// **'Site desenvolvido e doado à Igreja por'**
  String get footerDevPrefix;

  /// No description provided for @footerDevName.
  ///
  /// In pt, this message translates to:
  /// **'Mateus Pinto da Silva'**
  String get footerDevName;

  /// No description provided for @footerDevSuffix.
  ///
  /// In pt, this message translates to:
  /// **'— sem qualquer cobrança, como ato de fé e serviço à comunidade.'**
  String get footerDevSuffix;

  /// No description provided for @visitAddressLabel.
  ///
  /// In pt, this message translates to:
  /// **'Endereço'**
  String get visitAddressLabel;

  /// No description provided for @visitAddress.
  ///
  /// In pt, this message translates to:
  /// **'Av. Dona Neném, s/n — Centro, São José da Varginha — MG'**
  String get visitAddress;

  /// No description provided for @visitAddressCep.
  ///
  /// In pt, this message translates to:
  /// **'CEP 35.694-000'**
  String get visitAddressCep;

  /// No description provided for @visitHoursLabel.
  ///
  /// In pt, this message translates to:
  /// **'Horário'**
  String get visitHoursLabel;

  /// No description provided for @visitHours.
  ///
  /// In pt, this message translates to:
  /// **'Livre — aberto ao público'**
  String get visitHours;

  /// No description provided for @visitEntryLabel.
  ///
  /// In pt, this message translates to:
  /// **'Entrada'**
  String get visitEntryLabel;

  /// No description provided for @visitEntry.
  ///
  /// In pt, this message translates to:
  /// **'Gratuita'**
  String get visitEntry;

  /// No description provided for @visitDirectionsLabel.
  ///
  /// In pt, this message translates to:
  /// **'Como chegar'**
  String get visitDirectionsLabel;

  /// No description provided for @visitDirectionsTip.
  ///
  /// In pt, this message translates to:
  /// **'Ao entrar na cidade pela interseção principal, siga em direção ao centro. A mina fica próxima a um posto de combustível.'**
  String get visitDirectionsTip;

  /// No description provided for @visitCta.
  ///
  /// In pt, this message translates to:
  /// **'Abrir no Google Maps'**
  String get visitCta;

  /// No description provided for @cameraLiveBadge.
  ///
  /// In pt, this message translates to:
  /// **'AO VIVO'**
  String get cameraLiveBadge;

  /// No description provided for @cameraReload.
  ///
  /// In pt, this message translates to:
  /// **'Recarregar'**
  String get cameraReload;

  /// No description provided for @cameraFullscreen.
  ///
  /// In pt, this message translates to:
  /// **'Tela cheia'**
  String get cameraFullscreen;

  /// No description provided for @cameraExitFullscreen.
  ///
  /// In pt, this message translates to:
  /// **'Sair da tela cheia'**
  String get cameraExitFullscreen;

  /// No description provided for @cameraOpenExternal.
  ///
  /// In pt, this message translates to:
  /// **'Abrir em nova aba'**
  String get cameraOpenExternal;
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
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
