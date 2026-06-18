import axios from 'axios'
import { env } from '../config/env'

// Create axios instance with default config
export const apiClient = axios.create({
  baseURL: env.api.baseUrl,
  timeout: env.api.timeout,
  headers: {
    'Content-Type': 'application/json',
  },
})

// Request interceptor
apiClient.interceptors.request.use(
  (config) => {
    // Add auth token if available
    const token = localStorage.getItem('auth_token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

// Response interceptor
apiClient.interceptors.response.use(
  (response) => response,
  (error) => {
    // Handle common errors
    if (error.response?.status === 401) {
      // Unauthorized - clear token and redirect to login
      localStorage.removeItem('auth_token')
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

// VA API client (separate instance)
export const vaApiClient = axios.create({
  baseURL: env.va.baseUrl,
  timeout: env.api.timeout,
  headers: {
    'Content-Type': 'application/json',
    ...(env.va.apiKey && { 'apikey': env.va.apiKey }),
  },
})

export default apiClient
