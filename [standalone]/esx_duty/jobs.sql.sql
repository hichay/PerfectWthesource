INSERT INTO `jobs` (name, label) VALUES
  ('offpolice','Off-Duty'),
  ('offambulance','Off-Duty')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('offpolice',0,'recruit','Sĩ Quan',12,'{}','{}'),
  ('offpolice',1,'officer','Thiếu Úy',24,'{}','{}'),
  ('offpolice',2,'sergeant','Mật Vụ',36,'{}','{}'),
  ('offpolice',3,'lieutenant','Phó Tư Lệnh',48,'{}','{}'),
  ('offpolice',4,'boss','Tổng Tư Lệnh',0,'{}','{}'),
  ('offambulance',0,'ambulance','Thực Tập',12,'{}','{}'),
  ('offambulance',1,'doctor','Bác Sĩ',24,'{}','{}'),
  ('offambulance',2,'chief_doctor','Trường Nhóm',36,'{}','{}'),
  ('offambulance',2,'leader','Trưởng Khoa',36,'{}','{}'),
  ('offambulance',3,'boss','Giám Đốc',48,'{}','{}')
;