# 3-Tier Node.js Application on AWS Fargate

This project demonstrates the deployment of a full 3-tier web application using AWS Fargate, Application Load Balancer, PostgreSQL on Amazon RDS, and Terraform for infrastructure provisioning.

The application includes:
- A Node.js Express backend with RESTful endpoints
- PostgreSQL RDS database with SSL enforcement
- Infrastructure deployed using Terraform modules (VPC, ECS, ALB, RDS)
- Load-balanced traffic using AWS ALB
- CI-friendly Docker container workflow

---

## Architecture Overview

```
                           ┌────────────────────────┐
                           │   Client / Browser     │
                           └────────────┬───────────┘
                                        │
                                        ▼
                           ┌────────────────────────┐
                           │    AWS ALB (HTTP:80)    │
                           └────────────┬───────────┘
                                        │
              ┌─────────────────────────┴─────────────────────────┐
              │                  Private Subnet                   │
              │   ┌────────────────────────────────────────────┐  │
              │   │           ECS Fargate Service              │  │
              │   │  (Node.js Express app, Docker container)   │  │
              │   └────────────────────────────────────────────┘  │
              └─────────────────────────┬─────────────────────────┘
                                        │
                                        ▼
                           ┌────────────────────────┐
                           │   Amazon RDS (Postgres)│
                           │  - Encrypted           │
                           │  - SSL Required        │
                           └────────────────────────┘

                           ┌────────────────────────┐
                           │   Local Development     │
                           └────────────┬───────────┘
                                        │
                  ┌──────────────────────────────────────────┐
                  │  Docker + Node.js (Local Dev Server)     │
                  │  GitHub (Docker builds, Terraform IaC)   │
                  └──────────────────────────────────────────┘
```

---

## Endpoints

- `/` → Health message from Node.js app
- `/health` → ALB health check target
- `/dbtest` → Live test of RDS connection with timestamp

---

## Technologies Used

- AWS Fargate (ECS)
- AWS Application Load Balancer
- Amazon RDS (PostgreSQL with SSL)
- Node.js + Express
- Docker
- Terraform (modular setup)
- GitHub for source + version control

---

## ✅ Lessons Learned

- Always bind to `0.0.0.0` in Docker containers for ALB health checks
- PostgreSQL on RDS requires SSL; use `ssl: { rejectUnauthorized: false }` and/or `PGSSLMODE=require`
- If a connection issue seems complicated, it's probably just a simple security group misconfiguration 🥹.
- ALB health checks are critical for debugging container readiness!

---

## 📌 Author

Deployed and documented by [Ken Brigham](https://github.com/KenB773)
