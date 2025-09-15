import {ENV_APP_NAME} from '#/env'

export function bskyTitle(page: string, unreadCountLabel?: string) {
  const unreadPrefix = unreadCountLabel ? `(${unreadCountLabel}) ` : ''
  return `${unreadPrefix}${page} — ${ENV_APP_NAME ?? 'Bluesky'}`
}
