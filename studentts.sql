CREATE TABLE STUDENT (
    Student_ID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Email VARCHAR2(100)
);

CREATE TABLE INTEREST (
    interest_id NUMBER PRIMARY KEY,
    interest_name VARCHAR2(100)
);

CREATE TABLE AVAILABILITY (
    availability_id NUMBER PRIMARY KEY,
    day VARCHAR2(20),
    time_slot VARCHAR2(50),
    availability_status VARCHAR2(20)
);

CREATE TABLE SKILL (
    skill_id NUMBER PRIMARY KEY,
    skill_name VARCHAR2(100)
);

CREATE TABLE TEAM (
    team_id NUMBER PRIMARY KEY,
    team_name VARCHAR2(100)
);

CREATE TABLE EVENT (
    event_id NUMBER PRIMARY KEY,
    title VARCHAR2(100),
    category VARCHAR2(50),
    max_team_size NUMBER,
    deadline DATE
);

CREATE TABLE STUDENT_INTEREST (
    Student_ID NUMBER,
    interest_id NUMBER,
    PRIMARY KEY (Student_ID, interest_id),
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (interest_id) REFERENCES INTEREST(interest_id)
);

CREATE TABLE STUDENT_AVAILABILITY (
    Student_ID NUMBER,
    availability_id NUMBER,
    PRIMARY KEY (Student_ID, availability_id),
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (availability_id) REFERENCES AVAILABILITY(availability_id)
);

CREATE TABLE STUDENT_SKILL (
    Student_ID NUMBER,
    skill_id NUMBER,
    PRIMARY KEY (Student_ID, skill_id),
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (skill_id) REFERENCES SKILL(skill_id)
);

CREATE TABLE TEAM_MEMBER (
    Student_ID NUMBER,
    team_id NUMBER,
    role VARCHAR2(50),
    PRIMARY KEY (Student_ID, team_id),
    FOREIGN KEY (Student_ID) REFERENCES STUDENT(Student_ID),
    FOREIGN KEY (team_id) REFERENCES TEAM(team_id)
);

CREATE TABLE TEAM_EVENT (
    team_id NUMBER,
    event_id NUMBER,
    PRIMARY KEY (team_id, event_id),
    FOREIGN KEY (team_id) REFERENCES TEAM(team_id),
    FOREIGN KEY (event_id) REFERENCES EVENT(event_id)
);

-- ==========================
-- SAMPLE INSERTS
-- ==========================

INSERT INTO STUDENT (Student_ID, Name, Email) VALUES
(1, 'Alice Johnson', 'alice@example.com');
INSERT INTO STUDENT (Student_ID, Name, Email) VALUES
(2, 'Bob Smith', 'bob@example.com');
INSERT INTO STUDENT (Student_ID, Name, Email) VALUES
(3, 'Charlie Brown', 'charlie@example.com');

INSERT INTO INTEREST (interest_id, interest_name) VALUES (1, 'Artificial Intelligence');
INSERT INTO INTEREST (interest_id, interest_name) VALUES (2, 'Web Development');
INSERT INTO INTEREST (interest_id, interest_name) VALUES (3, 'Data Science');

INSERT INTO AVAILABILITY (availability_id, day, time_slot, availability_status) VALUES
(1, 'Monday', '10:00-12:00', 'Available');
INSERT INTO AVAILABILITY (availability_id, day, time_slot, availability_status) VALUES
(2, 'Wednesday', '14:00-16:00', 'Available');
INSERT INTO AVAILABILITY (availability_id, day, time_slot, availability_status) VALUES
(3, 'Friday', '09:00-11:00', 'Unavailable');

INSERT INTO SKILL (skill_id, skill_name) VALUES (1, 'Java');
INSERT INTO SKILL (skill_id, skill_name) VALUES (2, 'Python');
INSERT INTO SKILL (skill_id, skill_name) VALUES (3, 'React');

INSERT INTO TEAM (team_id, team_name) VALUES (1, 'Tech Innovators');
INSERT INTO TEAM (team_id, team_name) VALUES (2, 'Data Wizards');

INSERT INTO EVENT (event_id, title, category, max_team_size, deadline) VALUES
(1, 'Hackathon 2025', 'Coding', 4, TO_DATE('2025-09-01', 'YYYY-MM-DD'));
INSERT INTO EVENT (event_id, title, category, max_team_size, deadline) VALUES
(2, 'AI Challenge', 'AI', 3, TO_DATE('2025-10-15', 'YYYY-MM-DD'));

INSERT INTO STUDENT_INTEREST (Student_ID, interest_id) VALUES (1, 1);
INSERT INTO STUDENT_INTEREST (Student_ID, interest_id) VALUES (1, 2);
INSERT INTO STUDENT_INTEREST (Student_ID, interest_id) VALUES (2, 2);
INSERT INTO STUDENT_INTEREST (Student_ID, interest_id) VALUES (3, 3);

INSERT INTO STUDENT_AVAILABILITY (Student_ID, availability_id) VALUES (1, 1);
INSERT INTO STUDENT_AVAILABILITY (Student_ID, availability_id) VALUES (1, 2);
INSERT INTO STUDENT_AVAILABILITY (Student_ID, availability_id) VALUES (2, 2);
INSERT INTO STUDENT_AVAILABILITY (Student_ID, availability_id) VALUES (3, 3);

INSERT INTO STUDENT_SKILL (Student_ID, skill_id) VALUES (1, 1);
INSERT INTO STUDENT_SKILL (Student_ID, skill_id) VALUES (1, 2);
INSERT INTO STUDENT_SKILL (Student_ID, skill_id) VALUES (2, 3);
INSERT INTO STUDENT_SKILL (Student_ID, skill_id) VALUES (3, 2);

INSERT INTO TEAM_MEMBER (Student_ID, team_id, role) VALUES (1, 1, 'Leader');
INSERT INTO TEAM_MEMBER (Student_ID, team_id, role) VALUES (2, 1, 'Developer');
INSERT INTO TEAM_MEMBER (Student_ID, team_id, role) VALUES (3, 2, 'Analyst');

INSERT INTO TEAM_EVENT (team_id, event_id) VALUES (1, 1);
INSERT INTO TEAM_EVENT (team_id, event_id) VALUES (2, 2);

-- ==========================
-- TEAM FORMATION QUERIES
-- ==========================

-- 1. Students with a particular skill (Python)
SELECT s.Student_ID, s.Name, s.Email
FROM STUDENT s
JOIN STUDENT_SKILL ss ON s.Student_ID = ss.Student_ID
JOIN SKILL sk ON ss.skill_id = sk.skill_id
WHERE sk.skill_name = 'Python';

-

-- 3. Students who match required skills (Python, Java, React)
SELECT s.Student_ID, s.Name, sk.skill_name
FROM STUDENT s
JOIN STUDENT_SKILL ss ON s.Student_ID = ss.Student_ID
JOIN SKILL sk ON ss.skill_id = sk.skill_id
WHERE sk.skill_name IN ('Python', 'Java', 'React')
ORDER BY sk.skill_name;



-- 5. Students for an event needing Python and React
SELECT s.Student_ID, s.Name, sk.skill_name
FROM STUDENT s
JOIN STUDENT_SKILL ss ON s.Student_ID = ss.Student_ID
JOIN SKILL sk ON ss.skill_id = sk.skill_id
WHERE sk.skill_name IN ('Python', 'React')
ORDER BY sk.skill_name;


SELECT DISTINCT s.Student_ID, s.Name, s.Email, sk.skill_name, a.day, a.time_slot
FROM STUDENT s
JOIN STUDENT_SKILL ss ON s.Student_ID = ss.Student_ID
JOIN SKILL sk ON ss.skill_id = sk.skill_id
JOIN STUDENT_AVAILABILITY sa ON s.Student_ID = sa.Student_ID
JOIN AVAILABILITY a ON sa.availability_id = a.availability_id
WHERE sk.skill_name IN ('Python', 'React')
  AND a.day = 'Monday'
  AND a.time_slot = '10:00-12:00'
  AND a.availability_status = 'Available'
ORDER BY sk.skill_name, s.Name;