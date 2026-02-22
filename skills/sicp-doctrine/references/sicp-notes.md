# SICP + Flexibility Notes (seed)

This is a seed reference file until textbook extracts are added.

## Guiding ideas

- Programs should be built from composable abstractions.
- Separate *what* from *how* via clear interfaces.
- Data-directed and generic operations reduce rigid branching.
- Local changes should remain local when abstractions are healthy.
- Prefer designs that preserve optionality for future change.

## Review heuristics

- Can we swap implementation without caller churn?
- Is behavior extensible without editing central dispatch logic?
- Are domain concepts represented explicitly, not implied by incidental structure?
- Is complexity paid where it creates leverage, not where it creates ceremony?
