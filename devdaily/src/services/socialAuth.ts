declare const google: any;
declare const FB: any;

class SocialAuthService {
  private googleInitialized = false;
  private facebookInitialized = false;

  private loadScript(id: string, src: string): Promise<void> {
    return new Promise((resolve, reject) => {
      if (document.getElementById(id)) {
        resolve();
        return;
      }
      const script = document.createElement('script');
      script.id = id;
      script.src = src;
      script.async = true;
      script.defer = true;
      script.onload = () => resolve();
      script.onerror = () => reject(new Error(`Failed to load script ${src}`));
      document.head.appendChild(script);
    });
  }

  async initGoogle(): Promise<void> {
    if (this.googleInitialized) return;
    await this.loadScript('google-gis-sdk', 'https://accounts.google.com/gsi/client');
    this.googleInitialized = true;
  }

  async initFacebook(): Promise<void> {
    if (this.facebookInitialized) return;
    await this.loadScript('facebook-jssdk', 'https://connect.facebook.net/es_LA/sdk.js');
    
    // Initialize Facebook SDK
    const appId = import.meta.env.VITE_FACEBOOK_APP_ID || '';
    if (appId && typeof FB !== 'undefined') {
      FB.init({
        appId: appId,
        cookie: true,
        xfbml: true,
        version: 'v18.0'
      });
      this.facebookInitialized = true;
    }
  }

  async signInWithGoogle(onSuccess: (data: any) => void, onError: (err: any) => void) {
    try {
      await this.initGoogle();
      const clientId = import.meta.env.VITE_GOOGLE_CLIENT_ID;

      if (!clientId) {
        onError(new Error('VITE_GOOGLE_CLIENT_ID no configurado en el archivo .env'));
        return;
      }

      if (typeof google === 'undefined') {
        onError(new Error('Google SDK no se cargó correctamente'));
        return;
      }

      const client = google.accounts.oauth2.initTokenClient({
        client_id: clientId,
        scope: 'email profile openid',
        callback: async (tokenResponse: any) => {
          if (tokenResponse.error) {
            onError(new Error(tokenResponse.error_description || tokenResponse.error));
            return;
          }
          if (tokenResponse.access_token) {
            try {
              const userInfo = await fetch(`https://www.googleapis.com/oauth2/v3/userinfo?access_token=${tokenResponse.access_token}`)
                .then(res => res.json());

              onSuccess({
                name: userInfo.name,
                email: userInfo.email,
                provider: 'google',
                providerId: userInfo.sub
              });
            } catch (e) {
              onError(new Error('No se pudo obtener la información de perfil de Google'));
            }
          }
        }
      });
      client.requestAccessToken();
    } catch (err) {
      onError(err);
    }
  }

  async signInWithFacebook(onSuccess: (data: any) => void, onError: (err: any) => void) {
    try {
      await this.initFacebook();
      const appId = import.meta.env.VITE_FACEBOOK_APP_ID;

      if (!appId) {
        onError(new Error('VITE_FACEBOOK_APP_ID no configurado en el archivo .env'));
        return;
      }

      if (typeof FB === 'undefined') {
        onError(new Error('Facebook SDK no se cargó correctamente'));
        return;
      }

      FB.login((response: any) => {
        if (response.authResponse) {
          FB.api('/me', { fields: 'name,email' }, (userInfo: any) => {
            if (userInfo && userInfo.email) {
              onSuccess({
                name: userInfo.name,
                email: userInfo.email,
                provider: 'facebook',
                providerId: userInfo.id
              });
            } else {
              onError(new Error('No se pudo obtener el email de la cuenta de Facebook'));
            }
          });
        } else {
          onError(new Error('El usuario canceló la autenticación con Facebook'));
        }
      }, { scope: 'email,public_profile' });
    } catch (err) {
      onError(err);
    }
  }
}

export const socialAuth = new SocialAuthService();
