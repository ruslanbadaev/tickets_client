class AppStrings {
  static const String setLanguage = 'set_language';
  static const String login = 'login';
  static const String loginSubtitle = 'login_subtitle';
  static const String settings = 'settings';
  static const String settingsSubtitle = 'settings_subtitle';
  static const String language = 'language';
  static const String languageSubtitle = 'language_subtitle';
  static const String feedback = 'feedback';
  static const String feedbackSubtitle = 'feedback_subtitle';
  static const String aboutUs = 'about_us';
  static const String aboutUsSubtitle = 'about_us_subtitle';
  static const String deletingAccount = 'deleting_account';
  static const String deletingAccountSubtitle = 'deleting_account_subtitle';
  static const String logout = 'logout';
  static const String logoutSubtitle = 'logout_subtitle';
  static const String password = 'password';
  static const String signUp = 'sign_up';
  static const String forgotPassword = 'forgot_password';

  /// 1
  static const String name = 'name';
  static const String cancel = 'cancel';
  static const String theme = 'theme';
  static const String light = 'light';
  static const String dark = 'dark';
  static const String colorScheme = 'color_scheme';
  static const String classic = 'classic';
  static const String notifications = 'notifications';
  static const String enabled = 'enabled';
  static const String disabled = 'disabled';
  static const String appSettings = 'app_settings';
  static const String loginToWriteComment = 'login_to_write_comment';
  static const String comingSoon = 'coming_soon';
  static const String newest = 'newest';
  static const String your = 'your';

  /// 2
  static const String creator = 'creator';
  static const String setEmoji = 'set_emoji';
  static const String eventTitle = 'event_title';
  static const String what = 'what';
  static const String eventDescription = 'event_description';
  static const String where = 'where';
  static const String eventLocation = 'event_location';
  static const String when = 'when';
  static const String setDateAndTime = 'set_date_and_time';
  static const String comments = 'comments';
  static const String addToCalendar = 'add_to_calendar';
  static const String share = 'share';
  static const String noData = 'no_data';
  static const String typeComment = 'type_comment';

  /// 3
  static const String menu = 'menu';
  static const String sendAComplaint = 'send_a_complaint';
  static const String addToFavorites = 'add_to_favorites';
  static const String close = 'close';
  static const String partyToday = 'party_today';
  static const String partyIsIn2Hours = 'party_is_in_2_hours';
  static const String partyIsAlreadyOn = 'party_is_already_on';
  static const String partyScanner = 'party_scanner';
  static const String welcome = 'welcome';
  static const String haveAGoodTime = 'have_a_good_time';
  static const String addPhoto = 'add_photo';
  static const String done = 'done';

  /// 4
  static const String setLocation = 'set_location';
  static const String emojiSelected = 'emoji_selected';
  static const String photoSelected = 'photo_selected';
  static const String titleIsFilled = 'title_is_filled';
  static const String descriptionIsFilled = 'description_is_filled';
  static const String locationIsFilled = 'location_is_filled';
  static const String userIsLoggedIn = 'user_is_logged_in';
  static const String dateAndTimeIsFilled = 'date_and_time_is_filled';
  static const String createEvent = 'create_event';
  static const String warning = 'warning';

  ///5
  static const String areYouSureWantPublish = 'are_you_sure_want_publish';
  static const String confirm = 'confirm';
  static const String loading = 'loading';
  static const String perfect = 'perfect';
  static const String partyWasCreated = 'party_was_created';
  static const String created = 'created';
  static const String lastSignInTime = 'last_sign_in_time';
  static const String verified = 'verified';

  ///6

  static const String creatingComplaint = 'creating_complaint';
  static const String subjectComplaint = 'subject_complaint';
  static const String description = 'description';
  static const String typeHere = 'type_here';
  static const String send = 'send';
  static const String authorizationWasSuccessful = 'authorization_was_successful';
  static const String copy = 'copy';
  static const String areYouWantToDelete = 'are_you_want_to_delete';
  static const String delete = 'delete';
  static const String report = 'report';
  static const String thankYouForVigilance = 'thank_you_for_vigilance';
  static const String weHaveStartedInvestigation = 'we_have_started_investigation';
  static const String pleaseCompleteVerification = 'please_complete_verification';
  static const String partySuccessfullyCreated = 'party_successfully_created';
  static const String deleteEvent = 'delete_event';
  static const String areYouSureWantToDelete = 'are_you_sure_want_to_delete';
  static const String noPermission = 'no_permission';

  /// 7
  static const String error = 'error';
  static const String changeEmoji = 'change_emoji';
  static const String tapHereToSetEmoji = 'tap_here_to_set_emoji';
  static const String areYouSureCannotBeUndone = 'are_you_sure_cannot_be_undone';
  static const String doYouReallyWantToResetAuth = 'do_you_really_want_to_reset_auth';

  /// 8
  static const String iAgreeWith = 'i_agree_with';
  static const String privacy = 'privacy';
  static const String policy = 'policy';

  static String getInitials(String name) {
    String initials = 'o_O';
    initials = initials.replaceAll('  ', ' ');
    if (name.replaceAll(' ', '').isNotEmpty) {
      if (name.split(' ').length > 1) {
        if (name.split(' ')[0].isNotEmpty && name.split(' ')[1].isNotEmpty) {
          initials = '${name.split(' ')[0][0]}${name.split(' ')[1][0]}'.toUpperCase();
        }
      } else if (name.split(' ').length == 1) {
        initials = name.length > 2 ? '${name[0]}${name[1]}' : name[0];
      }
    }

    return initials;
  }
}
