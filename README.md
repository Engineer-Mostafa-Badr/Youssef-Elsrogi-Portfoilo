# Youssef Elsrogi — Portfolio

Personal portfolio for a Backend Laravel Developer, built with Flutter Web.
Bilingual (EN / AR with full RTL), dark + light themes, colors taken from the portrait.

## Run

```bash
flutter pub get
flutter run -d chrome
```

## Build & deploy

```bash
flutter build web --release   # output: build/web
```

Deployed on **Cloudflare Pages**, connected to this GitHub repo — every push to `main` rebuilds the site.
Cloudflare's build image has no Flutter, so `cloudflare-build.sh` installs the pinned version (3.35.3) first.

| Pages setting | Value |
| --- | --- |
| Framework preset | None |
| Build command | `bash cloudflare-build.sh` |
| Build output directory | `build/web` |
| Production branch | `main` |

`web/_headers` sets caching + security headers; `robots.txt` / `sitemap.xml` point to https://youssefelsrogi.com.

## Editing content

All text lives in `lib/data/portfolio_data.dart` as `T('English', 'عربي')` pairs.
Links (email, phone, LinkedIn, GitHub, CV path) live in `lib/core/links.dart`.
Colors live in `lib/core/theme.dart` (`AppColors.dark` / `AppColors.light`).

The CV download points to `web/cv/Youssef-Elsrogi-CV.pdf` — drop the PDF there before building.

## Extras

- `Ctrl / ⌘ + K` — command palette
- Konami code (↑↑↓↓←→←→BA) — easter egg
- Deep links: `?s=projects`, `?lang=ar`, `?theme=light`
