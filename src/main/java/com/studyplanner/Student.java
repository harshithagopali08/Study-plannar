package com.studyplanner;

public class Student {
    private int id;
    private String username;
    private String email;
    private int progress;
    private String upcomingExamSubject;
    private String upcomingExamDate;

    public Student(int id, String username, String email) {
        this.id = id;
        this.username = username;
        this.email = email;
    }

    // Getters
    public int getId() { return id; }
    public String getUsername() { return username; }
    public String getEmail() { return email; }
    public int getProgress() { return progress; }
    public String getUpcomingExamSubject() { return upcomingExamSubject; }
    public String getUpcomingExamDate() { return upcomingExamDate; }

    // Setters
    public void setProgress(int progress) {
        this.progress = progress;
    }

    public void setUpcomingExamSubject(String subject) {
        this.upcomingExamSubject = subject;
    }

    public void setUpcomingExamDate(String date) {
        this.upcomingExamDate = date;
    }
}
