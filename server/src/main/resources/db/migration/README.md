# Flavorbase Database Migrations

This directory contains Flyway database migration scripts for the Flavorbase application.

## Migration Rules & Guidelines

### 1. **Naming Convention**
- **Versioned Migrations**: `V{version}__{description}.sql`
  - Example: `V1__baseline.sql`, `V1_1__seed_data.sql`, `V2__add_user_preferences.sql`
- **Repeatable Migrations**: `R__{description}.sql` (for views, stored procedures)
  - Example: `R__update_recipe_stats_view.sql`

### 2. **Migration Versioning**
- **Major versions** (V1, V2, V3): Significant schema changes, new features
- **Minor versions** (V1_1, V1_2): Small additions, seed data, patches
- **Always increment**: Never modify existing migration files
- **Sequential order**: Migrations run in version order

### 3. **Writing Migrations**

#### ✅ **DO:**
- Make migrations **idempotent** when possible
- Use explicit column types and constraints
- Add proper indexes for performance
- Include rollback comments for manual procedures
- Test migrations on sample data
- Use descriptive names for constraints and indexes

#### ❌ **DON'T:**
- Modify existing migration files after deployment
- Use database-specific features without documenting alternatives
- Create migrations that can't be easily reversed
- Skip backup procedures for production deployments

### 4. **Current Schema Status**

#### **V1__baseline.sql** (Complete Core Schema)
**Tables Created:**
- `users` - User accounts and profiles
- `categories` - Recipe classification system  
- `ingredients` - Master ingredient list
- `recipes` - Core recipe data
- `recipe_steps` - Step-by-step instructions
- `recipe_ingredients` - Recipe-ingredient quantities
- `recipe_categories` - Many-to-many recipe categorization
- `saved_recipes` - User bookmarks
- `recipe_likes` - Social engagement
- `recipe_ratings` - 5-star rating system
- `images` - File upload tracking
- `refresh_tokens` - JWT token management

**Key Features:**
- Full referential integrity with foreign keys
- Performance indexes for common queries
- Check constraints for data validation
- Automatic timestamp triggers for audit trails

#### **V1_1__seed_categories_themes.sql** (Initial Data)
**Seed Data:**
- 20 recipe categories (Breakfast, Dinner, Vegetarian, etc.)
- 70+ common ingredients for autocomplete
- 12 design themes with color schemes
- Default admin user account
- Performance views for analytics

### 5. **Rollback Policy**

#### **Development Environment:**
- **Automatic rollback**: Use `flyway clean` + `flyway migrate` for clean slate
- **Manual rollback**: Drop affected tables/columns manually if needed
- **Data safety**: H2 in-memory database - data loss acceptable

#### **Production Environment:**
- **No automatic rollback**: All rollbacks must be manual and planned
- **Backup first**: Always backup database before major migrations  
- **Rollback scripts**: Document manual rollback steps for each migration
- **Staged deployment**: Test migrations on staging environment first

### 6. **Migration Testing**

#### **Before Deployment:**
```bash
# 1. Test on clean database
flyway clean
flyway migrate

# 2. Test with existing data  
flyway migrate  # Should handle existing schema gracefully

# 3. Verify data integrity
# Run application tests to ensure schema works with code
```

#### **Development Workflow:**
1. **Create migration file** with appropriate version number
2. **Test locally** with H2 database
3. **Test with PostgreSQL** if using database-specific features
4. **Run application tests** to verify compatibility
5. **Document any manual steps** required
6. **Commit migration** with descriptive commit message

### 7. **Production Deployment Checklist**

- [ ] **Backup database** before deployment
- [ ] **Test migration** on staging environment with production data copy
- [ ] **Verify rollback plan** and document manual steps if needed
- [ ] **Check migration performance** on large datasets
- [ ] **Coordinate deployment** with application code changes
- [ ] **Monitor application** after deployment for issues
- [ ] **Verify data integrity** post-migration

### 8. **Troubleshooting**

#### **Common Issues:**
- **Migration checksum mismatch**: File was modified after deployment
  - Solution: Use `flyway repair` or create new migration to fix
- **Schema validation failed**: Database state doesn't match migrations  
  - Solution: Check for manual schema changes, align database with migrations
- **Performance issues**: Large dataset migrations taking too long
  - Solution: Break into smaller batches, consider maintenance windows

#### **Emergency Procedures:**
- **Critical bug in migration**: Stop deployment, assess rollback options
- **Data corruption**: Restore from backup, investigate migration script
- **Performance degradation**: Check if new indexes are being built, monitor query performance

### 9. **Environment Configuration**

#### **Development (H2):**
```yaml
flyway:
  enabled: true
  baseline-on-migrate: true    # Allow baseline on existing DB
  validate-on-migrate: true    # Validate before running
  locations: classpath:db/migration
```

#### **Production (PostgreSQL):**
```yaml  
flyway:
  enabled: true
  baseline-on-migrate: false   # Strict validation
  validate-on-migrate: true    # Always validate
  locations: classpath:db/migration
```

## Quick Reference

| Command | Purpose |
|---------|---------|
| `flyway info` | Show migration status |
| `flyway migrate` | Run pending migrations |
| `flyway validate` | Validate migration checksums |
| `flyway repair` | Fix checksum mismatches |
| `flyway clean` | Drop all objects (dev only) |

---

**For questions or issues with migrations, refer to the Flyway documentation: https://flywaydb.org/documentation/**
