# amTips — Android Release Signing Setup

## Create the keystore (one-time)

```bash
keytool -genkey -v \
  -keystore amtips.keystore \
  -alias amtips \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000
```

Store `amtips.keystore` somewhere **outside** the git repo (e.g. `~/.android/amtips.keystore`).

## Set environment variables before building

```bash
export KEY_STORE_PATH="$HOME/.android/amtips.keystore"
export KEY_ALIAS="amtips"
export STORE_PASSWORD="your_store_password"
export KEY_PASSWORD="your_key_password"
```

## Build signed release APK

```bash
flutter build apk --release
# or
flutter build appbundle --release
```

## CI/CD (GitHub Actions example)

Add secrets in repo Settings → Secrets:
- `KEY_STORE_PATH` (or upload keystore as base64 secret)
- `KEY_ALIAS`
- `STORE_PASSWORD`
- `KEY_PASSWORD`

## Play Store SHA-1 fingerprint

After creating the keystore, get the SHA-1 for Firebase:

```bash
keytool -list -v -keystore amtips.keystore -alias amtips
```

Add the SHA-1 to Firebase Console → amtips-app → Android app → SHA certificate fingerprints.

## Important
- Never commit the .keystore file to git
- Add `*.keystore` to `.gitignore`
- Keep a secure backup of the keystore — if lost, you cannot update your app
