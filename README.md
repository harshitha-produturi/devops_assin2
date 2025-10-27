# Ticket App
Minimal ticket-booking app for CI/CD + Kubernetes demo.
## Development

Docker & Kubernetes
-------------------

We provide a Dockerfile and Kubernetes manifests to help containerize and deploy the app.

Build image locally:

```bash
cd /Users/harshitha/ticket-app
docker build -t ticket-app:local .
```

Run locally:

```bash
docker run -p 3000:3000 ticket-app:local
# then open http://localhost:3000
```

Kubernetes (example):

```bash
# replace image in k8s/deployment.yaml with your DockerHub repo: yourname/ticket-app:latest
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl get svc ticket-app-service
```

Jenkins & CI/CD notes
 - Use the included `Jenkinsfile` as a starting pipeline. Configure Jenkins credentials:
	 - `dockerhub-credentials-id` (username/password) — used in the pipeline for docker push
	 - `dockerhub-repo` — the Docker Hub repository (e.g. `yourname` or `yourname/repo`)

Set up a webhook in your Git host to trigger Jenkins on push.
