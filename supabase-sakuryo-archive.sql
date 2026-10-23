create table public.sakuryo_phone_saves (
  user_id uuid primary key references auth.users (id) on delete cascade,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.sakuryo_phone_saves enable row level security;

grant select, insert, update, delete on public.sakuryo_phone_saves to authenticated;

create policy "Users can read their own Sakuryo save"
  on public.sakuryo_phone_saves for select
  to authenticated
  using (auth.uid() = user_id);

create policy "Users can create their own Sakuryo save"
  on public.sakuryo_phone_saves for insert
  to authenticated
  with check (auth.uid() = user_id);

create policy "Users can update their own Sakuryo save"
  on public.sakuryo_phone_saves for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

create policy "Users can delete their own Sakuryo save"
  on public.sakuryo_phone_saves for delete
  to authenticated
  using (auth.uid() = user_id);
