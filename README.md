# WePLAT Backend - Applicant Service

> 채용 플랫폼 WePLAT의 **지원자/이력서 관리** 마이크로서비스

## Overview

지원자(Applicant) 프로필, 이력서(Resume), 지원 내역(Application)을 관리하는 REST API 서버입니다.
JHipster 기반으로 생성되었으며, Spring Boot + JPA + JWT 인증을 사용합니다.

## Tech Stack

| Category | Technology |
|----------|-----------|
| Framework | Spring Boot + JHipster |
| Language | Java 11 |
| Build | Gradle 7.4 |
| ORM | Spring Data JPA + Hibernate |
| Database | MySQL 8.0 (prod) / H2 (dev) |
| Cache | Ehcache (2nd level) |
| Security | Spring Security + JWT |
| API Docs | SpringDoc OpenAPI 3.0 |
| Migration | Liquibase |
| Monitoring | Micrometer + Prometheus |
| Web Server | Undertow |
| Deploy | Docker + AWS ECS Fargate |

## Domain Model

```
┌────────────┐      1:N      ┌──────────┐      1:N      ┌─────────────┐
│  Applicant │──────────────▶│  Resume   │──────────────▶│ Application │
│            │               │           │               │             │
│ name       │               │ title     │               │ appDate     │
│ email      │               │ content   │               │             │
│ phone      │               │ submitted │               │             │
└────────────┘               └──────────┘               └─────────────┘
```

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| `GET` | `/api/applicants` | 지원자 목록 (페이지네이션) |
| `POST` | `/api/applicants` | 지원자 등록 |
| `GET` | `/api/applicants/{id}` | 지원자 상세 |
| `PUT` | `/api/applicants/{id}` | 지원자 수정 |
| `DELETE` | `/api/applicants/{id}` | 지원자 삭제 |
| `GET` | `/api/resumes` | 이력서 목록 |
| `POST` | `/api/resumes` | 이력서 등록 |
| `GET` | `/api/resumes/{id}` | 이력서 상세 |
| `PUT` | `/api/resumes/{id}` | 이력서 수정 |
| `DELETE` | `/api/resumes/{id}` | 이력서 삭제 |
| `GET` | `/api/applications` | 지원 내역 목록 |
| `POST` | `/api/applications` | 지원 등록 |
| `POST` | `/api/authenticate` | JWT 로그인 |
| `GET` | `/api/account` | 현재 사용자 정보 |

## Project Structure

```
src/main/java/com/application/
├── config/              # Spring 설정 (Security, DB, Cache, Async)
├── domain/              # JPA 엔티티 (Applicant, Resume, Application)
├── repository/          # Spring Data JPA Repository
├── security/jwt/        # JWT 토큰 생성/검증/필터
├── web/rest/            # REST 컨트롤러
└── aop/logging/         # AOP 로깅

application-batch/       # Spring Batch 모듈
application-core/        # 공유 코어 모듈
```

## Getting Started

```bash
# 개발 모드 실행 (H2 DB)
./gradlew bootRun

# 빌드
./gradlew bootJar

# Docker
docker build -t weplat-applicant .
docker run -p 8080:8080 weplat-applicant
```

## Configuration

| Profile | DB | Port | 비고 |
|---------|-----|------|------|
| `dev` | H2 (in-memory) | 8080 | 기본 프로필 |
| `prod` | MySQL (AWS RDS) | 8080 | `ap-northeast-2` |

## Deployment

GitHub Actions → Gradle Build → Docker → Amazon ECR → ECS Fargate

- **Region:** ap-northeast-2 (Seoul)
- **DB:** AWS RDS MySQL (`applicant` schema)
- **Monitoring:** `/management/prometheus`, `/management/health`
- **API Docs:** `/v3/api-docs`
