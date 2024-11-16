# Stage 1: Build stage
FROM python:3.11-slim as builder
 
# Set working directory
WORKDIR /app
 
# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
 
# Copy application files
COPY app/ ./app
 
# Stage 2: Runtime stage
FROM python:3.11-slim
 
# Set working directory
WORKDIR /app
 
# Copy dependencies and app from the builder stage
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /app /app
 
# Expose the port and define entrypoint
EXPOSE 5000
CMD ["python", "app/main.py"]
