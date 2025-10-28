FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
HEALTHCHECK --interval=15s --timeout=3s --start-period=5s CMD curl -f http://localhost:5000/health || exit 1
ENV PORT=5000
CMD ["python", "app.py"]
