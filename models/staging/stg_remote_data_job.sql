{{ config(materialized="table") }}

select *
from {{ source("staging", "remote_work_impact") }}
where lower(Job_Role) like "%data%"
limit 500