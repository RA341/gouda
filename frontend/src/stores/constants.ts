export const isDev = import.meta.env !== undefined
export const BASE_URL = `${isDev ? 'http://localhost:8962' : window.location.origin}/api`
