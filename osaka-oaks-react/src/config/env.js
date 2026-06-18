/**
 * Environment Configuration
 * Centralized access to environment variables
 * All variables must be prefixed with VITE_ to be exposed to client
 */

export const env = {
  // Application
  app: {
    name: import.meta.env.VITE_APP_NAME || 'Osaka Oaks LLC',
    version: import.meta.env.VITE_APP_VERSION || '1.0.0',
    environment: import.meta.env.MODE || 'production',
    isDevelopment: import.meta.env.DEV,
    isProduction: import.meta.env.PROD,
  },

  // API Configuration
  api: {
    baseUrl: import.meta.env.VITE_API_BASE_URL || 'https://api.osakaoaks.org',
    timeout: Number(import.meta.env.VITE_API_TIMEOUT) || 30000,
  },

  // Firebase (if using)
  firebase: {
    apiKey: import.meta.env.VITE_FIREBASE_API_KEY || '',
    authDomain: import.meta.env.VITE_FIREBASE_AUTH_DOMAIN || '',
    projectId: import.meta.env.VITE_FIREBASE_PROJECT_ID || '',
    storageBucket: import.meta.env.VITE_FIREBASE_STORAGE_BUCKET || '',
    messagingSenderId: import.meta.env.VITE_FIREBASE_MESSAGING_SENDER_ID || '',
    appId: import.meta.env.VITE_FIREBASE_APP_ID || '',
    measurementId: import.meta.env.VITE_FIREBASE_MEASUREMENT_ID || '',
  },

  // VA API
  va: {
    apiKey: import.meta.env.VITE_VA_API_KEY || '',
    baseUrl: import.meta.env.VITE_VA_API_BASE_URL || 'https://api.va.gov',
    clientId: import.meta.env.VITE_VA_CLIENT_ID || '',
    // NOTE: Client secret should NEVER be in frontend!
  },

  // OAuth
  oauth: {
    redirectUri: import.meta.env.VITE_OAUTH_REDIRECT_URI || 'https://osakaoaks.org/auth/callback',
    clientId: import.meta.env.VITE_OAUTH_CLIENT_ID || '',
  },

  // Company Information
  company: {
    name: import.meta.env.VITE_COMPANY_NAME || 'Osaka Oaks LLC',
    uei: import.meta.env.VITE_COMPANY_UEI || 'MUGPMK51DFB4',
    cage: import.meta.env.VITE_COMPANY_CAGE || '11WZ2',
    phone: import.meta.env.VITE_COMPANY_PHONE || '(832) 847-5186',
    email: import.meta.env.VITE_COMPANY_EMAIL || 'jarrel.spiller@osakaoaks.org',
    address: import.meta.env.VITE_COMPANY_ADDRESS || '6212 Belgrave Dr, Austin, Texas 78747',
  },

  // Feature Flags
  features: {
    charts: import.meta.env.VITE_FEATURE_CHARTS_ENABLED === 'true',
    pwa: import.meta.env.VITE_FEATURE_PWA_ENABLED === 'true',
    analytics: import.meta.env.VITE_FEATURE_ANALYTICS_ENABLED === 'true',
    veteranPortal: import.meta.env.VITE_FEATURE_VETERAN_PORTAL === 'true',
  },

  // Analytics
  analytics: {
    googleAnalyticsId: import.meta.env.VITE_GOOGLE_ANALYTICS_ID || '',
    gtmId: import.meta.env.VITE_GTM_ID || '',
  },
}

// Validate required environment variables
export function validateEnv() {
  const required = [
    { key: 'VITE_APP_NAME', value: env.app.name },
    { key: 'VITE_COMPANY_EMAIL', value: env.company.email },
  ]

  const missing = required.filter((item) => !item.value)

  if (missing.length > 0 && env.app.isProduction) {
    console.warn(
      'Missing required environment variables:',
      missing.map((item) => item.key)
    )
  }

  return missing.length === 0
}

// Export individual namespaces for convenience
export const { app, api, firebase, va, oauth, company, features, analytics } = env

export default env
