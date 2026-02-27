// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'strings.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class StringsEs extends Strings {
  StringsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Mi Aplicación';

  @override
  String get welcome => 'Bienvenido';

  @override
  String hello(String name) {
    return 'Hola, $name';
  }

  @override
  String counter(int count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString elementos',
      one: '1 elemento',
      zero: 'Sin elementos',
    );
    return '$_temp0';
  }

  @override
  String get signIn => 'Iniciar Sesión';

  @override
  String get signUp => 'Registrarse';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get settings => 'Configuración';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get lightMode => 'Modo Claro';

  @override
  String get systemMode => 'Modo del Sistema';

  @override
  String get more => 'Más';

  @override
  String get profile => 'Perfil';

  @override
  String get security => 'Seguridad';

  @override
  String get general => 'General';

  @override
  String get about => 'Acerca de';

  @override
  String get personalDetails => 'Datos personales';

  @override
  String get manageWallet => 'Gestionar billetera';

  @override
  String get addressBook => 'Libreta de direcciones';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get changePIN => 'Cambiar PIN';

  @override
  String get useFaceIdFingerprint => 'Usar Face ID / Huella dactilar';

  @override
  String get twoFactorAuthentication => 'Autenticación de dos factores';

  @override
  String get deviceManagement => 'Gestión de dispositivos';

  @override
  String get appAppearance => 'Apariencia de la app';

  @override
  String get pushNotifications => 'Notificaciones push';

  @override
  String get appLanguage => 'Idioma de la app';

  @override
  String get helpFeedback => 'Ayuda y comentarios';

  @override
  String get visitWebsite => 'Visitar sitio web';

  @override
  String get termsOfService => 'Términos de servicio';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get logOut => 'Cerrar sesión';

  @override
  String versionInfo(String version, String build) {
    return 'Versión $version (Build $build)';
  }

  @override
  String get appAppearanceSubtitle =>
      'Personaliza el aspecto de la app eligiendo tu tema e ícono preferidos.';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get appIcon => 'Ícono de la app';

  @override
  String get active => 'Activo';

  @override
  String get saving => 'Guardando...';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get legalFirstName => 'Nombre legal';

  @override
  String get legalLastName => 'Apellido legal';

  @override
  String get countryOfCitizenship => 'País de ciudadanía';

  @override
  String get dateOfBirth => 'Fecha de nacimiento';

  @override
  String get gender => 'Género';

  @override
  String get phoneNo => 'Teléfono';

  @override
  String get address => 'Dirección';

  @override
  String get country => 'País';

  @override
  String get accountDetails => 'Detalles de cuenta';

  @override
  String get taxInformation => 'Información fiscal';

  @override
  String get countryOfTaxResidence => 'País de residencia fiscal';

  @override
  String get taxId => 'ID fiscal';

  @override
  String get profilePhoto => 'Foto de perfil';

  @override
  String get editPhoto => 'Editar foto';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get profileDetails => 'Detalles del perfil';

  @override
  String get changePasswordSubtitle =>
      'Proporciona tus datos personales para completar tu perfil.';

  @override
  String get currentPassword => 'Contraseña actual';

  @override
  String get newPassword => 'Nueva contraseña';

  @override
  String get passwordRequirementsTitle => 'Debe contener al menos:';

  @override
  String get passwordReq8Chars => '8 caracteres';

  @override
  String get passwordReqNumber => 'Un número';

  @override
  String get passwordReqUppercase => 'Una letra mayúscula';

  @override
  String get passwordReqLowercase => 'Una letra minúscula';

  @override
  String get passwordReqSpecial => 'Un carácter especial';

  @override
  String get confirmNewPassword => 'Confirmar nueva contraseña';

  @override
  String get confirmNewPasswordHint =>
      'Tu nueva contraseña es la que usarás para acceder a tu cuenta.';

  @override
  String get deviceManagementSubtitle =>
      'Ve todos los dispositivos que han iniciado sesión. Elimina cualquiera para mayor seguridad.';

  @override
  String get currentDevice => 'Dispositivo actual';

  @override
  String get otherDevices => 'Otros dispositivos';

  @override
  String get deleteDevice => 'Eliminar dispositivo';

  @override
  String get deleteDeviceConfirm =>
      '¿Estás seguro de que deseas eliminar este dispositivo? Se requerirá contraseña para volver a iniciar sesión.';

  @override
  String get goBack => 'Volver';

  @override
  String get delete => 'Eliminar';

  @override
  String get logOutAllDevices => 'Cerrar sesión en todos los dispositivos';

  @override
  String get logOutAllDevicesConfirm =>
      '¿Estás seguro de que deseas cerrar sesión en todos los dispositivos? Tendrás que iniciar sesión nuevamente en cada uno.';

  @override
  String get logOutAllDevicesTitle =>
      'Cerrar sesión en todos los dispositivos conocidos';

  @override
  String get logOutAllDevicesSubtitle =>
      'Tendrás que volver a iniciar sesión en todos los dispositivos cerrados.';

  @override
  String get location => 'Ubicación:';

  @override
  String get lastLogin => 'Último acceso:';

  @override
  String get helpFeedbackSubtitle =>
      'Encuentra respuestas en nuestro Centro de ayuda o contacta soporte.';

  @override
  String get helpCenter => 'Centro de ayuda';

  @override
  String get helpCenterSubtitle =>
      'Encuentra respuestas rápidas con artículos y preguntas frecuentes.';

  @override
  String get chatWithUs => 'Chatea con nosotros';

  @override
  String get chatWithUsSubtitle =>
      '¿Necesitas ayuda rápida? Inicia un chat en vivo con nuestro equipo.';

  @override
  String get leaveFeedback => 'Dejar comentario';

  @override
  String get leaveFeedbackSubtitle =>
      'Dinos qué piensas. Tus comentarios nos ayudan a mejorar.';

  @override
  String get followUsOnSocialMedia => 'Síguenos en redes sociales';

  @override
  String get followUsSubtitle =>
      'Recibe actualizaciones y noticias siguiéndonos en tus plataformas favoritas.';

  @override
  String get wallets => 'Billeteras';

  @override
  String get manageWalletSubtitle =>
      'Ve los detalles de tu billetera y accede de forma segura a tu clave privada.';

  @override
  String get setupTwoFaTitle => 'Configura 2FA para tus transacciones';

  @override
  String get setupTwoFaSubtitle =>
      'Activa la autenticación de dos factores para una capa adicional de seguridad en tu cuenta.';

  @override
  String get activateNow => 'Activar ahora';

  @override
  String get twoFaCompleteTitle => 'Configuración de 2FA completa';

  @override
  String get twoFaCompleteSubtitle =>
      'La autenticación de dos factores está habilitada.';

  @override
  String get backToSettings => 'Volver a configuración';

  @override
  String get totalBalance => 'Saldo total';

  @override
  String get transactions => 'Transacciones';

  @override
  String get transactionsEmpty => 'Las transacciones aparecerán aquí';

  @override
  String get upcomingPayments => 'Pagos próximos';

  @override
  String get upcomingPaymentsEmpty => 'Los pagos próximos aparecerán aquí';

  @override
  String get workspace => 'Espacio de trabajo';

  @override
  String get contracts => 'Contratos';

  @override
  String get payCycle => 'Ciclo de pago';

  @override
  String get expenses => 'Gastos';

  @override
  String get timesheets => 'Hojas de tiempo';

  @override
  String get timeOff => 'Tiempo libre';

  @override
  String get finance => 'Finanzas';

  @override
  String get receive => 'Recibir';

  @override
  String get withdraw => 'Retirar';

  @override
  String get assets => 'Activos';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get invoices => 'Facturas';

  @override
  String get search => 'Buscar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get seeAll => 'Ver todo';

  @override
  String get needHelp => '¿Necesitas ayuda?';

  @override
  String get noContractsYet => 'Los contratos aparecerán aquí';

  @override
  String get exportPrivateKey => 'Exportar clave privada';

  @override
  String get exportPrivateKeySubtitle =>
      'Tu clave privada es la clave utilizada para respaldar tu billetera. Mantenla secreta y segura en todo momento.';

  @override
  String get keepScreenPrivateTitle => 'Mantén Tu Pantalla Privada';

  @override
  String get keepScreenPrivateDesc =>
      'Las capturas de pantalla o grabaciones de tus claves privadas pueden provocar la pérdida de la billetera.';

  @override
  String get storeKeysOfflineTitle => 'Almacena las Claves Fuera de Línea';

  @override
  String get storeKeysOfflineDesc =>
      'Evita compartir o guardar tus claves en la nube, ya que se comprometen fácilmente.';

  @override
  String get yourKeyYourWalletTitle => 'Tu Clave, Tu Billetera';

  @override
  String get yourKeyYourWalletDesc =>
      'Cualquiera con tus claves privadas puede acceder y robar tus activos.';

  @override
  String get revealPrivateKey => 'Revelar clave privada';

  @override
  String get yourPrivateKey => 'Tu clave privada';

  @override
  String get doNotSharePrivateKey => 'No Compartas Tu Clave Privada';

  @override
  String get privateKeyWarning =>
      'Tu clave privada da acceso completo a tu billetera. Nunca la compartas con nadie. Si alguien más la obtiene, puede robar tus activos.';

  @override
  String get copyToClipboard => 'Copiar al portapapeles';

  @override
  String get done => 'Listo';

  @override
  String get addressCopiedToClipboard => 'Dirección copiada al portapapeles';

  @override
  String get privateKeyCopiedToClipboard =>
      'Clave privada copiada al portapapeles';

  @override
  String get setupInstructions => 'Instrucciones de Configuración';

  @override
  String get scanQrCodeTitle => 'Escanear el código QR';

  @override
  String get scanQrCodeDesc =>
      'Escanea el código QR de arriba con tu aplicación de autenticación para obtener códigos generados';

  @override
  String get close => 'Cerrar';

  @override
  String get continueText => 'Continuar';

  @override
  String get copySetupKey => 'Copiar clave de configuración';

  @override
  String get viewBarcodeQrCode => 'Ver código de barras / QR';

  @override
  String get setupKeyCopied =>
      'Clave de configuración copiada al portapapeles.';

  @override
  String get step1Title => 'Descarga una aplicación de autenticación';

  @override
  String get step1Desc =>
      'Recomendamos descargar Google Authenticator si no tienes uno instalado.';

  @override
  String get step2Title =>
      'Escanea o copia la clave de configuración a continuación';

  @override
  String get step2Desc =>
      'Escanea este código QR desde la aplicación o copia la clave y pégala en la aplicación de autenticación';

  @override
  String get step3Title => 'Ingresa el código de 6 dígitos';

  @override
  String get step3Desc =>
      'Si escaneaste el código QR del paso 2, tu 2FA completará la configuración automáticamente. Si copiaste el código del paso 2, debes seleccionar el tipo de clave como \'Basado en tiempo\' para completar la configuración.';

  @override
  String get twoFaAuthCode => 'Código de Autenticación 2FA';

  @override
  String get twoFaAuthCodeSubtitle =>
      'Ingresa el código de 6 dígitos generado por la aplicación de autenticación';

  @override
  String get currentPINCode => 'Código PIN Actual';

  @override
  String get currentPINCodeSubtitle =>
      'Por favor proporciona tu PIN de 4 dígitos actual';

  @override
  String get incorrectPIN => 'PIN incorrecto. Por favor intenta de nuevo.';

  @override
  String get newPINCode => 'Nuevo Código PIN';

  @override
  String get newPINCodeSubtitle =>
      'Ingresa un código de 4 dígitos que usarás para iniciar sesión sin ingresar tus credenciales.';

  @override
  String get confirmNewPINCode => 'Confirmar Nuevo Código PIN';

  @override
  String get confirmNewPINCodeSubtitle =>
      'Ingresa el código de 4 dígitos nuevamente para confirmación.';

  @override
  String get pinsDoNotMatch =>
      'Los PINs no coinciden. Por favor intenta de nuevo.';

  @override
  String get deleteAccountReason => '¿Por qué has decidido eliminar tu cuenta?';

  @override
  String get deleteAccountWarning1 => 'Eliminar tu cuenta es irreversible.';

  @override
  String get deleteAccountWarning2 =>
      'Perderás todos los datos acumulados pero conservarás el acceso a la cuenta.';

  @override
  String get deleteAccountCommentHint =>
      '¿Te gustaría dejar alguna sugerencia o comentario?';

  @override
  String get editProfileDetails => 'Editar datos del perfil';

  @override
  String get editProfileDetailsSubtitle =>
      'Actualiza tu información personal para mantener tu perfil preciso y actualizado.';

  @override
  String get phoneNumber => 'Número de teléfono';

  @override
  String get dialCode => 'Código de marcación';

  @override
  String get editAddressDetails => 'Editar dirección';

  @override
  String get street => 'Calle';

  @override
  String get city => 'Ciudad';

  @override
  String get postalZipCode => 'Código postal / zip';

  @override
  String get editAccountDetails => 'Editar datos de cuenta';

  @override
  String get editAccountDetailsSubtitle =>
      'Actualiza tu correo para mantener el acceso a la cuenta y recibir notificaciones importantes.';

  @override
  String get currentEmail => 'Correo actual';

  @override
  String get newEmail => 'Nuevo correo';

  @override
  String get editTaxInformation => 'Editar información fiscal';

  @override
  String get editTaxInformationSubtitle =>
      'Actualiza tus datos fiscales para garantizar el cumplimiento y los informes precisos.';

  @override
  String get asset => 'Activo';

  @override
  String get network => 'Red';

  @override
  String get selectAsset => 'Seleccionar activo';

  @override
  String get selectNetwork => 'Seleccionar red';

  @override
  String get pasteOrScanAddress => 'Pegar o escanear dirección';

  @override
  String get paste => 'Pegar';

  @override
  String get walletLabel => 'Etiqueta de billetera';

  @override
  String get enterWalletLabel => 'Ingresa la etiqueta de billetera';

  @override
  String get save => 'Guardar';

  @override
  String get addNewAddress => 'Agregar nueva dirección';

  @override
  String get shareAddress => 'Compartir dirección';

  @override
  String get max => 'Máx';

  @override
  String get sendOnly => 'Envía solo';

  @override
  String get viaThe => 'a través de la';

  @override
  String assetSentTo(String assetName) {
    return '$assetName fue enviado exitosamente a';
  }

  @override
  String get amount => 'Monto';

  @override
  String get sendTo => 'Enviar a';

  @override
  String get to => 'Para';

  @override
  String get fee => 'Comisión';

  @override
  String get memo => 'Memo';

  @override
  String get preview => 'Vista previa';

  @override
  String get sent => '¡Enviado!';

  @override
  String get noSavedAddresses => 'No hay direcciones guardadas';

  @override
  String get noSavedAddressesDesc =>
      'Guarda tus direcciones de cripto favoritas para enviar fondos de forma más rápida y segura.';

  @override
  String get copyAddress => 'Copiar dirección';

  @override
  String get edit => 'Editar';

  @override
  String get addressRemoved => 'Dirección eliminada';

  @override
  String get contractsDesc =>
      'Crea, gestiona y haz seguimiento de tus contratos.';

  @override
  String get payCycleDesc => 'Gestiona pagos y registra envíos de trabajo.';

  @override
  String get invoiceDesc => 'Crea y envía facturas con facilidad.';

  @override
  String get expensesDesc => 'Registra y gestiona los gastos del proyecto.';

  @override
  String get timesheetsDesc => 'Rastrea horas y registra el tiempo de trabajo.';

  @override
  String get timeOffDesc => 'Solicita, programa y gestiona el tiempo libre.';

  @override
  String get addAddress => 'Agregar dirección';

  @override
  String get receivedFromWallet => 'Received from wallet';

  @override
  String get defiStakingReward => 'DeFi Staking Reward';

  @override
  String get withdrawal => 'Withdrawal';

  @override
  String get networkUsingAnyOtherAssetOrNetworkWillResultInPerm =>
      'network. Using any other asset or network will result in permanent loss.';

  @override
  String myAsset(String assetName) {
    return 'Mi $assetName';
  }

  @override
  String get walletAddressCopiedToClipboard =>
      'Wallet address copied to clipboard.';

  @override
  String get enterNewPassword => 'Enter New Password';

  @override
  String get passwordHasBeenReset => 'Password Has Been Reset!';

  @override
  String get youCanNowLogInWithYourNewPasswordAndContinueUsingY =>
      'You can now log in with your new password and continue using your account securely.';

  @override
  String get proceedToLogin => 'Proceed to login';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get enterYourEmailAddressToGetACodeToResetYourPassword =>
      'Enter your email address to get a code to reset your password.';

  @override
  String get verifyOtp => 'Verify OTP';

  @override
  String get tryCheckingYourJunkspamFolderOrResendTheCode =>
      'Try checking your junk/spam folder, or resend the code.';

  @override
  String get pleaseEnterThe6DigitOtpCodeSentTo =>
      'Please enter the 6 digit OTP code sent to';

  @override
  String get verifyCode => 'Verify code';

  @override
  String get welcomeBack => 'Welcome Back!';

  @override
  String get enterYourDetailsBelowToLoginToYourAccount =>
      'Enter your details below to login to your account.';

  @override
  String get emailAddress => 'Email address';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get logIn => 'Log In';

  @override
  String get logInUsingGoogle => 'Log in using Google';

  @override
  String get logInUsingApple => 'Log in using Apple';

  @override
  String get forgotYourPin => 'Forgot your PIN?';

  @override
  String get welcomeBackUsername => 'Welcome Back, \$userName';

  @override
  String get pleaseEnterYourPinToAccessYourAccount =>
      'Please enter your PIN to access your account.';

  @override
  String get enterPin => 'Enter PIN';
}
