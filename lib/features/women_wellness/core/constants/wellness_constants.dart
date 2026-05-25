/// Centralized strings, messages, keys, and tips for women wellness.
class WellnessConstants {
  WellnessConstants._();

  static const appTitle = 'Her Wellness Calendar';
  static const moduleTitle = 'Women Wellness';
  static const dashboardTitle = 'Cycle overview';
  static const profileTitle = 'Wellness profile';
  static const calendarTitle = 'Wellness calendar';
  static const periodTrackingTitle = 'Period tracking';
  static const addEditPeriodTitle = 'Add/Edit Period';
  static const addPeriodTitle = 'Add period';
  static const editPeriodTitle = 'Edit period';
  static const periodTrackingEmpty =
      'No period entries yet. Add a start date to begin tracking.';
  static const periodTrackingLoadError =
      'Unable to load period history. Please try again.';
  static const periodTrackingSaveError =
      'Unable to save period entry. Please review the form and try again.';
  static const periodEntrySaved = 'Period entry saved.';
  static const periodEntryDeleted = 'Period entry deleted.';
  static const periodTrackingMockAsset = 'assets/mock/period_tracking.json';
  static const periodTrackingEndpoint = '/api/v1/women-wellness/periods';
  static const periodTrackingIdPath = 'id';
  static const startDate = 'Start date';
  static const endDate = 'End date';
  static const optional = 'Optional';
  static const periodLength = 'Period length';
  static const day = 'day';
  static const irregularCycleNote = 'Irregular cycle note';
  static const irregularCycleNoteHint =
      'Optional note for cycle changes, stress, travel, or symptoms';
  static const periodNotesHint = 'Optional private period notes';
  static const savePeriod = 'Save period';
  static const deletePeriod = 'Delete period';
  static const deletePeriodTitle = 'Delete period entry?';
  static const deletePeriodConfirmation =
      'This period entry will be permanently deleted. This action cannot be undone.';
  static const dailyLogTitle = 'Daily log';
  static const dailyLogEmpty =
      'No daily logs yet. Add today\'s wellness details to start tracking.';
  static const dailyLogLoadError =
      'Unable to load daily logs. Please try again.';
  static const dailyLogSaveError =
      'Unable to save daily log. Please review the form and try again.';
  static const dailyLogSaved = 'Daily log saved.';
  static const dailyLogDeleted = 'Daily log deleted.';
  static const dailyLogMockAsset = 'assets/mock/daily_logs.json';
  static const dailyLogEndpoint = '/api/v1/women-wellness/daily-logs';
  static const dailyLogIdPath = 'id';
  static const logDate = 'Log date';
  static const flow = 'Flow';
  static const pain = 'Pain';
  static const mood = 'Mood';
  static const symptoms = 'Symptoms';
  static const energy = 'Energy';
  static const sleep = 'Sleep';
  static const waterIntake = 'Water intake';
  static const glasses = 'glasses';
  static const medicineTaken = 'Medicine taken';
  static const medicineName = 'Medicine name';
  static const medicineNameRequired =
      'Medicine name is required when medicine is marked as taken.';
  static const customNotes = 'Custom notes';
  static const customNotesHint = 'Optional private daily notes';
  static const saveDailyLog = 'Save daily log';
  static const deleteDailyLog = 'Delete daily log';
  static const deleteDailyLogTitle = 'Delete daily log?';
  static const deleteDailyLogConfirmation =
      'This daily log will be permanently deleted. This action cannot be undone.';
  static const symptomsTitle = 'Symptoms';
  static const symptomsSelectionTitle = 'Select symptoms';
  static const symptomsEmpty =
      'No symptoms match your search. Try a different keyword.';
  static const symptomsLoadError = 'Unable to load symptoms. Please try again.';
  static const symptomsSaved = 'Symptoms saved.';
  static const symptomsSaveError =
      'Unable to save selected symptoms. Please try again.';
  static const symptomsSearchHint = 'Search symptoms';
  static const recentlyUsedSymptoms = 'Recently used';
  static const allSymptoms = 'All symptoms';
  static const customSymptom = 'Custom symptom';
  static const addCustomSymptom = 'Add custom symptom';
  static const customSymptomHint = 'Enter symptom name';
  static const done = 'Done';
  static const symptomsMockAsset = 'assets/mock/symptoms.json';
  static const symptomsEndpoint = '/api/v1/women-wellness/symptoms';
  static const selectedSymptomsEndpoint =
      '/api/v1/women-wellness/symptoms/selected';
  static const reportsTitle = 'Reports';
  static const reportsMockAsset = 'assets/mock/women_wellness.json';
  static const reportsEndpoint = '/api/v1/women-wellness/reports';
  static const cycleHistoryTitle = 'Cycle history';
  static const remindersTitle = 'Reminders';
  static const remindersMockAsset = 'assets/mock/women_wellness.json';
  static const remindersEndpoint = '/api/v1/women-wellness/reminders';
  static const privacyTitle = 'Privacy & safety';
  static const privacyHeroTitle = 'Your data stays yours';
  static const privacyHeroSubtitle =
      'Control who sees your cycle, logs, and reminders. You decide what is stored and what is shared.';
  static const privacyTrustNoSell = 'We never sell your cycle data';
  static const privacyTrustOnDevice =
      'Logs stay on your device unless you turn on cloud backup';
  static const privacyTrustDelete =
      'Delete your wellness history or account anytime';
  static const privacySectionLock = 'Lock & access';
  static const privacySectionLockHint =
      'Keep wellness details private when you open the app';
  static const privacySectionDiscretion = 'Discretion';
  static const privacySectionDiscretionHint =
      'Reduce sensitive details on your lock screen';
  static const privacySectionData = 'Your data';
  static const privacySectionDataHint =
      'Choose how information is stored and backed up';
  static const privacyDataStoredTitle = 'What we store';
  static const privacyDataStoredBody =
      'Cycle dates, daily logs, symptoms, and profile details you enter. We use this only to show your calendar and insights—not for ads.';
  static const privacyEmpty =
      'Privacy settings are not available yet. Please try again.';
  static const privacyLoadError =
      'Unable to load privacy settings. Please try again.';
  static const privacySaveError =
      'Unable to update privacy settings. Please try again.';
  static const privacySaveSuccess = 'Privacy settings updated.';
  static const privacyMockAsset = 'assets/mock/privacy_settings.json';
  static const privacyEndpoint = '/api/v1/women-wellness/privacy';
  static const privacyDeleteWellnessDataEndpoint =
      '/api/v1/women-wellness/privacy/wellness-data';
  static const privacyDeleteAccountEndpoint =
      '/api/v1/women-wellness/privacy/account';
  static const dangerZone = 'Danger zone';
  static const deleteWellnessData = 'Delete wellness data';
  static const deleteAccountAndData = 'Delete account and data';
  static const deleteWellnessDataTitle = 'Delete wellness data?';
  static const deleteAccountAndDataTitle = 'Delete account and data?';
  static const deleteAccountAndDataConfirmation =
      'This will permanently delete your account and all wellness data. This action cannot be undone.';
  static const wellnessDataDeleted = 'Wellness data deleted.';
  static const accountAndDataDeleted = 'Account and wellness data deleted.';
  static const privacyAppLockTitle = 'App lock';
  static const privacyAppLockSubtitle =
      'Require app unlock before showing wellness data.';
  static const privacyPinTitle = 'PIN';
  static const privacyPinSubtitle = 'Use a PIN as a private unlock method.';
  static const privacyBiometricTitle = 'Biometric unlock';
  static const privacyBiometricSubtitle =
      'Allow biometric unlock when the device supports it.';
  static const privacyHideNotificationTitle = 'Hide notification text';
  static const privacyHideNotificationSubtitle =
      'Do not show sensitive wellness text on the lock screen.';
  static const privacyEncryptedStorageTitle = 'Encrypted local storage';
  static const privacyEncryptedStorageSubtitle =
      'Store wellness data using encrypted local storage.';
  static const privacyCloudBackupTitle = 'Allow cloud backup';
  static const privacyCloudBackupSubtitle =
      'Permit encrypted cloud backup only when you choose it.';
  static const pdfReportTitle = 'PDF report';
  static const pdfReportHeading = 'Women Wellness Report';
  static const profileSummary = 'Profile Summary';
  static const profileEmpty =
      'Your wellness profile is not available yet. Add cycle details to personalize predictions.';
  static const profileLoadError =
      'Unable to load wellness profile. Please try again.';
  static const profileSaveSuccess = 'Wellness profile saved.';
  static const profileSaveError =
      'Unable to save wellness profile. Please review the form and try again.';
  static const profileFormTitle = 'Cycle baseline';
  static const profileFormSubtitle =
      'These details help estimate cycle dates and personalize wellness insights.';
  static const cycleSummary = 'Cycle Summary';
  static const periodHistory = 'Period History';
  static const flowTrend = 'Flow Trend';
  static const painTrend = 'Pain Trend';
  static const moodTrend = 'Mood Trend';
  static const commonSymptoms = 'Common Symptoms';
  static const pmsPattern = 'PMS Pattern';
  static const notes = 'Notes';
  static const ageGroup = 'Age group';
  static const ageGroupHint = 'Select age group';
  static const notSelected = 'Not selected';
  static const active = 'Active';
  static const averageCycleLength = 'Average cycle length';
  static const averagePeriodLength = 'Average period length';
  static const lastPeriodStartDate = 'Last period start date';
  static const healthNotes = 'Health notes';
  static const healthNotesHint = 'Optional notes for your private reference';
  static const selectDate = 'Select date';
  static const selectedDate = 'Selected date';
  static const saving = 'Saving...';
  static const cycleRegularity = 'Cycle regularity';
  static const days = 'days';

  static const medicalDisclaimerTitle = 'Medical disclaimer';
  static const medicalDisclaimer =
      'Cycle predictions and wellness insights are estimates based on the information you provide. They are not medical advice, diagnosis, treatment, contraception guidance, or a substitute for care from a qualified healthcare professional.';
  static const disclaimer = medicalDisclaimer;
  static const urgentCareDisclaimer =
      'Seek urgent medical support for severe pain, unusually heavy bleeding, fainting, fever, pregnancy concerns, or symptoms that feel unsafe or unusual for you.';
  static const privacyDisclaimer =
      'Your wellness data may be sensitive. Review privacy settings before enabling reminders or sharing reports.';

  static const latePeriodMessage =
      'Your period appears to be later than expected based on your saved cycle length. This can happen for many reasons. Please consult a healthcare professional if you are concerned.';
  static const irregularCycleWarning =
      'Your recent cycle pattern looks irregular. Predictions may be less accurate.';
  static const deleteConfirmation =
      'This will permanently delete your wellness tracking history. This action cannot be undone.';
  static const dashboardEmpty =
      'Add your last period date to start personalized cycle tracking.';
  static const calendarEmpty =
      'Your calendar will show period, ovulation, fertile, and wellness log markers once you start tracking.';
  static const reportsEmpty = 'Track at least one cycle to generate reports.';
  static const error = 'Something went wrong. Please try again.';
  static const loading = 'Loading wellness data...';
  static const retry = 'Retry';
  static const cancel = 'Cancel';
  static const confirm = 'Confirm';
  static const save = 'Save';
  static const delete = 'Delete';
  static const edit = 'Edit';
  static const add = 'Add';
  static const close = 'Close';
  static const viewReport = 'View report';
  static const exportPdf = 'Export PDF';
  static const none = 'None';
  static const spotting = 'Spotting';
  static const light = 'Light';
  static const medium = 'Medium';
  static const heavy = 'Heavy';
  static const mild = 'Mild';
  static const moderate = 'Moderate';
  static const severe = 'Severe';
  static const happy = 'Happy';
  static const sad = 'Sad';
  static const angry = 'Angry';
  static const tired = 'Tired';
  static const anxious = 'Anxious';
  static const emotional = 'Emotional';
  static const cramps = 'Cramps';
  static const headache = 'Headache';
  static const acne = 'Acne';
  static const bloating = 'Bloating';
  static const backPain = 'Back pain';
  static const nausea = 'Nausea';
  static const breastTenderness = 'Breast tenderness';
  static const low = 'Low';
  static const normal = 'Normal';
  static const high = 'High';
  static const poor = 'Poor';
  static const average = 'Average';
  static const good = 'Good';
  static const excellent = 'Excellent';
  static const upcomingPeriod = 'Upcoming period';
  static const ovulation = 'Ovulation';
  static const dailyLog = 'Daily log';
  static const medicine = 'Medicine';
  static const hydration = 'Hydration';
  static const appointment = 'Appointment';
  static const confirmedPeriod = 'Confirmed period';
  static const predictedPeriod = 'Predicted period';
  static const fertileWindow = 'Fertile window';
  static const pms = 'PMS';
  static const logged = 'Logged';
  static const flowLevelPrefix = 'Flow level';
  static const painLevelPrefix = 'Pain level';
  static const moodPrefix = 'Mood';
  static const symptomPrefix = 'Symptom';
  static const energyLevelPrefix = 'Energy level';
  static const sleepQualityPrefix = 'Sleep quality';
  static const reminderSuffix = 'reminder';

  static const startDateRequired = 'Please select period start date.';
  static const endBeforeStart = 'Period end date cannot be before start date.';
  static const unusuallyLongPeriod =
      'Period length looks longer than usual. Please confirm if this is correct.';
  static const cycleLengthRange =
      'Average cycle length should usually be 21 to 45 days.';
  static const periodLengthRange =
      'Average period length should usually be 2 to 10 days.';
  static const requiredField = 'This field is required.';
  static const futureDateNotAllowed = 'Date cannot be in the future.';

  static const mockAsset = 'assets/mock/women_wellness.json';
  static const profileMockAsset = 'assets/mock/wellness_profile.json';
  static const profileEndpoint = '/api/v1/women-wellness/profile';
  static const profileUserIdQuery = 'userId';
  static const privateNotificationTitle = 'Wellness Reminder';
  static const privateNotificationBody =
      'You have a private wellness reminder.';
  static const periodNotificationTitle = 'Period Reminder';
  static const periodNotificationBody = 'Your period is expected in 2 days.';
  static const pdfFooter =
      'Generated from wellness tracking data. This report is not medical advice.';

  static const wellnessTips = [
    'Hydrate regularly, especially during your period or after exercise.',
    'Gentle movement, stretching, or heat therapy may help with mild cramps.',
    'Track mood, sleep, flow, and symptoms to notice cycle patterns over time.',
    'Prioritize consistent sleep during low-energy cycle phases.',
    'Choose iron-rich foods during heavier bleeding days when appropriate.',
    'Reduce caffeine if it appears to worsen tenderness, anxiety, or sleep.',
    'Speak with a healthcare professional if symptoms become severe, sudden, or unusual.',
  ];

  static const tips = wellnessTips;

  static const ageGroups = ['Under 18', '18-24', '25-34', '35-44', '45+'];
}
