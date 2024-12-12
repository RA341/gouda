<template>
  <div class="login-container">
    <div class="login-card">
      <h1 class="login-title">Welcome Back</h1>

      <form @submit.prevent="handleSubmit" class="login-form">
        <!-- Email field -->
        <div class="form-group">
          <label for="Username">Username</label>
          <input
            id="email"
            v-model="form.username"
            type="email"
            :class="{ error: errors.username }"
            @input="clearError('username')"
            required
          />
          <span v-if="errors.username" class="error-message">{{ errors.username }}</span>
        </div>

        <!-- Password field -->
        <div class="form-group">
          <label for="password">Password</label>
          <div class="password-input">
            <input
              id="password"
              v-model="form.password"
              :type="showPassword ? 'text' : 'password'"
              :class="{ error: errors.password }"
              @input="clearError('password')"
              required
            />
            <button type="button" class="toggle-password" @click="showPassword = !showPassword">
              {{ showPassword ? 'Hide' : 'Show' }}
            </button>
          </div>
          <span v-if="errors.password" class="error-message">{{ errors.password }}</span>
        </div>

        <!-- Submit button -->
        <button type="submit" class="login-button" :disabled="loading">
          {{ loading ? 'Logging in...' : 'Log In' }}
        </button>

        <!-- Error message -->
        <div v-if="generalError" class="general-error">
          {{ generalError }}
        </div>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'
import { BASE_URL } from '@/stores/constants.ts'

const router = useRouter()
const loading = ref(false)
const showPassword = ref(false)
const generalError = ref('')

const form = reactive({
  username: '',
  password: '',
  rememberMe: false,
})

const errors = reactive({
  username: '',
  password: '',
})

const validateForm = () => {
  let isValid = true

  if (!form.username) {
    errors.username = 'Email is required'
    isValid = false
  }

  if (!form.password) {
    errors.password = 'Password is required'
    isValid = false
  }

  return isValid
}

const clearError = (field) => {
  errors[field] = ''
  generalError.value = ''
}

const handleSubmit = async () => {
  if (!validateForm()) return

  loading.value = true
  generalError.value = ''

  try {
    const response = await axios.post(`${BASE_URL}/login`, {
      email: form.username,
      password: form.password,
      rememberMe: form.rememberMe,
    })

    const { token } = response.data
    localStorage.setItem('token', token)

    await router.replace('/')
  } catch (error) {
    generalError.value = error.response?.data?.message || 'Login failed. Please try again.'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.login-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #f5f5f5;
  padding: 20px;
}

.login-card {
  background: white;
  padding: 40px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  width: 100%;
  max-width: 400px;
}

.login-title {
  text-align: center;
  margin-bottom: 30px;
  color: #333;
  font-size: 24px;
}

.form-group {
  margin-bottom: 20px;
}

label {
  display: block;
  margin-bottom: 8px;
  color: #555;
  font-weight: 500;
}

input[type='email'],
input[type='password'],
input[type='text'] {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 4px;
  font-size: 16px;
}

input.error {
  border-color: #dc3545;
}

.error-message {
  color: #dc3545;
  font-size: 14px;
  margin-top: 5px;
  display: block;
}

.password-input {
  position: relative;
}

.toggle-password {
  position: absolute;
  right: 10px;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  color: #666;
  cursor: pointer;
}

.checkbox {
  display: flex;
  align-items: center;
  gap: 8px;
}

.checkbox input {
  width: auto;
}

.login-button {
  width: 100%;
  padding: 12px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  cursor: pointer;
  transition: background-color 0.2s;
}

.login-button:hover {
  background-color: #0056b3;
}

.login-button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.general-error {
  text-align: center;
  color: #dc3545;
  margin-top: 15px;
}

.forgot-password {
  text-align: center;
  margin-top: 20px;
}

.forgot-password a {
  color: #007bff;
  text-decoration: none;
}

.forgot-password a:hover {
  text-decoration: underline;
}
</style>
