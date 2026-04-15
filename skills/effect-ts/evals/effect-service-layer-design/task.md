# Task: Implement a Notification Service

You are working on a Node.js application that sends email and push notifications. The current implementation uses a mix of global variables and ad hoc error handling. Your job is to implement a clean `NotificationService` in Effect TypeScript.

## Project Context

The project is located at `/workspace/scenario-1-project/`. It already has `effect` and `@effect/platform-node` installed. There is a `src/notifications/` directory with a stub file.

## Requirements

Implement a `NotificationService` that:

1. Sends email notifications using a hypothetical `EmailClient` dependency
2. Sends push notifications using a hypothetical `PushClient` dependency
3. Exposes a single `send(notification: Notification) => Effect` method
4. Supports two notification types: `EmailNotification` and `PushNotification`
5. Models failures explicitly — differentiate between `EmailDeliveryError` and `PushDeliveryError`
6. Can be tested without real email or push infrastructure

## What to Produce

Write the following files (create them at the paths shown):

- `/workspace/scenario-1-project/src/notifications/NotificationService.ts` — the service definition and live layer
- `/workspace/scenario-1-project/src/notifications/errors.ts` — error types
- `/workspace/scenario-1-project/src/notifications/models.ts` — domain model types
- `/workspace/scenario-1-project/src/notifications/index.ts` — barrel export

The existing stub at `/workspace/scenario-1-project/src/notifications/stub.ts` shows the current imperative approach (for reference only).

## Constraints

- Do not use any external runtime execution inside the service implementation
- All dependencies must flow through the layer system
- The `send` method signature must not carry extra environment requirements beyond what the layer provides
- Use TypeScript
