-- ============================================================
-- VettedAI Pipeline - Complete Supabase Schema
-- Run this FIRST if tables don't exist yet
-- ============================================================

CREATE TABLE IF NOT EXISTS rss_feeds (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    url             text NOT NULL,
    name            text,
    priority        integer DEFAULT 2,
    enabled         boolean DEFAULT true,
    last_item_guid  text,
    last_scanned_at timestamptz
);

CREATE TABLE IF NOT EXISTS youtube_channels (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    channel_id      text NOT NULL,
    name            text,
    enabled         boolean DEFAULT true,
    last_scanned_at timestamptz
);

CREATE TABLE IF NOT EXISTS perplexity_queries (
    id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    query_text      text NOT NULL,
    enabled         boolean DEFAULT true,
    last_run_at     timestamptz
);

CREATE TABLE IF NOT EXISTS content_signals (
    id                    uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    topic                 text NOT NULL,
    summary               text,
    url                   text,
    source_type           text,
    source_name           text,
    calculated_score      numeric,
    smb_relevance_score   numeric,
    trend_velocity_score  numeric,
    content_gap_score     numeric,
    tool_specificity_score numeric,
    is_smb_relevant       boolean,
    smb_relevance_reason  text,
    category              text,
    topic_type            text,
    status                text DEFAULT 'new',
    signal_count          integer DEFAULT 1,
    created_at            timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS keyword_research (
    id                        uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    signal_id                 uuid REFERENCES content_signals(id),
    primary_keyword           text,
    secondary_keywords        text[],
    long_tail_keywords        text[],
    search_intent             text,
    competition_level         text,
    content_angle             text,
    recommended_title         text,
    recommended_h2s           text[],
    search_volume_data        jsonb,
    competition_data          jsonb,
    status                    text DEFAULT 'pending',
    created_at                timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS content_briefs (
    id                    uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    signal_id             uuid REFERENCES content_signals(id),
    keyword_research_id   uuid REFERENCES keyword_research(id),
    target_audience       text,
    content_goal          text,
    tone_of_voice         text,
    word_count_target     integer,
    primary_keyword       text,
    secondary_keywords    text[],
    h2_outline            jsonb,
    competitor_analysis   text,
    key_points_to_cover   text[],
    calls_to_action       text[],
    status                text DEFAULT 'pending',
    created_at            timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS article_drafts (
    id               uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    brief_id         uuid REFERENCES content_briefs(id),
    status           text DEFAULT 'pending',
    title            text,
    meta_description text,
    body_markdown    text,
    word_count       integer,
    version          integer DEFAULT 1,
    created_at       timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS article_images (
    id           uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    draft_id     uuid REFERENCES article_drafts(id),
    image_type   text,
    prompt       text,
    image_url    text,
    status       text DEFAULT 'pending',
    created_at   timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS articles (
    id                  uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    draft_id            uuid REFERENCES article_drafts(id),
    title               text,
    meta_description    text,
    body_markdown       text,
    featured_image_url  text,
    status              text DEFAULT 'pending-review',
    revision_notes      text,
    published_at        timestamptz,
    created_at          timestamptz DEFAULT now()
);

CREATE TABLE IF NOT EXISTS pipeline_errors (
    id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    stage         text,
    source        text,
    error_message text,
    created_at    timestamptz DEFAULT now()
);

-- Disable RLS on all tables for the pipeline connector
ALTER TABLE rss_feeds DISABLE ROW LEVEL SECURITY;
ALTER TABLE youtube_channels DISABLE ROW LEVEL SECURITY;
ALTER TABLE perplexity_queries DISABLE ROW LEVEL SECURITY;
ALTER TABLE content_signals DISABLE ROW LEVEL SECURITY;
ALTER TABLE keyword_research DISABLE ROW LEVEL SECURITY;
ALTER TABLE content_briefs DISABLE ROW LEVEL SECURITY;
ALTER TABLE article_drafts DISABLE ROW LEVEL SECURITY;
ALTER TABLE article_images DISABLE ROW LEVEL SECURITY;
ALTER TABLE articles DISABLE ROW LEVEL SECURITY;
ALTER TABLE pipeline_errors DISABLE ROW LEVEL SECURITY;
