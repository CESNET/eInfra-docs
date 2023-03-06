# Multi-Factor Authentication (MFA)

You can **enhance security of your e-INFRA CZ Account by enabling MFA** 
(Multi-Factor Authentication). In this case, an additional authentication 
method is required when you log in. **Some e-INFRA CZ services may require 
you to enable MFA in order to use them**.

e-INFRA CZ AAI (Authentication and Authorization Infrastructure) offers two 
ways to verify the second factor during the login process:

- **TOTP** (Time-based One-Time Passwords)
- **WebAuthn** (Web Authentication)

!!! note "Recovery codes"
    You are encouraged to also **generate one-time recovery codes** for 
    regaining access in case you lose your primary tokens. Detailed 
    instructions can be found [here](./setup.md#recovery-codes).

## Available Methods of MFA Verification

### TOTP

TOTP (Time-based One-Time Password) is a standard method for one-time code 
generation used by many commercial services. TOTP app has a shared secret with 
the server and generates time-constrained numerical codes based on that 
secret. The most common setting is 6 digits with validity of 30 seconds.

???+ note "More about TOTP"

    You may know this method by many alternative names, including:

    -  code from verification app,
    -  verification code, 
    -  authentication code,
    -  code from authentication app,
    -  6-digit code from code generator,
    -  code from Google Authenticator or
    -  verification code from the Google Authenticator app.

    The advantage of this method is its versatility -
    you can copy the one-time code from the app in your smartphone to another
    app, type it on your PC or even a smart TV. The only requirement that 
    the device you want to authenticate on needs to fulfill is the 
    capability to enter digits.

    You can use any TOTP app, for example:

    - [andOTP](https://play.google.com/store/apps/details?id=org.shadowice.flocke.andotp)
    - [Aegis Authenticator](https://play.google.com/store/apps/details?id=com.beemdevelopment.aegis)
    - [Google Authenticator](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2)
    - [FreeOTP+](https://play.google.com/store/apps/details?id=org.liberty.android.freeotpplus)

    Alternatively you can use the TOTP capability of your password manager 
    e.g.:

    - [BitWarden](https://bitwarden.com/help/authenticator-keys/) 
    - [LastPass Authenticator](https://lastpass.com/auth/).

    If you already have a TOTP app installed, you don't have to install 
    another one, you can just add e-INFRA CZ Account.

    TOTP is defined [RFC 6238](https://datatracker.ietf.org/doc/html/rfc6238).

### WebAuthn

WebAuthn, short for Web Authentication API, is a modern [standard](https://w3c.github.io/webauthn/)
created by W3C and FIDO. This method offers a high level of security while 
protecting your privacy, it is also easy to use. WebAuthn is often a part of 
the operating system, so you do not need to install anything on most devices.

???+ note "More about WebAuthn"

    You may know this method by different names, including:

    - FIDO2,
    - U2F,
    - Security key verification,
    - Universal second factor, or simply
    - Security key

    The advantage of this method is its simplicity - you do not need to grab 
    your smartphone, open an app and type in a code, you just confirm the 
    authentication e.g. by pressing a button or using your thumb for 
    fingerprint. You may register various devices and use a different method 
    of authentication in each one depending on the device’s capabilities.

    In order to use WebAuthn, you need to use one of the supported web browsers 
    together with the operating system capability, an app or a physical 
    authenticator (e.g. a YubiKey).

    If you want to learn more, check out [webauthn.io](https://webauthn.io) and 
    [webauthn.me](https://webauthn.me). Operating systems with WebAuthn 
    built in:

    - Windows 10+ (Windows Hello)
    - macOS 10.15+ (only some browsers depending on version)
    - Android 7+ (a screen lock has to be set (fingerprint or face recognition)
    - iOS 14.5+ (Touch ID, Face ID)
    - For Linux, you can try Rust U2F or tpm-fido.

#### WebAuthn on MS Windows

Use [Windows Hello](https://support.microsoft.com/en-us/windows/learn-about-windows-hello-and-set-it-up-dae28983-8242-bb2a-d3d1-87c9d265a5f0)
using a PIN, facial recognition, or fingerprint. Windows 10 build 1903 or 
later is required.

#### WebAuthn on Android

The [screen lock](https://support.google.com/android/answer/9079129?hl=en) 
functionality that uses a PIN, pattern, password, fingerprint or facial 
recognition can be used for MFA.

Alternatively a NFC or USB connected hardware token like [Yubikey](https://www.yubico.com/authentication-standards/fido2/) 
can be used.

#### WebAuth on MacOS

The [Touch ID](https://support.apple.com/en-in/guide/mac-help/mchl16fbf90a/mac) 
feature can be used.

#### WebAuthN on Linux PC With FIDO2-compatible Hardware Token

USB hardware tokens that support [FIDO2](https://en.wikipedia.org/wiki/FIDO2_Project)
, like [Yubikey](https://www.yubico.com/authentication-standards/fido2/), 
can be used.

#### WebAuthN on Linux PC With Android Phone Used for Second Factor

This use case requires a rather specific setup. The Linux PC must have 
Bluetooth enabled, Google Chrome browser must be used on the PC, and an 
Android phone with enabled Bluetooth and installed Chrome browser must be 
physically near the PC (so near that the PC and the phone can communicate 
over Bluetooth).

If the Chrome browser on the Android phone contains authenticated Google 
Account, the ways for unlocking screen lock will be used for second factor.

If the Chrome browser on the Android phone does not contain authenticated 
Google Account, scanning of a one-time QR code by the phone from the screen 
of the PC can be used.
