# VettedAI Pipeline Dashboard

**Mission-control dashboard for the VettedAI Content Intelligence Engine** — a fully autonomous content pipeline for [VettedAI.ai](https://vettedai.ai), "The Consumer Reports of AI for Small Business Owners."

## Overview

This dashboard is the nerve center of VettedAI's content intelligence operation. It monitors and manages a multi-stage pipeline that:

1. **Detects signals** — Scans RSS feeds, YouTube channels, and Perplexity AI for AI news relevant to small businesses
2. **Scores & prioritizes** — Uses a 4-factor SMB Scoring Model (relevance, trend velocity, content gap, tool specificity)
3. **Generates content** — Automated keyword research, content briefs, and full article drafts
4. **Reviews & publishes** — Human-in-the-loop approval before any article goes live

## Features

- **Pipeline Status Header** — Real-time status indicators for all 9 pipeline stages
- **Signal Feed** — Live stream of detected AI signals with SMB relevance scores
- **Review Queue** — Article approval workflow with full preview, approve/publish, and revision request
- **Published Articles** — Archive of all approved and published content
- **Pipeline Errors** — Collapsible error log for monitoring pipeline health

## Design

Deep-space mission control aesthetic — Bloomberg Terminal meets NASA ground control.

- Dark navy palette with electric blue accents
- Space Mono headings + IBM Plex Sans body text
- Scanline texture overlay, glow effects, sharp 4px corners
- Auto-refresh every 60 seconds

## Setup

1. Clone this repository
2. Copy `.env.example` to `.env` and fill in your Supabase credentials
3. Update the `SUPABASE_URL` and `SUPABASE_ANON_KEY` values in `index.html`
4. Deploy to any static hosting (Vercel, Netlify, S3, etc.)

### Supabase Tables Required

- `content_signals` — Detected and scored AI signals
- `keyword_research` — SEO keyword data for each signal
- `content_briefs` — Content strategy briefs
- `article_drafts` — Generated article drafts
- `article_images` — Featured images for articles
- `articles` — Final articles for review/publishing
- `pipeline_errors` — Error logging
- `rss_feeds` — RSS feed sources
- `youtube_channels` — YouTube channel sources
- `perplexity_queries` — Perplexity search queries

## Tech Stack

- Vanilla HTML/CSS/JS (no build step)
- [Supabase JS Client](https://supabase.com/docs/reference/javascript) for database operations
- [marked.js](https://marked.js.org/) for Markdown rendering
- Google Fonts (Space Mono, IBM Plex Sans)

## License

Private — VettedAI.ai
