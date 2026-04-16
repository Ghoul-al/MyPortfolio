#!/bin/bash

# Render Deployment Helper Script
# This script helps prepare your Django project for Render deployment

echo "🎨 Render Deployment Helper"
echo "=========================="

# Check if render.yaml exists
if [ ! -f render.yaml ]; then
    echo "❌ render.yaml not found!"
    echo "Please make sure render.yaml is in the project root."
    exit 1
fi

echo "✅ Found render.yaml configuration"

# Check requirements.txt
if [ ! -f requirements.txt ]; then
    echo "❌ requirements.txt not found!"
    exit 1
fi

echo "✅ Found requirements.txt"

# Check Procfile
if [ ! -f Procfile ]; then
    echo "❌ Procfile not found!"
    exit 1
fi

echo "✅ Found Procfile"

# Check runtime.txt
if [ ! -f runtime.txt ]; then
    echo "❌ runtime.txt not found!"
    exit 1
fi

echo "✅ Found runtime.txt"

echo ""
echo "📋 Pre-deployment Checklist:"
echo "==========================="
echo "□ Push your code to GitHub"
echo "□ Go to https://dashboard.render.com"
echo "□ Click 'New' → 'Blueprint'"
echo "□ Connect your GitHub repository"
echo "□ Render will automatically detect render.yaml"
echo "□ Review the service configuration"
echo "□ Add email environment variables (optional):"
echo "  - EMAIL_BACKEND"
echo "  - EMAIL_HOST"
echo "  - EMAIL_PORT"
echo "  - EMAIL_USE_TLS"
echo "  - EMAIL_HOST_USER"
echo "  - EMAIL_HOST_PASSWORD"
echo "  - DEFAULT_FROM_EMAIL"
echo "□ Click 'Deploy'"
echo ""
echo "🎉 Your portfolio will be live at: https://your-app-name.onrender.com"
echo ""
echo "Need help? Check the README.md for detailed Render deployment instructions."