-- Tworzenie tabeli użytkowników
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    RoleID INT,
    TermsOfServiceAccepted BOOLEAN NOT NULL,
    IsConfirmed BOOLEAN NOT NULL,
    CreateDate DATETIME NOT NULL
);

-- Tworzenie tabeli ról
CREATE TABLE Roles (
    RoleID INT AUTO_INCREMENT PRIMARY KEY,
    RoleName VARCHAR(255) NOT NULL
);

-- Dodanie klucza obcego do tabeli użytkowników (relacja użytkownik-rola)
ALTER TABLE Users ADD CONSTRAINT fk_user_role FOREIGN KEY (RoleID) REFERENCES Roles(RoleID);

-- Tworzenie tabeli kursów
CREATE TABLE Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(255) NOT NULL,
    Description TEXT NOT NULL
);

-- Tworzenie tabeli etapów kursu
CREATE TABLE CourseStages (
    StageID INT AUTO_INCREMENT PRIMARY KEY,
    CourseID INT,
    StageName VARCHAR(255) NOT NULL,
    Description TEXT NOT NULL,
    `Order` INT NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- Tworzenie tabeli notatek
CREATE TABLE Notes (
    NoteID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Title VARCHAR(255) NOT NULL,
    Content TEXT NOT NULL,
    CreateDate DATETIME NOT NULL,
    LastModifiedDate DATETIME NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Tworzenie tabeli quizów
CREATE TABLE Quizzes (
    QuizID INT AUTO_INCREMENT PRIMARY KEY,
    StageID INT,
    QuizName VARCHAR(255) NOT NULL,
    TimeLimit INT NOT NULL,
    FOREIGN KEY (StageID) REFERENCES CourseStages(StageID)
);

-- Tworzenie tabeli pytań quizu
CREATE TABLE QuizQuestions (
    QuestionID INT AUTO_INCREMENT PRIMARY KEY,
    QuizID INT,
    QuestionText TEXT NOT NULL,
    CorrectAnswer VARCHAR(255),
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID)
);

-- Tworzenie tabeli odpowiedzi quizu
CREATE TABLE QuizAnswers (
    AnswerID INT AUTO_INCREMENT PRIMARY KEY,
    QuestionID INT,
    AnswerText TEXT NOT NULL,
    IsCorrect BOOLEAN NOT NULL,
    FOREIGN KEY (QuestionID) REFERENCES QuizQuestions(QuestionID)
);

-- Tworzenie tabeli wyników quizów
CREATE TABLE QuizResults (
    ResultID INT AUTO_INCREMENT PRIMARY KEY,
    QuizID INT,
    UserID INT,
    Score INT NOT NULL,
    CompletionDate DATETIME NOT NULL,
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
