# Task: Migrate a Third-Party SDK Integration to Effect

You are working on a backend service that interacts with a document storage SDK. The current implementation uses raw async/await and scatters Promise conversions throughout the codebase. Your job is to migrate the integration to idiomatic Effect TypeScript.

## Project Context

The project is at `/workspace/scenario-3-project/`. It has `effect` and `@effect/platform-node` installed. The existing code lives in `src/storage/`.

The SDK (`DocumentStoreClient`) has many operations (upload, download, delete, list, getMetadata, setMetadata, createFolder, etc.) and each returns a Promise. The SDK also accepts an optional `AbortSignal` on each call.

The existing file `src/storage/legacy.ts` shows the current async/await implementation (read it for context on how the SDK is used and what errors it throws).

## What to Produce

Write the following new files:

- `/workspace/scenario-3-project/src/storage/DocumentStore.ts` — the Effect service wrapping the SDK
- `/workspace/scenario-3-project/src/storage/errors.ts` — typed error definitions for SDK failures
- `/workspace/scenario-3-project/src/storage/index.ts` — barrel export

Additionally, in `/workspace/scenario-3-project/src/app.ts`, there is a React-like framework callback that needs to call Effect code. Update it to use a runtime approach appropriate for a non-Effect host environment executing Effect code repeatedly.

## Constraints

- The service must handle the wide SDK surface without manually wrapping every method
- Cancellation must be preserved using AbortSignal where the SDK supports it
- All SDK errors must be converted to a typed tagged error rather than left as unknown
- Do not call any Effect.run* inside the DocumentStore service itself
- The app.ts framework callback should not be refactored into a full Effect entrypoint — the surrounding framework code must remain as-is
- Write idiomatic TypeScript
