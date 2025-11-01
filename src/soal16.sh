upstream Kesatria_Lorien {
    server 10.93.2.2:8004;  # Galadriel
    server 10.93.2.3:8005;  # Celeborn
    server 10.93.2.4:8006;  # Oropher
}

server {
    listen 80;
    server_name pharazon.k59.com;

    location / {
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        # forward basic auth header if present
        proxy_set_header Authorization $http_authorization;

        proxy_pass http://Kesatria_Lorien;
        proxy_redirect off;
    }
}
