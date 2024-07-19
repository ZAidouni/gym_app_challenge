class AppTextsFr {
  static String error = "Erreur";
  static String firstMainWord = "Go";
  static String secondaryMainWord = "Coach";
  static String welcome = "bienvenue";
  static String welcomeDescription = "Ceci est une application d'entraînement qui vous aidera à vous mettre en forme et à le rester.";
  static String getStarted = "commencer";
  static String login = "se connecter";
  static String changeLanguage = "changer de langue";
  static String chooseLanguage = "choisir la langue";
  static String primaryLanguage = "en";
  static String secondaryLanguage = "fr";
  static String aboutYou = "à propos de vous";
  static String getStartedDescription = "nous voulons en savoir plus sur vous, suivez les prochaines étapes pour compléter les informations";
  static String skipIntro = "Passer l'intro";
  static String next = "Suivant";
  static String signIn = "se connecter";
  static String signUp = "s'inscrire";
  static String publier = "publier";
  static String loginDescription = "Rejoignez-nous aujourd'hui et transformez vos objectifs de fitness en réalité!";
  static String email = "email";
  static String password = "mot de passe";
  static String forgetPassword = "mot de passe oublié ?";
  static String forgot = "oublié?";
  static String resetPassword = "réinitialiser le mot de passe";
  static String yourEmail = "votre email";
  static String siret = "N° de carte professionnelle";
  static String forgotPasswordDescription = "NE VOUS INQUIÉTEZ PAS, NOUS POUVONS VOUS AIDER À RÉINITIALISER VOTRE MOT DE PASSE";
  static String emailSentText = "Nous vous avons envoyé un email pour vérifier votre compte. Veuillez vérifier votre boîte de réception et cliquer sur le lien pour le vérifier";
  static String coachVerif = "🚀 Félicitations ! Votre compte est presque prêt à être utilisé. 🎉\n\nNous vérifions les détails de votre compte et tout sera opérationnel sous peu. Merci pour votre patience et préparez-vous pour une expérience géniale avec nous !\n\nÀ très bientôt ! 👋";
  static String done = "terminé";
  static String reSendEmailVerification = "ré-envoyer la vérification de l'email";
  static String signUpDescription = "Rejoignez plus de 100 000 guerriers et entraînez-vous pour le prochain grand défi";
  static String username = "nom d'utilisateur";
  static String alreadyHaveAnAccount = "Vous avez déjà un compte ?";
  static String find = "trouver";
  static String yourWorkout = 'votre entraînement';
  static String filterBy = "Filtrer par :";
  static String cancel = "Annuler";
  static String apply = "Appliquer";
  static String configureSettings = "paramètres";
  static String hours = "heures";
  static String moves = "mouvements";
  static String sets = "séries";
  static String minutes = "min";
  static String freeTrial = "essai gratuit";
  static String noFreeTrialAvailable = "Aucun aperçu disponible";
  static String searchWorkout = "Rechercher un entraînement";
  static String seeAll = 'voir tout';
  static String somethingWrong = "quelque chose ne va pas";
  static String hey = "Hey,";
  static String subscribe = "s'abonner";
  static String addToCard = "ajouter au panier";
  static String profile = "profil";
  static String logOut = "se déconnecter";
  static String workoutOfDay = "Entraînement du jour";
  static String pushyourlimit = 'poussez vos limites';
  static String basedOnReviews = "basé sur les avis des coachs";
  static String dailyFreeWorkout = "Pour vous";
  static String choosedCarefully = "choisi avec soin";
  static String allWorkouts = 'tous les entraînements';
  static String pleaseVerifyEmail = "Veuillez d'abord vérifier votre email";
  static String enterEmail = "veuillez entrer votre email";

  //fonction de traduction de texte
  static String getText(String key) {
    switch (key) {
      case 'error':
        return error;
      case 'firstMainWord':
        return firstMainWord;
      case 'secondaryMainWord':
        return secondaryMainWord;
      case 'welcome':
        return welcome;
    // Add cases for all your existing text strings here
      case 'coachVerif':
        return coachVerif;
      case 'done':
        return done;
      default:
        return key;
    }
  }
}
