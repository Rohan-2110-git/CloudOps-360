18. Implemented frontend → backend API routing:
    - Added `/status` API endpoint in Flask backend.
    - Implemented Nginx reverse proxy for `/api/` requests to backend.
    - Updated docker-compose to mount custom Nginx config.
    - Verified successful API response via:
      ```bash
      curl http://localhost:8080/api/status
      ```
      Output:
      ```json
      {"api": "status", "service": "cloudops-360-backend", "status": "ok"}
      ```
    ✅ Frontend now dynamically displays API response successfully.
