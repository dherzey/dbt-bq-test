
{{ config(materialized="table") }}

select 
  Motivation_Level as motivation_level,
  Attendance as attendance,
  Access_to_Resources as access_to_resources,
  Peer_Influence as peer_influence
from `sample.student_performance`
where School_Type="Private"