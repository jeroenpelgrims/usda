with ranked as (
    select *,
           count(*) over (partition by description) as description_count
    from food
    where data_type in ('foundation_food', 'sr_legacy_food')
)
select *
from ranked
where description_count > 1;

When inserting, dedupe.
There might be duplicate records with different publication_date (take highest)
There might be records with different data_type (foundation_food vs sr_legacy_food), take foundation_food
Fix: 
- make description unique
- order staging table so that the max publication date is first, and foundation_food is before sr_legacy_food
