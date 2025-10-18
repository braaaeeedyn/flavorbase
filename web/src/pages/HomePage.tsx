import { Link } from 'react-router-dom'
import { ChefHat, Users, Heart, Star } from 'lucide-react'

function HomePage() {
  return (
    <div className="bg-gradient-to-br from-deep-cream-light to-white">
      {/* Hero Section */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div className="text-center">
          <h1 className="text-4xl md:text-6xl font-bold text-deep-cream-dark mb-6">
            Welcome to <span className="text-peach-crush-dark">Flavorbase</span>
          </h1>
          <p className="text-xl text-gray-600 mb-8 max-w-3xl mx-auto">
            Discover, create, and share amazing recipes with our vibrant community of food enthusiasts.
            From quick weeknight dinners to elaborate weekend feasts, find your next culinary adventure.
          </p>
          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <Link to="/recipes" className="btn-primary text-lg px-8 py-3">
              Explore Recipes
            </Link>
            <Link to="/register" className="btn-secondary text-lg px-8 py-3">
              Join Community
            </Link>
          </div>
        </div>
      </section>

      {/* Features Section */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <h2 className="text-3xl font-bold text-center text-deep-cream-dark mb-12">
          Why Choose Flavorbase?
        </h2>
        <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
          <div className="text-center">
            <div className="bg-deep-cream-dark rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
              <ChefHat className="h-8 w-8 text-deep-cream-light" />
            </div>
            <h3 className="text-xl font-semibold mb-2">Easy to Create</h3>
            <p className="text-gray-600">
              Share your recipes with our intuitive recipe builder and step-by-step instructions.
            </p>
          </div>
          <div className="text-center">
            <div className="bg-royal-coral-dark rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
              <Users className="h-8 w-8 text-white" />
            </div>
            <h3 className="text-xl font-semibold mb-2">Community Driven</h3>
            <p className="text-gray-600">
              Connect with fellow food lovers, get inspired, and share your culinary creations.
            </p>
          </div>
          <div className="text-center">
            <div className="bg-peach-crush-dark rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
              <Heart className="h-8 w-8 text-white" />
            </div>
            <h3 className="text-xl font-semibold mb-2">Save Favorites</h3>
            <p className="text-gray-600">
              Keep track of recipes you love and organize them for easy access anytime.
            </p>
          </div>
          <div className="text-center">
            <div className="bg-soft-olive-dark rounded-full w-16 h-16 flex items-center justify-center mx-auto mb-4">
              <Star className="h-8 w-8 text-soft-olive-light" />
            </div>
            <h3 className="text-xl font-semibold mb-2">Rate & Review</h3>
            <p className="text-gray-600">
              Discover the best recipes through community ratings and honest reviews.
            </p>
          </div>
        </div>
      </section>

      {/* CTA Section */}
      <section className="bg-deep-cream-dark">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 text-center">
          <h2 className="text-3xl font-bold text-deep-cream-light mb-4">
            Ready to Start Cooking?
          </h2>
          <p className="text-xl text-deep-cream-light mb-8 max-w-2xl mx-auto">
            Join thousands of home cooks sharing their favorite recipes and discovering new flavors.
          </p>
          <Link to="/register" className="bg-peach-crush-dark text-white px-8 py-3 rounded-md font-medium hover:bg-opacity-90 transition-colors">
            Get Started Today
          </Link>
        </div>
      </section>
    </div>
  )
}

export default HomePage
