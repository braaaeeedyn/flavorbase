# Flavorbase 🍳

> A personal + community recipe app with save, filter, sort, and social signals (likes, ratings).

[![CI/CD Pipeline](https://github.com/yourusername/flavorbase/actions/workflows/ci.yml/badge.svg)](https://github.com/yourusername/flavorbase/actions/workflows/ci.yml)

## 🚀 Quick Start

Get Flavorbase running locally in under 15 minutes:

### Prerequisites

- **Java 21** (Oracle JDK or OpenJDK)
- **Node.js 18+** and npm
- **Docker & Docker Compose** (optional, for containerized setup)
- **Git**

### Option 1: Local Development (Recommended for Development)

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/flavorbase.git
   cd flavorbase
   ```

2. **Start the database** (using Docker)
   ```bash
   docker-compose -f docker-compose.dev.yml up -d
   ```

3. **Start the backend** (in a new terminal)
   ```bash
   cd server
   cp .env.example .env  # Configure as needed
   ./mvnw spring-boot:run
   ```

4. **Start the frontend** (in another terminal)
   ```bash
   cd web
   cp .env.example .env  # Configure as needed
   npm install
   npm run dev
   ```

5. **Access the application**
   - Frontend: [http://localhost:5173](http://localhost:5173)
   - Backend API: [http://localhost:8080](http://localhost:8080)
   - H2 Console: [http://localhost:8080/h2-console](http://localhost:8080/h2-console) (dev profile)

### Option 2: Full Docker Setup

```bash
git clone https://github.com/yourusername/flavorbase.git
cd flavorbase
docker-compose up --build
```

Access at [http://localhost:3000](http://localhost:3000)

## 🏗️ Project Structure

```
flavorbase/
├── server/                 # Spring Boot backend
│   ├── src/main/java/     # Java source code
│   ├── src/main/resources/ # Configuration files
│   ├── src/test/          # Test files
│   ├── pom.xml           # Maven dependencies
│   └── Dockerfile        # Backend container config
├── web/                   # React frontend
│   ├── src/              # TypeScript/React source
│   ├── public/           # Static assets
│   ├── package.json      # NPM dependencies
│   └── Dockerfile        # Frontend container config
├── .github/workflows/     # CI/CD pipelines
├── docker-compose.yml     # Production containers
├── docker-compose.dev.yml # Development database
└── README.md             # This file
```

## 🛠️ Tech Stack

### Backend
- **Java 21** + **Spring Boot 3.3**
- **Spring Security** + JWT authentication
- **Spring Data JPA** with Hibernate
- **H2** (dev) / **PostgreSQL** (prod)
- **Maven** build system

### Frontend
- **React 18** + **TypeScript**
- **Vite** build tool
- **React Router** navigation
- **TanStack Query** API state management
- **TailwindCSS** styling
- **Context API** for global state

### Infrastructure
- **Docker** containerization
- **Nginx** reverse proxy (production)
- **GitHub Actions** CI/CD
- **PostgreSQL** database
- **Redis** (planned for caching)

## 🎨 Design System

Flavorbase includes 12 beautiful theme options:

- **Deep Cream**: #02343F, #F0EDCC (default)
- **Royal Coral**: #00539C, #EEA47F
- **Soft Olive**: #ABC8A2, #1A2417
- **Peach Crush**: #E84F5E, #FCDFC5
- ...and 8 more themes

## 📚 API Documentation

The API follows RESTful principles with JWT authentication:

- **Base URL**: `/api`
- **Authentication**: `Authorization: Bearer <token>`
- **Format**: JSON
- **Error Format**: `{"error": "BadRequest", "message": "...", "traceId": "..."}`

### Key Endpoints

```bash
# Authentication
POST /api/auth/register    # User registration
POST /api/auth/login       # User login
POST /api/auth/logout      # User logout

# Recipes
GET  /api/recipes          # List recipes (with filters)
POST /api/recipes          # Create recipe
GET  /api/recipes/{id}     # Get recipe details
PUT  /api/recipes/{id}     # Update recipe

# Social Features
POST /api/recipes/{id}/like     # Toggle like
POST /api/recipes/{id}/rate     # Rate recipe
POST /api/saved-recipes/{id}    # Save recipe
```

For complete API documentation, see [API_REFERENCE.md](docs/API_REFERENCE.md) (coming soon).

## 🧪 Development Commands

### Backend (Spring Boot)
```bash
cd server

# Run application
./mvnw spring-boot:run

# Run tests
./mvnw test

# Code formatting (Spotless)
./mvnw spotless:apply

# Package for production
./mvnw clean package
```

### Frontend (React)
```bash
cd web

# Development server
npm run dev

# Build for production
npm run build

# Run linting
npm run lint
npm run lint:fix

# Format code
npm run format
npm run format:check

# Type checking
npm run type-check
```

## 🚢 Deployment

### Production Environment Variables

**Backend (.env)**:
```env
DATABASE_URL=jdbc:postgresql://localhost:5432/flavorbase
DATABASE_USERNAME=flavorbase
DATABASE_PASSWORD=your_secure_password
JWT_SECRET=your-256-bit-secret-key
SPRING_PROFILES_ACTIVE=prod
```

**Frontend (.env)**:
```env
VITE_API_BASE_URL=https://your-api-domain.com/api
VITE_APP_NAME=Flavorbase
```

### Docker Deployment

1. **Build and deploy**:
   ```bash
   docker-compose up -d --build
   ```

2. **Update database schema**:
   ```bash
   docker-compose exec backend java -jar app.jar --spring.jpa.hibernate.ddl-auto=update
   ```

## 🧭 Development Roadmap

- [x] **Foundation & Repo Setup** ✅
- [ ] **Core Models & Database Schema**
- [ ] **Authentication System**
- [ ] **Recipe CRUD Operations**
- [ ] **Search & Filtering**
- [ ] **Social Features (Likes, Ratings)**
- [ ] **User Profiles & Saved Recipes**
- [ ] **File Upload System**
- [ ] **Community Features**
- [ ] **Performance Optimization**

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

### Code Quality

- Follow the established code style (Spotless for Java, Prettier for TypeScript)
- Write tests for new features
- Ensure all CI checks pass
- Update documentation as needed

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Troubleshooting

### Common Issues

**Database connection issues:**
```bash
# Check if PostgreSQL is running
docker-compose -f docker-compose.dev.yml ps

# Reset database
docker-compose -f docker-compose.dev.yml down -v
docker-compose -f docker-compose.dev.yml up -d
```

**Frontend build issues:**
```bash
# Clear node_modules and reinstall
cd web
rm -rf node_modules package-lock.json
npm install
```

**Backend compilation issues:**
```bash
# Clean and rebuild
cd server
./mvnw clean compile
```

### Getting Help

- 📖 Check the [Wiki](https://github.com/yourusername/flavorbase/wiki)
- 🐛 Report bugs via [Issues](https://github.com/yourusername/flavorbase/issues)
- 💬 Join discussions in [Discussions](https://github.com/yourusername/flavorbase/discussions)

## 📊 Project Status

- **Current Version**: 0.0.1-SNAPSHOT
- **Status**: 🚧 In Development
- **MVP Target**: Q1 2024

---

**Built with ❤️ for food enthusiasts everywhere**
