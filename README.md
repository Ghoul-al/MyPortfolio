# Portfolio Website - Deployment Guide

This Django portfolio website is ready for deployment to various platforms.

## Local Development Setup

1. Clone the repository
2. Create a virtual environment: `python -m venv .venv`
3. Activate it: `source .venv/bin/activate`
4. Install dependencies: `pip install -r requirements.txt`
5. Run migrations: `python manage.py migrate`
6. Collect static files: `python manage.py collectstatic`
7. Run server: `python manage.py runserver`

## Environment Variables

Copy `.env.example` to `.env` and fill in your values:

```bash
cp .env.example .env
```

Required variables:
- `SECRET_KEY`: Django secret key (generate a new one for production)
- `DEBUG`: Set to `False` for production
- `ALLOWED_HOSTS`: Comma-separated list of allowed hosts
- `EMAIL_*`: Email configuration for contact forms

## Deployment Options

### Render Deployment (Recommended)

Render provides a simple and reliable way to deploy your Django portfolio.

#### Quick Deploy with render-deploy.sh

Run the deployment helper script:

```bash
./render-deploy.sh
```

This will check your configuration and provide deployment instructions.

#### Option 1: Using render.yaml (Recommended)

1. **Connect Repository:**
   - Go to [Render Dashboard](https://dashboard.render.com)
   - Click "New" → "Blueprint"
   - Connect your GitHub repository

2. **Deploy:**
   - Render will automatically read `render.yaml`
   - It will create the web service and PostgreSQL database
   - Deployment will start automatically

3. **Environment Variables:**
   - Most are configured automatically via `render.yaml`
   - Add any additional variables in Render dashboard:
     - `EMAIL_BACKEND`
     - `EMAIL_HOST`
     - `EMAIL_PORT`
     - `EMAIL_USE_TLS`
     - `EMAIL_HOST_USER`
     - `EMAIL_HOST_PASSWORD`
     - `DEFAULT_FROM_EMAIL`

#### Option 2: Manual Setup

1. **Create Web Service:**
   - Go to Render Dashboard
   - Click "New" → "Web Service"
   - Connect your repository

2. **Configure Service:**
   - **Runtime:** Python 3
   - **Build Command:** `pip install -r requirements.txt && python manage.py collectstatic --noinput`
   - **Start Command:** `gunicorn portfoliowebsite.wsgi:application --bind 0.0.0.0:$PORT`

3. **Create Database:**
   - Click "New" → "PostgreSQL"
   - Note the connection string

4. **Environment Variables:**
   ```
   DJANGO_SETTINGS_MODULE=portfoliowebsite.settings
   SECRET_KEY=your-secret-key-here
   DEBUG=False
   DATABASE_URL=your-render-postgres-url
   ALLOWED_HOSTS=your-app-name.onrender.com
   ```

5. **Deploy:**
   - Click "Create Web Service"
   - Render will build and deploy automatically

### Heroku Deployment

1. Create a Heroku app
2. Set environment variables in Heroku dashboard
3. Push to Heroku: `git push heroku main`
4. Run migrations: `heroku run python manage.py migrate`
5. Collect static files: `heroku run python manage.py collectstatic`

### DigitalOcean App Platform

1. Connect your repository
2. Set environment variables
3. Configure the app with Python runtime
4. Deploy

### AWS/GCP/Azure

1. Set up a server/instance
2. Configure Nginx/Gunicorn
3. Set environment variables
4. Run migrations and collect static files

## Production Checklist

- [ ] DEBUG = False
- [ ] SECRET_KEY set to a secure value
- [ ] ALLOWED_HOSTS configured
- [ ] Database configured (if not using SQLite)
- [ ] Email backend configured
- [ ] Static files collected
- [ ] HTTPS enabled
- [ ] Regular backups (if using database)

## Security Notes

- Never commit `.env` file to version control
- Use strong SECRET_KEY
- Keep dependencies updated
- Monitor for security updates