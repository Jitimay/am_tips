# verify-token Edge Function

Verifies Firebase ID tokens server-side — replaces the insecure
x-firebase-uid header trust pattern.

## Deploy

```bash
supabase secrets set FIREBASE_PROJECT_ID=amtips-app
supabase secrets set FIREBASE_WEB_API_KEY=AIzaSyA5ISR9r0AfQ-RRE_trIS-isWgx9Dpga04
supabase functions deploy verify-token --no-verify-jwt
```

## Usage (Flutter side)

```dart
final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
final res = await Supabase.instance.client.functions.invoke(
  'verify-token',
  body: {'idToken': idToken},
);
final uid = res.data['uid'] as String;
// uid is now server-verified — safe to use
```

## How it works

1. Flutter sends Firebase ID token
2. Edge Function calls Firebase identitytoolkit API to verify it
3. Returns the verified UID + whether email is verified
4. Flutter stores the UID and uses it for the x-firebase-uid header
   knowing it was verified server-side
