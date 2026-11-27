-- این فایل فقط ردیف اولیه انبار را ایجاد می‌کند.
-- جدول inventory_state و سیاست‌های RLS قبلاً در پروژه شما ساخته شده‌اند.
-- ساختار مورد انتظار: id کوچک با مقدار 1 و ستون data از نوع jsonb.
insert into public.inventory_state (id, data)
values (1, '{"items":[],"loans":[],"letters":[]}'::jsonb)
on conflict (id) do nothing;

-- جدول باید در publication مربوط به Realtime باشد. اگر قبلاً اضافه شده، نیازی به اجرای دوباره نیست.
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'inventory_state'
  ) then
    alter publication supabase_realtime add table public.inventory_state;
  end if;
end $$;
