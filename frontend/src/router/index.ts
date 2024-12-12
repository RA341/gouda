import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      redirect: '/categories',
    },
    {
      path: '/login',
      name: 'Login',
      component: () => import('../views/LoginView.vue'),
      meta: { requiresAuth: false },
    },
    {
      path: '/categories',
      name: 'Categories',
      component: () => import('../views/CategoriesView.vue'),
      meta: { requiresAuth: true },
    },
    {
      path: '/settings',
      name: 'Settings',
      component: () => import('../views/SettingsView.vue'),
      meta: { requiresAuth: true },
    },
    {
      path: '/about',
      name: 'About',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue'),
    },
  ],
})

// Authentication guard
router.beforeEach(async (to, from, next) => {
  const requiresAuth = to.matched.some((record) => record.meta.requiresAuth)
  const token = localStorage.getItem('token')

  // If route doesn't require auth, proceed
  if (!requiresAuth) {
    return next()
  }

  // No token found, redirect to login
  if (!token) {
    return next({ name: 'Login' })
  }

  try {
    // Validate token with your API
    const response = await axios.get('http://localhost:9862/auth/test', {
      headers: { Authorization: token },
    })

    // Token is valid, proceed
    if (response.data.isValid) {
      return next()
    } else {
      // Token is invalid, clear it and redirect to login
      localStorage.removeItem('token')
      return next({ name: 'Login' })
    }
  } catch (error) {
    console.error('Token validation error:', error)
    localStorage.removeItem('token')
    return next({ name: 'Login' })
  }
})

export default router
