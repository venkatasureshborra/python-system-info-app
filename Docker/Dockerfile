# Base image
FROM python:3.11-alpine

# Set working directory
WORKDIR /app

# Copy application files
COPY app/* .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

#set environment variables,  defautult port it can be overridden during container run
ENV APP_PORT=5000

# Expose the application port
EXPOSE ${APP_PORT}

# Command to run the application
CMD ["python", "app.py"]
