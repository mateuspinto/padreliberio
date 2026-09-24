# Mina do Padre Libério — Flutter app

## Audience: elderly users, low technology comfort
Both the native app and the web build target an older audience with limited
tech experience. Every UI decision defaults to this unless a screen is
explicitly internal/dev-only:
- Touch targets ≥48dp, and ≥56dp for primary actions (main CTAs, nav bar
  items). Never shrink a tappable area to fit more things on screen.
- Icons are always paired with a text label — no icon-only buttons/nav
  items. An icon alone is a guess; a label isn't.
- Base body text ≥18sp, headings ≥24sp. Never hardcode a fixed
  `TextScaler`/`textScaleFactor` — respect the system's own text-size
  setting, many users have it turned up.
- High-contrast text on solid backgrounds. Never place text directly over a
  photo/gradient without a solid scrim behind it.
- Bottom navigation is fixed: same position, same items, always visible —
  never floating, never auto-hiding on scroll. Predictability beats "clean".
- No gesture-only interactions (swipe-to-dismiss, long-press-to-reveal).
  Every action has an explicit, visible button.
- No auto-advancing carousels, no session/interaction timeouts.
- Shallow navigation — anything reachable in ~2 taps from the bottom bar.
- Confirm before any destructive/irreversible action.
- Never rely on color alone to convey state (pair with icon/text too).

## Performance on low-end hardware
The Android build must stay usable on weak/old phones:
- Avoid `BackdropFilter`/blur and stacked `Opacity` widgets — both are
  expensive per frame.
- Prefer `const` constructors everywhere possible.
- Keep animations short and simple; avoid layering multiple simultaneous
  animations.
- Keep the camera `WebView` mounted only while its tab is actually visible
  — don't let it run offscreen.
- Keep bundled images pre-compressed; don't ship oversized source assets.
- Release builds already lean on this: Android R8 minify + resource shrink
  (`android/app/build.gradle.kts`) and Flutter's default icon tree-shaking
  — keep both on, don't disable them for convenience.

## Design tokens
`lib/theme/color_tokens.dart` is the single source of truth for color —
never hardcode a hex value in a widget. Predominant color is a near-white
warm beige (`bg`/`surface`); accent is a wine/maroon (`primary`). When
adding a widget, check what background it sits on and pick the matching
text/icon token — `white`/`text` are not interchangeable, one is "on light
surface", the other is "on primary (wine)".
