import { Routes, Route } from 'react-router-dom'
import Layout from '../components/Layout'
import HomePage from '../pages/HomePage'
import LoginPage from '../pages/LoginPage'
import RegisterPage from '../pages/RegisterPage'
import RecipesPage from '../pages/RecipesPage'
import RecipeDetailPage from '../pages/RecipeDetailPage'
import ProfilePage from '../pages/ProfilePage'
import CreateRecipePage from '../pages/CreateRecipePage'
import ProtectedRoute from '../components/ProtectedRoute'

function AppRoutes() {
  return (
    <Routes>
      <Route path="/" element={<Layout />}>
        <Route index element={<HomePage />} />
        <Route path="login" element={<LoginPage />} />
        <Route path="register" element={<RegisterPage />} />
        <Route path="recipes" element={<RecipesPage />} />
        <Route path="recipes/:id" element={<RecipeDetailPage />} />
        <Route
          path="create-recipe"
          element={
            <ProtectedRoute>
              <CreateRecipePage />
            </ProtectedRoute>
          }
        />
        <Route
          path="profile"
          element={
            <ProtectedRoute>
              <ProfilePage />
            </ProtectedRoute>
          }
        />
        {/* Catch all route */}
        <Route path="*" element={<div className="p-8 text-center">Page not found</div>} />
      </Route>
    </Routes>
  )
}

export default AppRoutes
