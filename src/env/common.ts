import {type Did} from '@atproto/api'

import packageJson from '#/../package.json'

/**
 * The semver version of the app, as defined in `package.json.`
 *
 * N.B. The fallback is needed for Render.com deployments
 */
export const RELEASE_VERSION: string =
  process.env.EXPO_PUBLIC_RELEASE_VERSION || packageJson.version

/**
 * The env the app is running in e.g. development, testflight, production, e2e
 */
export const ENV: string = process.env.EXPO_PUBLIC_ENV

/**
 * Indicates whether the app is running in TestFlight
 */
export const IS_TESTFLIGHT = ENV === 'testflight'

/**
 * Indicates whether the app is __DEV__
 */
export const IS_DEV = __DEV__

/**
 * Indicates whether the app is __DEV__ or TestFlight
 */
export const IS_INTERNAL = IS_DEV || IS_TESTFLIGHT

/**
 * The commit hash that the current bundle was made from. The user can
 * see the commit hash in the app's settings along with the other version info.
 * Useful for debugging/reporting.
 */
export const BUNDLE_IDENTIFIER: string =
  process.env.EXPO_PUBLIC_BUNDLE_IDENTIFIER || 'dev'

/**
 * This will always be in the format of YYMMDDHH, so that it always increases
 * for each build. This should only be used for StatSig reporting and shouldn't
 * be used to identify a specific bundle.
 */
export const BUNDLE_DATE: number =
  process.env.EXPO_PUBLIC_BUNDLE_DATE === undefined
    ? 0
    : Number(process.env.EXPO_PUBLIC_BUNDLE_DATE)

/**
 * The log level for the app.
 */
export const LOG_LEVEL = (process.env.EXPO_PUBLIC_LOG_LEVEL || 'info') as
  | 'debug'
  | 'info'
  | 'warn'
  | 'error'

/**
 * Enable debug logs for specific logger instances
 */
export const LOG_DEBUG: string = process.env.EXPO_PUBLIC_LOG_DEBUG || ''

/**
 * The DID of the Bluesky appview to proxy to
 */
export const BLUESKY_PROXY_DID: Did =
  process.env.EXPO_PUBLIC_BLUESKY_PROXY_DID || 'did:web:api.bsky.app'

/**
 * The DID of the chat service to proxy to
 */
export const CHAT_PROXY_DID: Did =
  process.env.EXPO_PUBLIC_CHAT_PROXY_DID || 'did:web:api.bsky.chat'

/**
 * Sentry DSN for telemetry
 */
export const SENTRY_DSN: string | undefined = process.env.EXPO_PUBLIC_SENTRY_DSN

/**
 * Bitdrift API key. If undefined, Bitdrift should be disabled.
 */
export const BITDRIFT_API_KEY: string | undefined =
  process.env.EXPO_PUBLIC_BITDRIFT_API_KEY

/**
 * GCP project ID which is required for native device attestation. On web, this
 * should be unset and evaluate to 0.
 */
export const GCP_PROJECT_ID: number =
  process.env.EXPO_PUBLIC_GCP_PROJECT_ID === undefined
    ? 0
    : Number(process.env.EXPO_PUBLIC_GCP_PROJECT_ID)

/**
 * URL for the bapp-config web worker _development_ environment. Can be a
 * locally running server, see `env.example` for more.
 */
export const BAPP_CONFIG_DEV_URL = process.env.BAPP_CONFIG_DEV_URL

/**
 * Dev environment passthrough value for bapp-config web worker. Allows local
 * dev access to the web worker running in `development` mode.
 */
export const BAPP_CONFIG_DEV_BYPASS_SECRET: string =
  process.env.BAPP_CONFIG_DEV_BYPASS_SECRET

export const ENV_APP_NAME: string = process.env.ENV_APP_NAME
export const ENV_APP_ACCOUNT_DID: string = process.env.ENV_APP_ACCOUNT_DID

export const ENV_BSKY_DOWNLOAD_URL: string = process.env.ENV_BSKY_DOWNLOAD_URL
export const ENV_BSKY_SERVICE: string = process.env.ENV_BSKY_SERVICE
export const ENV_BSKY_SERVICE_DID: string = process.env.ENV_BSKY_SERVICE_DID
export const ENV_EMBED_SERVICE: string = process.env.ENV_EMBED_SERVICE
export const ENV_HELP_DESK_URL: string = process.env.ENV_HELP_DESK_URL
export const ENV_PUBLIC_BSKY_SERVICE: string =
  process.env.ENV_PUBLIC_BSKY_SERVICE
export const ENV_STAGING_SERVICE: string = process.env.ENV_STAGING_SERVICE

export const ENV_TERM: string = process.env.ENV_TERM
export const ENV_PRIVACY_POLICY: string = process.env.ENV_PRIVACY_POLICY
export const ENV_COPY_RIGHT: string = process.env.ENV_COPY_RIGHT
export const ENV_GUIDE_LINES: string = process.env.ENV_GUIDE_LINES
export const ENV_BLOG: string = process.env.ENV_BLOG

//default https://bsky.app/
export const ENV_APP_URL: string = process.env.ENV_APP_URL

//trusted host ex: bsky.app,bsky.social,blueskyweb.xyz,blueskyweb.zendesk.com
export const ENV_TRUSTED_HOSTS: string = process.env.ENV_TRUSTED_HOSTS
export const ENV_HELP_URL: string = process.env.ENV_HELP_URL
export const ENV_LEARN_MORE_URL: string = process.env.ENV_LEARN_MORE_URL
