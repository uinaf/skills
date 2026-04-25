# Voice & copy

The voice tests harder than any visual rule. If a sentence could appear on a generic SaaS landing page, rewrite it.

## The five rules

1. **Lowercase.** Always. Headings, nav, buttons, product names, the company name. The legal entity ("undefined is not a function LLC") is the only exception, and only when it must appear verbatim.
2. **Short.** Single sentences. Paragraphs are 1–3 sentences. Lists run short.
3. **Direct.** No filler ("simply", "just", "easily"), no qualifiers ("essentially", "basically"), no SaaS verbs ("empower", "unlock", "elevate", "transform").
4. **Dry.** Wit lives in the *content*, not in punctuation. No exclamation marks. No em-dash drama. No emoji.
5. **Specific.** A literal description of what something does beats a benefit statement. `tccutil — CLI helpers for managing macOS TCC permissions.` not `tccutil — take back control of macOS privacy.`

## What it sounds like

These are lifted from production:

- `we bet you've seen us before`
- `we build software. if it has a screen, we've probably shipped something for it.`
- `terminals, browsers, phones, TVs, set-top boxes, and more.`
- `ten years in, still having fun.`
- `open-source tools we actively build and maintain.`
- `credit where it's due.`
- `these terms apply when you use our services, unless we agree to something else in writing.`
- `we fix bugs caused by our work.`
- `we don't guarantee perfection. software has edge cases.`

## What it never sounds like

Pure SaaS landing-page sludge:

- ❌ "Empowering teams to ship faster."
- ❌ "AI-native automation for the modern enterprise."
- ❌ "Reimagining the developer workflow."
- ❌ "Unlock the full potential of your stack."
- ❌ "We're on a mission to…"
- ❌ "You deserve better tooling."

If a draft trips the SaaS detector, scrap it and write what the thing literally does.

## Pronouns

- **"we"** — first-person plural, for the studio
- **"you"** — second-person, used sparingly and only in actual instructions ("you'll need a Berkeley Mono license"), never in marketing-flattery ("you deserve…")

## Casing edge cases

- Code identifiers, file paths, URLs: keep their canonical case (`AGENTS.md`, `tile.json`, `https://uinaf.dev`).
- Quoted proper nouns: keep their canonical case (`"Berkeley Mono"`, `"undefined is not a function LLC"`).
- Everything else in body and chrome: lowercase.

## Punctuation

- Periods at the end of sentence fragments are fine.
- Em dashes for parenthetical breaks. Never as decorative bullets.
- Middle dot `·` (U+00B7) as a separator in footer link clusters: `projects · terms · thanks`.
- Unicode arrows: `↗` trailing every external link, `→` for forward, `← ↑ ↓` sparingly in dashboards.
- No exclamation marks. None.
- No emoji. None.

## Microcopy patterns

| Surface | Pattern |
|---|---|
| Footer nav | `projects · terms · thanks` |
| Footer contact | `dev@uinaf.dev · github ↗ · x ↗` |
| External link | `name ↗` |
| Card title | product name, lowercase, no prefix |
| Card description | one literal sentence, period at end |
| Section subhead | sentence-case-but-lowercase: `open-source tools we actively build and maintain.` |
| Hero h1 | sentence fragment, period optional, lowercase: `we bet you've seen us before` |
| 404 / error | matter-of-fact: `not here. probably never was.` not `Oops! Something went wrong!` |

## Product / project copy

```
healthd — small daemon for machine health checks and reporting.
tccutil — CLI helpers for managing macOS TCC permissions.
berkeley mono — typeface by Berkeley Graphics.
```

Pattern: `name — literal one-line description.` Em dash. Period at end. Lowercase name. Description describes what it *is* or *does*, not what value it provides.

## Long-form prose

For terms, docs, acknowledgements: same voice, just more of it. Cordon long-form into its own scroll container so the rest of the page stays sparse. Don't adopt a separate "legal" or "documentation" register — uinaf reads the same everywhere.

## Quick checklist

Before shipping copy, scan for:

- Any uppercase letters in body or chrome → lowercase them
- Exclamation marks → delete
- Emoji → delete
- "empower", "unlock", "elevate", "transform", "synergies", "simply", "just", "essentially" → rewrite
- "We're on a mission to…", "You deserve…", "Built for…" → scrap and start over
- Sentences over 20 words → cut in half
- Marketing-flattery toward the reader → cut
