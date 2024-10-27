{{ config(materialized="table") }}

select *
from `sample.remote_work_impact`
where lower(Job_Role) like "%data%"