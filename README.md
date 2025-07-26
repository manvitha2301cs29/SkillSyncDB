# 🧑‍💻 Student-Team-Event Management System

## 📋 Overview
This project implements a **relational database schema** to manage students, their interests, skills, availability, team membership, and participation in events such as hackathons or coding challenges.

It includes:
- Table creation scripts with primary and foreign key constraints
- Sample data inserts for testing
- Useful queries to extract meaningful information (e.g., team formation based on skills and availability)

---

## 🗃️ Database Schema

### 🧑 STUDENT
Stores basic student information.
| Column Name | Data Type     | Description         |
|-------------|---------------|---------------------|
| Student_ID  | NUMBER (PK)   | Unique student ID   |
| Name        | VARCHAR2(100) | Full name           |
| Email       | VARCHAR2(100) | Email address       |

---

### 📚 INTEREST
Defines areas of interest.
| Column Name   | Data Type     | Description     |
|---------------|---------------|-----------------|
| interest_id   | NUMBER (PK)   | Unique ID       |
| interest_name | VARCHAR2(100) | Interest name   |

---

### 📅 AVAILABILITY
Defines time slots and availability status.
| Column Name         | Data Type     | Description                     |
|---------------------|---------------|---------------------------------|
| availability_id     | NUMBER (PK)   | Unique ID                       |
| day                 | VARCHAR2(20)  | Day of the week                 |
| time_slot           | VARCHAR2(50)  | Time slot (e.g., 10:00-12:00)   |
| availability_status | VARCHAR2(20)  | Available or Unavailable        |

---

### 💼 SKILL
Defines technical skills.
| Column Name | Data Type     | Description       |
|-------------|---------------|-------------------|
| skill_id    | NUMBER (PK)   | Unique skill ID   |
| skill_name  | VARCHAR2(100) | Skill name        |

---

### 👥 TEAM
Represents student project teams.
| Column Name | Data Type     | Description     |
|-------------|---------------|-----------------|
| team_id     | NUMBER (PK)   | Unique team ID  |
| team_name   | VARCHAR2(100) | Team name       |

---

### 🏆 EVENT
Represents competitive or academic events.
| Column Name   | Data Type     | Description              |
|---------------|---------------|--------------------------|
| event_id      | NUMBER (PK)   | Unique event ID          |
| title         | VARCHAR2(100) | Event name               |
| category      | VARCHAR2(50)  | e.g., Coding, AI         |
| max_team_size | NUMBER        | Max members per team     |
| deadline      | DATE          | Registration deadline    |

---

## 🔗 Relationship Tables

### STUDENT_INTEREST
Many-to-many between students and interests.

### STUDENT_AVAILABILITY
Many-to-many between students and available time slots.

### STUDENT_SKILL
Many-to-many between students and their skills.

### TEAM_MEMBER
Many-to-many between students and teams with an assigned role.

### TEAM_EVENT
Many-to-many between teams and the events they are participating in.

---

## 📥 Sample Data
The SQL script inserts test data for:
- 3 students
- 3 interests
- 3 availability slots
- 3 skills
- 2 teams
- 2 events
- Mappings for skills, interests, availability, team roles, and event participation

---

## 🔍 Useful Queries

### 1. Students with a particular skill (e.g., Python)
```sql
SELECT s.Student_ID, s.Name, s.Email
FROM STUDENT s
JOIN STUDENT_SKILL ss ON s.Student_ID = ss.Student_ID
JOIN SKILL sk ON ss.skill_id = sk.skill_id
WHERE sk.skill_name = 'Python';
