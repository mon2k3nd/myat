CREATE TABLE public.wishes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  guest_name TEXT NOT NULL CHECK (char_length(guest_name) BETWEEN 1 AND 100),
  message TEXT NOT NULL CHECK (char_length(message) BETWEEN 1 AND 500),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

GRANT SELECT, INSERT ON public.wishes TO anon;
GRANT SELECT, INSERT ON public.wishes TO authenticated;
GRANT ALL ON public.wishes TO service_role;

ALTER TABLE public.wishes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read wishes"
  ON public.wishes FOR SELECT
  TO anon, authenticated
  USING (true);

CREATE POLICY "Anyone can leave a wish"
  ON public.wishes FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

CREATE INDEX wishes_created_at_idx ON public.wishes (created_at DESC);