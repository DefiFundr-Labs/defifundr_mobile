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
  String get receivedFromWallet => 'Recibido desde billetera';

  @override
  String get defiStakingReward => 'Recompensa de staking DeFi';

  @override
  String get withdrawal => 'Retiro';

  @override
  String get networkUsingAnyOtherAssetOrNetworkWillResultInPerm =>
      'red. Usar cualquier otro activo o red resultará en pérdida permanente.';

  @override
  String myAsset(String assetName) {
    return 'Mi $assetName';
  }

  @override
  String get walletAddressCopiedToClipboard =>
      'Dirección de billetera copiada al portapapeles.';

  @override
  String get enterNewPassword => 'Ingresa nueva contraseña';

  @override
  String get passwordHasBeenReset => '¡Contraseña restablecida!';

  @override
  String get youCanNowLogInWithYourNewPasswordAndContinueUsingY =>
      'Ahora puedes iniciar sesión con tu nueva contraseña y continuar usando tu cuenta de forma segura.';

  @override
  String get proceedToLogin => 'Ir al inicio de sesión';

  @override
  String get resetPassword => 'Restablecer contraseña';

  @override
  String get enterYourEmailAddressToGetACodeToResetYourPassword =>
      'Ingresa tu correo electrónico para obtener un código y restablecer tu contraseña.';

  @override
  String get verifyOtp => 'Verificar OTP';

  @override
  String get tryCheckingYourJunkspamFolderOrResendTheCode =>
      'Intenta revisar tu carpeta de spam o reenvía el código.';

  @override
  String get pleaseEnterThe6DigitOtpCodeSentTo =>
      'Por favor ingresa el código OTP de 6 dígitos enviado a';

  @override
  String get verifyCode => 'Verificar código';

  @override
  String get welcomeBack => '¡Bienvenido de vuelta!';

  @override
  String get enterYourDetailsBelowToLoginToYourAccount =>
      'Ingresa tus datos para iniciar sesión en tu cuenta.';

  @override
  String get emailAddress => 'Correo electrónico';

  @override
  String get enterPassword => 'Ingresa tu contraseña';

  @override
  String get logIn => 'Iniciar sesión';

  @override
  String get logInUsingGoogle => 'Iniciar sesión con Google';

  @override
  String get logInUsingApple => 'Iniciar sesión con Apple';

  @override
  String get forgotYourPin => '¿Olvidaste tu PIN?';

  @override
  String get welcomeBackUsername => 'Bienvenido de vuelta, \$userName';

  @override
  String get pleaseEnterYourPinToAccessYourAccount =>
      'Por favor ingresa tu PIN para acceder a tu cuenta.';

  @override
  String get enterPin => 'Ingresa tu PIN';

  @override
  String get welcomeWithEmoji => '¡Bienvenido! 👋🏾';

  @override
  String get quickActions => 'Acciones rápidas';

  @override
  String get contractAction => 'Contrato';

  @override
  String get invoiceAction => 'Factura';

  @override
  String get quickpayAction => 'Quickpay';

  @override
  String get completeAccountSetup => 'Completar configuración de cuenta';

  @override
  String get finishSetupToStart =>
      'Termina de configurar tu cuenta para comenzar a enviar facturas y firmar contratos.';

  @override
  String get onboardingChecklist => 'Lista de verificación';

  @override
  String get completeAllStepsToActivate =>
      'Debes completar todos los pasos para activar completamente tu cuenta.';

  @override
  String get createFreelancerAccount => 'Crear cuenta de freelance';

  @override
  String get verifyYourIdentity => 'Verifica tu identidad';

  @override
  String get provideYourBvn => 'Proporciona tu BVN';

  @override
  String get addTaxInfoForCompliance => 'Añadir información fiscal';

  @override
  String get fundWalletWithTokens => 'Fondear cartera con tokens';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get noNotificationsYet => 'Aún no hay notificaciones.';

  @override
  String get notificationsUpdatesReady =>
      'Tus actualizaciones aparecerán aquí cuando estén listas.';

  @override
  String get createAnAccount => 'Crear una cuenta';

  @override
  String get enterDetailsToCreateAccount =>
      'Ingresa tus datos para crear tu cuenta.';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get signUpUsingGoogle => 'Registrarse con Google';

  @override
  String get signUpUsingApple => 'Registrarse con Apple';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get createYourPassword => 'Crea tu contraseña';

  @override
  String get enterPasswordToKeepSafe =>
      'Ingresa una contraseña para mantener tu cuenta segura.';

  @override
  String get verifyYourEmail => 'Verifica tu correo';

  @override
  String get verifyAccount => 'Verificar cuenta';

  @override
  String get byCreatingAccountYouAgree =>
      'Al crear una cuenta, aceptas nuestros';

  @override
  String get productTandCs => 'Términos del producto';

  @override
  String get accountType => 'Tipo de cuenta';

  @override
  String get freelancerAccount => 'Cuenta de freelance';

  @override
  String get contractorAccount => 'Cuenta de contratista';

  @override
  String get businessCorporateAccount => 'Cuenta empresarial/corporativa';

  @override
  String get addressDetails => 'Datos de dirección';

  @override
  String get provideAddressDetails =>
      'Proporciona tu dirección, esto se usará para completar tu perfil.';

  @override
  String get finishSetup => 'Finalizar configuración';

  @override
  String get yourProfileCreated => '¡Tu perfil ha sido creado!';

  @override
  String get pinCreatedSuccessMessage =>
      'Tu PIN se ha creado correctamente. Ahora puedes usar este PIN para iniciar sesión de forma segura.';

  @override
  String get confirmYourPinCode => 'Confirma tu código PIN';

  @override
  String get createYourPinCode => 'Crea tu código PIN';

  @override
  String get enableFaceId => 'Habilitar inicio de sesión con Face ID';

  @override
  String get faceIdDescription =>
      'Disfruta de un inicio de sesión seguro y fluido con Face ID.';

  @override
  String get enable => 'Habilitar';

  @override
  String get skip => 'Omitir';

  @override
  String get enableFingerprint => 'Habilitar inicio de sesión con huella';

  @override
  String get fingerprintDescription =>
      'Disfruta de un inicio de sesión seguro y fluido con huella dactilar.';

  @override
  String get enablePushNotifications => 'Habilitar notificaciones push';

  @override
  String get pushNotificationsDescription =>
      'Para actualizaciones instantáneas y anuncios importantes.';

  @override
  String get yourPinCreated => '¡Tu PIN ha sido creado!';

  @override
  String get pinCreatedLoginMessage =>
      'Tu PIN se ha creado correctamente. Ahora puedes usar este PIN para iniciar sesión.';

  @override
  String get changeAddressDescription =>
      'Cambia o corrige tu dirección para asegurar que los registros y las comunicaciones sean precisos.';

  @override
  String get taxIdentification => 'Identificación de impuestos';

  @override
  String get useMyProfileAddress => 'Usar la dirección de mi perfil';

  @override
  String get facebook => 'Facebook';

  @override
  String get instagram => 'Instagram';

  @override
  String get linkedIn => 'LinkedIn';

  @override
  String get xTwitter => 'X (antes Twitter)';

  @override
  String get attachmentOptional => 'Archivo adjunto (Opcional)';

  @override
  String get clickToUpload => 'Haz clic para subir';

  @override
  String get selectCategory => 'Seleccionar categoría';

  @override
  String get addExpense => 'Añadir gasto';

  @override
  String get expenseName => 'Nombre del gasto';

  @override
  String get enterExpenseName => 'Introducir nombre del gasto';

  @override
  String get expenseCategory => 'Categoría';

  @override
  String get expenseDate => 'Fecha del gasto';

  @override
  String get selectDate => 'Seleccionar fecha';

  @override
  String get enterAmountLabel => 'Introducir cantidad';

  @override
  String get enterExpenseDescription => 'Introducir descripción del gasto';

  @override
  String get supportedFormats => 'Formatos compatibles:';

  @override
  String get jpgPngHeicOrPdf => 'JPG, PNG, HEIC o PDF';

  @override
  String get maxFileSizeLabel => '; Tamaño máximo de archivo:';

  @override
  String get expenseDetails => 'Detalles del gasto';

  @override
  String get expenseStatus => 'Estado';

  @override
  String get expenseNameLabel => 'Nombre';

  @override
  String get submissionDate => 'Fecha de envío';

  @override
  String get expenseDescription => 'Descripción';

  @override
  String get attachment => 'Archivo adjunto';

  @override
  String get reasonForRejection => 'Razón del rechazo';

  @override
  String get contractType => 'Tipo de contrato';

  @override
  String get expenseClient => 'Cliente';

  @override
  String get deleteExpense => 'Eliminar gasto';

  @override
  String get expenseSubmitted => 'Gasto enviado';

  @override
  String get expenseSubmittedDesc1 =>
      'Se ha enviado un correo electrónico para que su solicitud\nsea revisada.';

  @override
  String get expenseSubmittedDesc2 =>
      'Se ha enviado un correo electrónico para que su solicitud sea revisada.';

  @override
  String get timeOffDetails => 'Detalles del tiempo libre';

  @override
  String get deleteTimeOffTitle => '¿Eliminar tiempo libre?';

  @override
  String get deleteTimeOffPrompt =>
      '¿Estás seguro de que quieres eliminar esta solicitud de tiempo libre?';

  @override
  String get deleteTimeOff => 'Eliminar tiempo libre';

  @override
  String get deleteExpenseTitle => '¿Eliminar gasto?';

  @override
  String get deleteExpensePrompt =>
      '¿Estás seguro de que quieres eliminar este gasto?';

  @override
  String get noExpensesYet => 'No hay gastos todavía';

  @override
  String get noExpensesDesc =>
      'Mantén un registro de los gastos relacionados con tus contratos\naquí.';

  @override
  String get invoiceThankYouNote =>
      'Gracias por su negocio. Remita el pago de acuerdo con los términos de esta factura. Si tiene preguntas, no dude en contactarnos.';

  @override
  String get invoiceOverdue => 'Factura Vencida';

  @override
  String get billedTo => 'Facturado a';

  @override
  String get billedFrom => 'Facturado desde';

  @override
  String get invoiceBreakdown => 'Desglose de Factura';

  @override
  String get paymentTracker => 'Seguimiento de Pagos';

  @override
  String get paymentMemo => 'Nota de Pago';

  @override
  String get invoiceCreatedSentClient => 'Factura creada y enviada al cliente';

  @override
  String get processClientPayment => 'Procese el pago de su cliente';

  @override
  String get fundsReflectedMessage =>
      'Según su factura, los fondos deberían reflejarse en su saldo el 31 de mayo de 2025.';

  @override
  String get clientPaymentConfirmed => 'Pago del cliente confirmado';

  @override
  String get clientPaymentProcessed => 'Pago del cliente procesado';

  @override
  String get fundsReceivedInAccount => 'Fondos recibidos en su cuenta';

  @override
  String get previewPdf => 'Vista Previa del PDF';

  @override
  String get downloadPdf => 'Descargar PDF';

  @override
  String get receiveCryptoInstantly =>
      'Reciba pagos en criptomonedas al instante mediante dirección, código QR o enlace de pago.';

  @override
  String get filterBy => 'Filtrar por';

  @override
  String get dateLabel => 'Fecha';

  @override
  String get noQuickpayActivity => 'Aún no hay actividad de Quickpay.';

  @override
  String get quickpayActivityShowHere =>
      'Su actividad de quickpay aparecerá aquí una vez que reciba una.';

  @override
  String get clearAll => 'Borrar todo';

  @override
  String get showResults => 'Mostrar resultados';

  @override
  String get receivePayment => 'Recibir pago';

  @override
  String get titleLabel => 'Título';

  @override
  String get shareQrCode => 'Compartir código QR';

  @override
  String get sharePayLink => 'Compartir enlace de pago';

  @override
  String get fromLabel => 'De';

  @override
  String get transactionId => 'ID de Transacción';

  @override
  String get helpCentre => 'Centro de ayuda';

  @override
  String get shareReceipt => 'Compartir recibo';

  @override
  String get allLabel => 'Todos';
}
