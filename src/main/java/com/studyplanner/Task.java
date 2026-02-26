package com.studyplanner;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Task implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String taskName;
    private LocalDate dueDate;
    private String priority;
    private String status;
    private String category; // e.g., Assignment, Exam, Project

    private LocalDateTime reminderTime;
    private boolean notified;

    // Constructors
    public Task() {}

    public Task(int id, String taskName, LocalDate dueDate, String priority, String status, String category,
                LocalDateTime reminderTime, boolean notified) {
        this.id = id;
        this.taskName = taskName;
        this.dueDate = dueDate;
        this.priority = priority;
        this.status = status;
        this.category = category;
        this.reminderTime = reminderTime;
        this.notified = notified;
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public LocalDateTime getReminderTime() {
        return reminderTime;
    }

    public void setReminderTime(LocalDateTime reminderTime) {
        this.reminderTime = reminderTime;
    }

    public boolean isNotified() {
        return notified;
    }

    public void setNotified(boolean notified) {
        this.notified = notified;
    }
}