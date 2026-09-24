# SPECS — Flutter Rewrite (Web/WASM + Android + iOS)

Condensed working spec, English, for LLM/agent consumption during the rewrite.

## 0. Purpose & source of truth
- Rewrite the current Vue 3 SPA (see `AGENTS.md` for full description of the existing app) as **one Flutter codebase** targeting Web (compiled to WebAssembly), Android, and iOS.
- Content/design parity source: this repo's current Vue implementation — components in `src/components/`, strings in `src/i18n/language.json`, tokens in `src/assets/colors.css`/`main.css`.
- One deliberate exception, shipped **last**: `VelarioSection.vue` currently iframes a third-party page (`peliberio.com.br/vela/`, not ours). Replace it with a natively-rendered, self-owned "virtual candle" feature. Until that milestone lands, keep visual parity via the same embed (webview instead of `<iframe>`).

## 1. Non-negotiable coding standards
- Dart 3, fully typed: no `dynamic`, no untyped collections, explicit return types on public members. Lints: `flutter_lints` + `strict-casts`, `strict-inference`, `strict-raw-types` in `analysis_options.yaml`.
- Functional style wherever Dart/Flutter supports it: immutable data (`final` everywhere), sealed classes + exhaustive `switch` expressions for state/unions, records for lightweight tuples, pure functions for mapping/formatting, prefer `.map/.where/.fold` over imperative loops. Widgets built as pure functions of state — no ad-hoc mutable fields.
- All identifiers, in-code strings, and docs: English.
- No explanatory comments. `///` docstrings only on public API, one short line, stating WHY/contract — never restating the signature.
- No speculative abstractions / no dead code — same "don't build for hypothetical future" rule as the rest of this project.

## 2. Target platforms & toolchain
- Flutter stable channel, Dart ≥3.x.
- Web build: `flutter build web --wasm` (dart2wasm) is the deploy artifact for GitHub Pages, replacing the current Vite build. Fall back to CanvasKit/JS build only if a required plugin isn't wasm-ready yet (see §5).
- Android: default Flutter minSdk (23+), single APK/AAB.
- iOS: standard Flutter target.
- One codebase; platform branching only via `kIsWeb` / conditional imports where unavoidable (webview embeds).

## 3. State management & structure
- **Riverpod** (`flutter_riverpod`, codegen-free `Provider`/`NotifierProvider`) — providers as pure functions of dependencies, state as immutable records/sealed classes with `copyWith`. No BLoC/provider-package/GetX mixing.
- No `freezed`/`json_serializable` unless a shape gets genuinely non-trivial (candle model, §9) — hand-written immutable classes keep builds fast and avoid codegen fragility on wasm CI.
- No `go_router` / URL-per-section routing. A single `NotifierProvider<Section>` (`Section` a sealed enum-like type: `camera`, `velario`, `about`, `history`, `visit`, `donation`) is the one source of truth for "current section", consumed differently per layout (§3.1). Each section's UI (`CameraSection`, `AboutSection`, …) is the same reusable widget regardless of which shell renders it.

### 3.1 Navigation model — responsive (mobile drawer vs desktop scroll)
Mobile's continuous full-page scroll reads as ugly/un-app-like on phones — split by `Breakpoints.isMobile(context)` (< md, 768px, same threshold already used for CSS breakpoints, §7). Applies by **viewport width**, not by platform (`kIsWeb`/OS) — a narrow browser window gets the same mobile shell as a phone.
- **Mobile (< md)** — `MobileShell`: `Scaffold` with a Material 3 `NavigationDrawer` (built-in selection pill/animation — "estiloso" for free, no hand-rolled hamburger dropdown). Each `Section` is its own **full screen**, swapped via `AnimatedSwitcher`/`IndexedStack` in the body driven by the `Section` provider — no scrolling between sections, only within one if its content overflows. Drawer item tap: `ref.read(sectionProvider.notifier).select(section)` + `Navigator.pop` (close drawer). `AppBar` per screen carries the menu button + section title (from `AppLocalizations`).
- **Desktop/tablet (≥ md)** — `DesktopShell`: today's model, unchanged — top `Navbar`, single `CustomScrollView` with all sections, `core/scroll_spy.dart` derives the active `Section` from scroll position (same algorithm as `useScrollSpy.js`) and writes it into the same provider tapping a nav link scrolls to the section's `GlobalKey`.
- `FooterSection` isn't a drawer destination (it's credits/copyright, not content) — folds into the bottom of `AboutSection` on mobile; stays a trailing block after the last section on desktop, as today.
- No deep-linking / per-section URL on mobile web yet (flagged optional, §11) — native apps don't need it, and it'd require `go_router`, which §3 deliberately avoids for now.

## 4. Folder layout
```
lib/
  main.dart
  app.dart                  # MaterialApp shell, theme + locale wiring
  theme/
    color_tokens.dart        # port of colors.css
    app_theme.dart           # ThemeData, type scale (h1/h2/h3 clamp equivalents)
  l10n/
    app_pt.arb, app_en.arb   # see §6
  core/
    section.dart               # Section type + selection provider (§3.1)
    scroll_spy.dart             # desktop active-section tracking
    breakpoints.dart             # port of sm/md/lg
  navigation/
    mobile_shell.dart            # Drawer + per-section full-screen switcher
    desktop_shell.dart            # top Navbar + continuous CustomScrollView
    responsive_shell.dart          # picks mobile/desktop by Breakpoints.isMobile
  widgets/
    navbar.dart                    # desktop-only top nav
    section_scaffold.dart           # shared max-width/padding container
  features/
    camera/                          # CameraSection port
    donation/                         # DoacaoSection port
    velario/                           # interim: webview; final: native (§9)
    about/                               # SobreSection (+ folded-in footer on mobile)
    history/                              # HistoriaSection (timeline)
    visit/                                  # VisitaSection (address/hours/map)
    footer/                                  # FooterSection (desktop trailing block)
assets/
  fonts/    # bundled Inter .ttf — NOT google_fonts pkg, avoids runtime fetch
  images/   # qrcode_pix.jpg, app icons/favicon
```

## 5. Third-party embeds & WASM compatibility
- dart2wasm forbids `dart:html`/`dart:js`. Any iframe-style embed (camera, maps, interim Velario) must go through `package:web` + `dart:js_interop`, or a plugin already migrated (verify pinned `webview_flutter_web`/`url_launcher_web` versions are wasm-ready before locking `pubspec.yaml`).
- **Camera livestream** (`safecam.brsuper.com.br`): opaque third-party player — stays a WebView embed indefinitely, not a native-reimplementation candidate. `webview_flutter` (Android/iOS) + `webview_flutter_web` behind conditional import. Port CameraSection.vue's 5-min auto-reload + visibility-regain reload via `AppLifecycleState` (mobile) / `document.visibilityState` through `package:web` (web).
- **Fullscreen**: use real platform fullscreen (`SystemUiMode.immersiveSticky` mobile; Fullscreen Web API via `package:web`) instead of the current CSS-rotate hack — same UX outcome, cleaner implementation.
- **Google Maps** (VisitaSection): default to a **static Maps image + `url_launcher`** "Open in Google Maps" button — matches how the current iframe is actually used (no panning needed), avoids per-platform API-key setup. `google_maps_flutter` is a fallback only if interactive embed is explicitly wanted (open decision, §11).
- **Donation QR**: plain bundled asset image, no platform branching.

## 6. i18n
- Replace manual `language.json` + stringly-typed `t('a.b.c')` with Flutter's official **typed** l10n: ARB files (`app_pt.arb` template + `app_en.arb`) → `flutter gen-l10n` generates `AppLocalizations` with one typed method per key (compile error on typo, unlike today's silent key-fallback).
- Migration: flatten every current nested `language.json` key to a camelCase ARB id (`sobre.card1.titulo` → `sobreCard1Titulo`). `historia.marcos` (array) doesn't fit ARB's flat model — becomes a const Dart list of an immutable `HistoryMilestone` record (`(year: String, textKey: String)`), text pulled from `AppLocalizations`.
- Locale: `Locale` in a Riverpod `StateProvider<Locale>`, default `pt`, wired to `MaterialApp.locale`. Navbar globe selector becomes a real (not placeholder) switcher as soon as `en` ships.

## 7. Design tokens → Flutter theme
- Port `colors.css` 1:1 into `color_tokens.dart`: `primary #4A1C0A`, `primaryDark #280E04`, `primaryLight #6B2E14`, `secondary #C47A1A`, `bg #1E0B04`, `surface #3D1810`, `text #F0DEC8`, `textMuted #A8845A`, `border #5C2818`, `white #F8EFE0`.
- Spacing/radius scale (`--space-*`/`--radius-*`) → const `Spacing`/`Radii` double classes.
- Breakpoints (480/768/1024) → const `Breakpoints` + `LayoutBuilder`-based helpers replacing `@media`.
- Font: Inter bundled as asset (§4); Flutter's default platform fallback covers the `system-ui` fallback role.

## 8. Feature parity map (Vue → Flutter)
| Vue | Flutter | Notes |
|---|---|---|
| `Navbar.vue` | `DesktopShell`/`Navbar` (≥md) **or** `MobileShell`/`NavigationDrawer` (<md) | §3.1 — same `Section` provider drives both |
| `CameraSection.vue` | `CameraSection` (WebView) | §5, stays embed indefinitely |
| `DoacaoSection.vue` | `DonationSection` | static asset, no logic |
| `VelarioSection.vue` | interim `VelarioWebviewSection` → final `VelarioSection` (native) | **last milestone**, §9 |
| `SobreSection.vue` | `AboutSection` | 3 cards, responsive `Wrap`/`GridView` |
| `HistoriaSection.vue` | `HistorySection` | timeline connector via `CustomPainter`, `Column` (mobile) / `Row` (desktop) |
| `VisitaSection.vue` | `VisitSection` | info list + static map (§5) |
| `FooterSection.vue` | `FooterSection` | copyright year via `DateTime.now().year` |
| `useScrollSpy.js` | `core/scroll_spy.dart` | same algorithm: reversed section list, `RenderBox.localToGlobal` per `GlobalKey` vs `navbarHeight + 16` |
| `useI18n.js` | generated `AppLocalizations` | §6 |

## 9. Velario — final milestone, native (not embedded)
- Goal: own the "light a virtual candle" feature instead of iframing `peliberio.com.br/vela/`, a third-party PHP app we don't control. Do **not** reverse-engineer its private `/vela/acender` / `/vela/velas` endpoints — that data isn't ours.
- Reimplement the *concept* independently, own data:
  - Form: name (optional/anonymous allowed) + short intention text.
  - Backend needed (current site is static GH-Pages) — **open decision**: (a) Firebase/Firestore (free tier, wasm-compatible web SDK, zero extra infra — recommended default), or (b) small self-hosted API on Mateus's `alpine-docker` LXC + Postgres/SQLite.
  - Candle lifecycle: 7-day active window (port of current copy), server-side `expiresAt`, client query filters `expiresAt > now`.
  - List view ("Ver Todas as Velas" equivalent): paginated, read-only, name + intention + lit date.
  - Visual: simple flame animation (`AnimatedContainer` or Lottie) replacing the static iframe look — nice-to-have, non-blocking.
- Sequenced deliberately **last** (§10) — everything else reaches full native parity first; Velario ships with the interim webview until this lands.

## 10. Delivery phases
1. Scaffold: Flutter app, theme tokens, l10n pipeline, folder layout, CI (wasm web build + GH Pages deploy, replacing `Makefile`/`publish.sh`/`deploy.yml`).
2. Simple sections native: Navbar+scroll-spy, Donation, About, History, Footer.
3. Visit (static map + external launch) + Camera (webview, reload/fullscreen/lifecycle logic).
4. Velario interim: webview embed of the current URL, wired into Navbar/scroll-spy — reaches full visual parity with today's site.
5. **Velario final** (native, §9).
6. Store packaging (Android signing/AAB, iOS provisioning/App Store Connect) — only once actually asked for; not required for phases 1–5.

## 11. Open decisions (need Mateus)
- Velario backend: Firebase vs self-hosted (§9).
- Interactive Google Maps vs static image + external link (§5) — default static unless told otherwise.
- Custom domain vs `github.io/<repo>/` path — affects web build base-href equivalent.
- Whether Android/iOS store publishing is wanted now, or web-only for now (affects phase 6 timing/signing/Apple dev account).
- Deep-linkable per-section URLs on mobile web (would need `go_router`, §3.1) — default no, native-app-like in-memory nav only, revisit if SEO/shareable-links matter.
