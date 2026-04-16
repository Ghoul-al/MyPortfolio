#!/bin/bash

# Portfolio Website Deployment Script
# This script helps deploy the Django portfolio to various platforms

echo "🚀 Portfolio Website Deployment Script"
echo "====================================="

# Check if .env exists
if [ ! -f .env ]; then
    echo "❌ .env file not found!"
    echo "Please copy .env.example to .env and configure your environment variables."
    exit 1
fi

# Function to deploy to Heroku
deploy_heroku() {
    echo "📦 Deploying to Heroku..."
    echo "Make sure you have:"
    echo "1. Heroku CLI installed"
    echo "2. Heroku app created"
    echo "3. Environment variables set in Heroku dashboard"
    echo ""
    echo "Run these commands:"
    echo "heroku create your-app-name"
    echo "heroku config:set SECRET_KEY='your-secret-key' DEBUG=False ALLOWED_HOSTS='yourdomain.com'"
    echo "git push heroku main"
    echo "heroku run python manage.py migrate"
    echo "heroku run python manage.py collectstatic --noinput"
}

# Function to deploy to Render
deploy_render() {
    echo "🎨 Deploying to Render..."
    echo "Render offers two deployment methods:"
    echo ""
    echo "Option 1 - Blueprint (Recommended):"
    echo "1. Go to https://dashboard.render.com"
    echo "2. Click 'New' → 'Blueprint'"
    echo "3. Connect your GitHub repository"
    echo "4. Render will automatically use render.yaml"
    echo "5. Add email environment variables if needed"
    echo ""
    echo "Option 2 - Manual Setup:"
    echo "1. Create Web Service and PostgreSQL database"
    echo "2. Set these environment variables:"
    echo "   - DJANGO_SETTINGS_MODULE=portfoliowebsite.settings"
    echo "   - SECRET_KEY (generate a secure one)"
    echo "   - DEBUG=False"
    echo "   - DATABASE_URL (from your Render PostgreSQL)"
    echo "   - ALLOWED_HOSTS (your Render app URL)"
    echo "3. Build Command: pip install -r requirements.txt && python manage.py collectstatic --noinput"
    echo "4. Start Command: gunicorn portfoliowebsite.wsgi:application --bind 0.0.0.0:\$PORT"
    echo ""
    echo "Your render.yaml file is already configured for automatic deployment!"
}

# Function to deploy to local server
deploy_local() {
    echo "🏠 Setting up for local production server..."
    source .venv/bin/activate
    pip install -r requirements.txt
    python manage.py collectstatic --noinput
    python manage.py migrate
    echo "Starting Gunicorn server..."
    gunicorn portfoliowebsite.wsgi --bind 0.0.0.0:8000
}

# Menu
echo "Choose deployment platform:"
echo "1) Render (Recommended)"
echo "2) Heroku"
echo "3) DigitalOcean App Platform"
echo "4) Local production server"
echo "5) Exit"
read -p "Enter choice (1-5): " choice

case $choice in
    1)
        deploy_render
        ;;
    2)
        deploy_heroku
        ;;
    3)
        deploy_digitalocean
        ;;
    4)
        deploy_local
        ;;
    5)
        echo "Goodbye!"
        exit 0
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "✅ Deployment preparation complete!"
echo "Don't forget to:"
echo "- Set up domain/DNS if needed"
echo "- Configure HTTPS"
echo "- Set up monitoring/backups"
echo "- Test all functionality"