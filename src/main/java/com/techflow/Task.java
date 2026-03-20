package com.techflow;

public class Task {
    private String id;
    private String description;
    private String assignee;

    public Task(String id, String description, String assignee) {
        this.id = id;
        this.description = description;
        this.assignee = assignee;
    }

    public String getId() { return id; }
    public String getDescription() { return description; }
    public String getAssignee() { return assignee; }
}