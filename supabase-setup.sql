-- ============================================================
-- VettedAI Pipeline - Supabase RLS Policies
-- Run this in your Supabase SQL Editor (Dashboard > SQL Editor)
-- ============================================================

-- Add revision_notes column to articles if it doesn't exist
ALTER TABLE articles ADD COLUMN IF NOT EXISTS revision_notes text;

-- ============================================================
-- Option A: DISABLE RLS on all pipeline tables (simplest)
-- Use this if the Pipedream connector uses the anon key
-- ============================================================

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

-- ============================================================
-- Option B (ALTERNATIVE): If you want to keep RLS enabled,
-- uncomment these policies instead of the DISABLE statements above.
-- These allow full CRUD for both anon and authenticated roles.
-- ============================================================

/*
-- rss_feeds
CREATE POLICY "Allow all access to rss_feeds" ON rss_feeds FOR ALL USING (true) WITH CHECK (true);

-- youtube_channels
CREATE POLICY "Allow all access to youtube_channels" ON youtube_channels FOR ALL USING (true) WITH CHECK (true);

-- perplexity_queries
CREATE POLICY "Allow all access to perplexity_queries" ON perplexity_queries FOR ALL USING (true) WITH CHECK (true);

-- content_signals
CREATE POLICY "Allow all access to content_signals" ON content_signals FOR ALL USING (true) WITH CHECK (true);

-- keyword_research
CREATE POLICY "Allow all access to keyword_research" ON keyword_research FOR ALL USING (true) WITH CHECK (true);

-- content_briefs
CREATE POLICY "Allow all access to content_briefs" ON content_briefs FOR ALL USING (true) WITH CHECK (true);

-- article_drafts
CREATE POLICY "Allow all access to article_drafts" ON article_drafts FOR ALL USING (true) WITH CHECK (true);

-- article_images
CREATE POLICY "Allow all access to article_images" ON article_images FOR ALL USING (true) WITH CHECK (true);

-- articles
CREATE POLICY "Allow all access to articles" ON articles FOR ALL USING (true) WITH CHECK (true);

-- pipeline_errors
CREATE POLICY "Allow all access to pipeline_errors" ON pipeline_errors FOR ALL USING (true) WITH CHECK (true);
*/

-- ============================================================
-- Verify: After running, test with this query:
-- ============================================================
SELECT 'RLS disabled successfully' AS status;
