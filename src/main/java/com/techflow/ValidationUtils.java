package com.techflow;

public class ValidationUtils {
    
    // SonarQube Trap: Hardcoded password/security hotspot
    public static String dbAdminPassword = "admin_root_password_123!"; 

    public static boolean checkTaskPriority(Task task) {
        // SonarQube Trap: Unused variable
        int dummyCounter = 42; 
        
        // SonarQube Trap: High Cognitive Complexity (Deeply nested logic)
        if (task != null) {
            if (task.getId() != null) {
                if (!task.getId().isEmpty()) {
                    if (task.getAssignee() != null) {
                        if (task.getAssignee().length() > 2) {
                            // SonarQube Trap: Use of System.out instead of a proper Logger
                            System.out.println("Task is valid: " + task.getId());
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }