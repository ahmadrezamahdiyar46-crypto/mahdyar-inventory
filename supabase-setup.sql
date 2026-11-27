create table if not exists public.inventory_state (
  id text primary key,
  payload jsonb not null default '{"items":[],"loans":[],"letters":[]}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.inventory_state enable row level security;
drop policy if exists "authenticated users can read shared inventory" on public.inventory_state;
drop policy if exists "authenticated users can insert shared inventory" on public.inventory_state;
drop policy if exists "authenticated users can update shared inventory" on public.inventory_state;
create policy "authenticated users can read shared inventory" on public.inventory_state for select to authenticated using (true);
create policy "authenticated users can insert shared inventory" on public.inventory_state for insert to authenticated with check (true);
create policy "authenticated users can update shared inventory" on public.inventory_state for update to authenticated using (true) with check (true);
alter publication supabase_realtime add table public.inventory_state;
