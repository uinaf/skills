# Assets

Berkeley Mono and the two brand illustrations. That's the entire asset library.

## Berkeley Mono — fonts

uinaf-controlled web projects load Berkeley Mono from `cdn.uinaf.dev`. The CDN ships a single stylesheet that wires the variable woff2 (covers all weights) plus italic via `slnt -16`.

### Usage

```html
<link rel="stylesheet" href="https://cdn.uinaf.dev/fonts/berkeley-mono/variable/font.css">
```

```css
font-family: "Berkeley Mono", ui-monospace, "SF Mono", "JetBrains Mono",
  Menlo, Consolas, monospace;
```

Already done in [colors_and_type.css](../assets/colors_and_type.css) — drop that file in and you're wired.

### CORS / cache

The CDN serves `/fonts/*` with `Access-Control-Allow-Origin: *` and immutable cache headers. No CORS config needed on the consumer side.

### License

Berkeley Mono is a commercial typeface from [Berkeley Graphics](https://berkeleygraphics.com/typefaces/berkeley-mono/). The CDN is hosted under uinaf's license — only uinaf-owned properties may pull from it.

**Off-uinaf consumers** need their own license, or should swap to JetBrains Mono as the rough-match ship-time fallback:

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700&display=swap">
```

```css
font-family: "JetBrains Mono", ui-monospace, "SF Mono", Menlo, Consolas, monospace;
```

## Brand illustrations

Two illustrations exist. Don't generate or commission look-alikes; commission new originals if more are needed.

Pick by what the surface is *about*:

### `uinaf-computer.png` — primary mark (product surfaces) + favicon

- The melting CRT alone
- Default studio identifier on **product surfaces**: tools, demos, internal dashboards, docs sites, slides, embedded app shells, README hero images
- Iconic enough to identify the studio without competing with the page's actual content
- Renders at 240×240 inside a 1px `--neutral-900` square frame for hero placement, or 60–80px in tool chrome
- Also doubles as favicon at 32×32 and apple-touch-icon at 180×180

### `uinaf-team.png` — about / social mark

- Two robed skeletons at a melting CRT
- Used on the **studio homepage** (`uinaf.dev`), About pages, team listings, and social share images (OG / Twitter)
- Renders well at 240×240 as a monolithic lockup when the studio itself is the subject
- Same 1px `--neutral-900` framing rules

### CDN paths (preferred for production)

```
https://cdn.uinaf.dev/images/uinaf-team.png
https://cdn.uinaf.dev/images/uinaf-computer.png
```

### Bundled paths (offline / standalone)

The skill ships local copies for offline work, slide-deck mocks, and the case where the CDN isn't reachable:

- [assets/uinaf-team.png](../assets/uinaf-team.png)
- [assets/uinaf-computer.png](../assets/uinaf-computer.png)

### Hard rules

- Never rotate, recolor, gradient-fill, or filter the illustrations.
- Always present on pure black with no surrounding chrome.
- Logo lockup is the framed 240×240 square. The 1px `--neutral-900` border is part of the mark.
- Avatar / small-icon usage: 60–80px on the same black canvas.
- Favicon usage: `uinaf-computer.png` only. Not the team mark.
- Default to `uinaf-computer.png` for product surfaces. Reach for `uinaf-team.png` only when the studio itself is the subject (homepage, About, OG image).

### Favicon wiring

```html
<link rel="icon" type="image/png" sizes="32x32"
  href="https://cdn.uinaf.dev/images/uinaf-computer.png">
<link rel="apple-touch-icon" sizes="180x180"
  href="https://cdn.uinaf.dev/images/uinaf-computer.png">
```

The PNG renders sharp at both sizes — no separate `apple-touch-icon-180.png` needed.

### Open Graph

```html
<meta property="og:image" content="https://cdn.uinaf.dev/images/uinaf-team.png">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="1200">
<meta property="twitter:card" content="summary_large_image">
<meta property="twitter:image" content="https://cdn.uinaf.dev/images/uinaf-team.png">
```

## Wordmark

There is no separate text wordmark file. The text `uinaf` set in Berkeley Mono lowercase is the wordmark wherever the framed image is overkill (social handles, command-line prompts, embedded mentions).
