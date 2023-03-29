# Basic Python image
FROM python:3.8

# Set working directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

COPY . .

# Set environment variables
# ENV DJANGO_SETTINGS_MODULE=DemoApp.settings.production
ENV PYTHONPATH "${PYTHONPATH}:/var/www/html/project-Idanimo/Idanimo-Demo/DemoApp"

RUN echo $DJANGO_SETTINGS_MODULE

# Collect static files
# RUN python manage.py collectstatic --noinput

# Expose port 8000
EXPOSE 8000

# Start Django application 
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

