{{ config(materialized="table") }}

select 
  left(sha1(concat(
    Attendance,
    Parental_Involvement,
    Exam_Score,
    Peer_Influence
  )),8) as id,
  *
from `sample.student_performance`
limit 100