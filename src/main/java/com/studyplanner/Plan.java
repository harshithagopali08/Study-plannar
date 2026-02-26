package com.studyplanner;

public class Plan {
    private String subject;
    private String topic;
    private int plannedHours;

    public Plan(String subject, String topic, int plannedHours) {
        this.subject = subject;
        this.topic = topic;
        this.plannedHours = plannedHours;
    }

    public String getSubject() {
        return subject;
    }

    public String getTopic() {
        return topic;
    }

    public int getPlannedHours() {
        return plannedHours;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public void setPlannedHours(int plannedHours) {
        this.plannedHours = plannedHours;
    }
}
