----------------------------PART 1 --------------------------------------
USE ITI ;

----------------- 1) -----------------------------
SELECT COUNT(St_Age) 
FROM Student s ;

-----------------2)-------------------------------
SELECT DISTINCT INS.Ins_Name
FROM Instructor INS ;

-----------------#####3)-------------------------------
SELECT S.St_Id AS [Student ID] ,
       ISNULL(S.St_Fname,'unknown')+ ' ' + ISNULL(S.St_Lname,'unknown') AS [Student Full Name],
       ISNULL(DEPT.Dept_Name,'unknown') AS [Department Name]

FROM Student S JOIN Department DEPT
ON S.Dept_Id = DEPT.Dept_Id;

-----------------------4)-------------------------------
SELECT INS.Ins_Name , DEPT.Dept_Name
FROM Instructor INS  LEFT JOIN Department DEPT
ON INS.Dept_Id = DEPT.Dept_Id

------------------------5)------------------------------
SELECT S.St_Fname + ' ' + S.St_Lname AS StudentFullNmae,
C.Crs_Name
FROM Student S JOIN Stud_Course SC
ON SC.St_Id = S.St_Id
JOIN Course C
ON SC.Crs_Id = C.Crs_Id
WHERE sc.Grade IS NOT NULL ;

-----------------------6)--------------------------------
SELECT COUNT(crs_id) , T.Top_Name
FROM Course C JOIN TOPIC T
ON C.Top_Id = T.Top_Id 
GROUP BY Top_Name;

-----------------------7)--------------------------------
SELECT MAX(Salary) AS MaxSalary ,MIN(SALARY) As MinSalary
FROM Instructor INS

-----------------------8)---------------------------------
SELECT *
FROM Instructor INS 
WHERE INS.Salary <
(
    SELECT AVG(INS.Salary)
    FROM Instructor INS
);

----------------------9)------------------------------------
SELECT D.Dept_Name
FROM Department D JOIN Instructor INS 
ON D.Dept_Id = INS.Dept_Id 
WHERE INS.Salary <
(
    SELECT MIN(Salary)
    FROM Instructor INS 
);
---------------------10)-------------------------------------
SELECT Top(2) Salary
FROM INSTRUCTOR INS
ORDER BY Salary DESC ;

--------------#######11)-----------------------------------
SELECT
    Ins_Name,
    COALESCE(CAST(Salary AS NVARCHAR(20)), 'Instructor Bonus') AS Salary
FROM Instructor;

-----------------12)--------------------------------------
SELECT AVG(Salary) AS AverageSalary
FROM Instructor;

-----------------13)--------------------------------------
SELECT
    S.St_Fname AS StudentName,
    Sup.*
FROM Student S
LEFT JOIN Student Sup
ON S.St_super = Sup.St_Id;

-----------------14)---------------------------------------

GO
CREATE VIEW VStudentCourse
AS
SELECT
    S.St_Fname + ' ' + S.St_Lname AS StudentName,
    C.Crs_Name
FROM Student S
JOIN Stud_Course SC
ON S.St_Id = SC.St_Id
JOIN Course C
ON C.Crs_Id = SC.Crs_Id
WHERE SC.Grade > 50;

-----------------------15---------------
GO
CREATE VIEW VManagerTopics
AS
SELECT
    I.Ins_Name AS ManagerName,
    T.Top_Name
FROM Department D
JOIN Instructor I
ON D.Dept_Manager = I.Ins_Id
JOIN Course C
ON C.Top_Id = C.Top_Id
JOIN Topic T
ON C.Top_Id = T.Top_Id;

-------------16-----------------
GO
CREATE VIEW VSD_Java
AS
SELECT
    I.Ins_Name,
    D.Dept_Name
FROM Instructor I
JOIN Department D
ON I.Dept_Id = D.Dept_Id
WHERE D.Dept_Name IN ('SD','Java');