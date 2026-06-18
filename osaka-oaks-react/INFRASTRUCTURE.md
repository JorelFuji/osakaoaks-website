# Osaka Oaks - Infrastructure Documentation

## 🏗️ Architecture Overview

This document outlines the complete infrastructure setup for the Osaka Oaks website, including Docker, Kubernetes, and deployment strategies.

---

## 📦 Tech Stack Summary

### Frontend
- **React 18** - UI component framework
- **Vite** - Build tool + dev server
- **React Router v6** - Client-side routing
- **Tailwind CSS v4** - Utility-first styling
- **shadcn/ui** - Component library (Button, Card, Badge, Tabs, etc.)
- **Radix UI** - Headless accessible primitives (shadcn is built on this)
- **Framer Motion** - Animations and page transitions
- **Recharts** - Data visualization (charts for health/claims)
- **Lucide React** - Icon library
- **TanStack Query** - Server state, caching, background refetch
- **Sonner** - Toast notifications
- **clsx + tailwind-merge** - Dynamic className utilities
- **class-variance-authority** - Component variant system
- **vite-plugin-pwa** - PWA (installable on phone/desktop)

### Backend / Services
- **Firebase Hosting** - Static site hosting
- **Firebase Cloud Functions** - Secure OAuth token exchange
- **Express.js** - Standalone API server (for Docker/K8s)
- **Axios** - HTTP client for VA API calls

### Infrastructure
- **Docker** - Containerization (nginx + Node)
- **Kubernetes** - Orchestration with CPU/RAM limits
- **nginx** - Static file serving in containers

---

## 🐳 Docker Setup

### Building the Image

```bash
# Build the Docker image
docker build -t osaka-oaks-web:latest .

# Run locally
docker run -p 80:80 osaka-oaks-web:latest

# Using docker-compose
docker-compose up -d
```

### Multi-Stage Build
The Dockerfile uses a multi-stage build:
1. **Builder stage**: Node 20 Alpine, builds React app
2. **Production stage**: nginx Alpine, serves static files

### Features
- ✅ Small image size (~50MB compressed)
- ✅ Health checks included
- ✅ Gzip compression enabled
- ✅ Security headers configured
- ✅ Cache optimization

---

## ☸️ Kubernetes Deployment

### Prerequisites

```bash
# Create namespace
kubectl create namespace osaka-oaks-prod

# Create docker registry secret
kubectl create secret docker-registry regcred \
  --docker-server=registry.osakaoaks.org \
  --docker-username=your_username \
  --docker-password=your_password \
  --namespace=osaka-oaks-prod
```

### Deploy to Kubernetes

```bash
# Apply all configurations
kubectl apply -f k8s/deployment.yaml

# Check deployment status
kubectl get deployments -n osaka-oaks-prod
kubectl get pods -n osaka-oaks-prod
kubectl get services -n osaka-oaks-prod
kubectl get hpa -n osaka-oaks-prod

# View logs
kubectl logs -f deployment/osaka-oaks-web -n osaka-oaks-prod
```

### Resource Limits

```yaml
requests:
  memory: "128Mi"
  cpu: "100m"
limits:
  memory: "512Mi"
  cpu: "500m"
```

### Auto-Scaling

Horizontal Pod Autoscaler configured:
- **Min Replicas**: 2
- **Max Replicas**: 10
- **CPU Target**: 70%
- **Memory Target**: 80%

---

## 🔐 Environment Variables

### Required Variables

All environment variables must be prefixed with `VITE_` to be exposed to the frontend.

```bash
# Copy example file
cp .env.example .env

# Edit with your values
nano .env
```

### Security Best Practices

1. ✅ **Never commit .env** - Already in .gitignore
2. ✅ **Use .env.example** - Template for team members
3. ✅ **Backend secrets** - Keep API secrets server-side only
4. ✅ **Kubernetes secrets** - Store sensitive data in K8s secrets

```bash
# Create Kubernetes secret for environment variables
kubectl create secret generic osaka-oaks-env \
  --from-env-file=.env.production \
  --namespace=osaka-oaks-prod
```

---

## 🚀 CI/CD Pipeline

### GitHub Actions Workflow

Located at: `.github/workflows/deploy-react-site.yml`

**Triggers:**
- Push to `main` branch
- Manual workflow dispatch

**Steps:**
1. Security scanning
2. Install dependencies
3. Run tests
4. Build React app
5. Build Docker image
6. Push to container registry
7. Deploy to Kubernetes
8. Health check verification
9. Slack notification

### Manual Deployment

```bash
# Build and deploy
npm run build
./scripts/deploy-react-site.sh

# Or with Docker
docker build -t osaka-oaks-web:latest .
docker push registry.osakaoaks.org/osaka-oaks-web:latest
kubectl rollout restart deployment/osaka-oaks-web -n osaka-oaks-prod
```

---

## 📊 Monitoring & Health Checks

### Health Endpoints

- **HTTP Health**: `https://osakaoaks.org/health`
- **Kubernetes Liveness**: `/health` (port 80)
- **Kubernetes Readiness**: `/health` (port 80)

### Monitoring Tools

```bash
# Watch pod status
kubectl get pods -n osaka-oaks-prod -w

# Check resource usage
kubectl top pods -n osaka-oaks-prod
kubectl top nodes

# View HPA status
kubectl get hpa osaka-oaks-web-hpa -n osaka-oaks-prod -w
```

### Logs

```bash
# View logs (last 100 lines)
kubectl logs -f deployment/osaka-oaks-web -n osaka-oaks-prod --tail=100

# View logs from all pods
kubectl logs -l app=osaka-oaks -n osaka-oaks-prod --all-containers=true

# Docker logs
docker logs osaka-oaks-web -f --tail=100
```

---

## 🔄 Rollback Strategy

### Kubernetes Rollback

```bash
# View rollout history
kubectl rollout history deployment/osaka-oaks-web -n osaka-oaks-prod

# Rollback to previous version
kubectl rollout undo deployment/osaka-oaks-web -n osaka-oaks-prod

# Rollback to specific revision
kubectl rollout undo deployment/osaka-oaks-web -n osaka-oaks-prod --to-revision=2

# Check rollout status
kubectl rollout status deployment/osaka-oaks-web -n osaka-oaks-prod
```

### Server Backup

Previous deployments are backed up to:
```
~/website-backups/backup-TIMESTAMP.tar.gz
```

---

## 🛡️ Security

### Implemented Security Features

1. **nginx Security Headers**
   - X-Frame-Options: SAMEORIGIN
   - X-Content-Type-Options: nosniff
   - X-XSS-Protection: 1; mode=block
   - Referrer-Policy: strict-origin-when-cross-origin

2. **Resource Limits**
   - CPU and memory constraints
   - Prevents resource exhaustion

3. **Health Checks**
   - Automatic restart on failure
   - Zero-downtime deployments

4. **HTTPS Enforcement**
   - Handled by load balancer/ingress
   - TLS 1.2+ only

5. **Image Security**
   - Alpine-based images (smaller attack surface)
   - Regular security updates
   - No root user

---

## 📈 Performance Optimization

### Build Optimizations

- Code splitting (vendor, router, query, animations)
- Tree shaking (unused code removed)
- ESBuild minification
- Gzip compression
- Asset fingerprinting

### Caching Strategy

```nginx
# Static assets cached for 1 year
location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2|ttf|eot)$ {
    expires 1y;
    add_header Cache-Control "public, immutable";
}
```

### PWA Features

- Service worker for offline support
- App installable on mobile/desktop
- Fast loading with caching
- Background sync capability

---

## 🧪 Testing

### Local Testing

```bash
# Development server
npm run dev

# Production build locally
npm run build
npm run preview

# Docker testing
docker-compose up
```

### Load Testing

```bash
# Using Apache Bench
ab -n 1000 -c 10 https://osakaoaks.org/

# Using K6
k6 run load-test.js
```

---

## 📝 Maintenance

### Regular Tasks

**Weekly:**
- Check pod health and logs
- Review resource usage
- Monitor error rates

**Monthly:**
- Update dependencies
- Review security patches
- Check backup integrity

**Quarterly:**
- Performance audit
- Security assessment
- Cost optimization review

### Updating Dependencies

```bash
# Check for updates
npm outdated

# Update packages
npm update

# Major version upgrades
npm install react@latest react-dom@latest

# Rebuild and test
npm run build
npm run test
```

---

## 🆘 Troubleshooting

### Common Issues

**Pod Not Starting**
```bash
kubectl describe pod <pod-name> -n osaka-oaks-prod
kubectl logs <pod-name> -n osaka-oaks-prod
```

**High Memory Usage**
```bash
kubectl top pods -n osaka-oaks-prod
# Adjust memory limits in deployment.yaml
```

**Health Check Failing**
```bash
# Test health endpoint
curl https://osakaoaks.org/health

# Check nginx logs
kubectl logs deployment/osaka-oaks-web -n osaka-oaks-prod
```

**Build Failures**
```bash
# Clear cache
rm -rf node_modules dist
npm install
npm run build
```

---

## 📞 Support

**Infrastructure Team:**
- Email: infrastructure@osakaoaks.org
- Slack: #osaka-oaks-infra
- On-Call: PagerDuty

**Deployment Issues:**
- Email: jarrel.spiller@osakaoaks.org
- Phone: (832) 847-5186

---

**Last Updated:** June 18, 2026  
**Version:** 1.0.0  
**Status:** ✅ Production Ready
