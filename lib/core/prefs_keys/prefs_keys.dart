enum PrefsKeys {
  token('token-pref-key'),
  loggedIn('is-signed-in'),
  loggedOut('is-signed-out'),
  termsAndConditions('terms-and-conditions'),
  biometricLogin('biometrics-pref-key'),
  onboard('onboard-pref-key'),
  userEmail('user-email'),
  listingDraft('listing-draft'),
  userPassword('user-password'),
  user('user-pref-key'),
  banks('banks-pref-key'),
  recentLocations('recent-locations');

  const PrefsKeys(this.key);

  final String key;
}
