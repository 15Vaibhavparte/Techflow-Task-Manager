package com.techflow;

import java.util.logging.Level;
import java.util.logging.Logger;

public class ValidationUtils {
    
    // Fix 1: Replaced System.out.println with a proper Logger
    private static final Logger LOGGER = Logger.getLogger(ValidationUtils.class.getName());

    // Fix 2: The hardcoded dbAdminPassword has been completely removed to close the Security Hotspot.

    public static boolean checkTaskPriority(Task task) {
        
        // Fix 3: The unused 'dummyCounter' variable has been removed.

        // Fix 4: Flattened the nested 'if' statements to fix "High Cognitive Complexity"
        if (task == null) {
            return false;
        }

        if (task.getId() == null || task.getId().isEmpty()) {
            return false;
        }

        if (task.getAssignee() == null || task.getAssignee().length() <= 2) {
            return false;
        }

        // Using the secure logger to output information
        LOGGER.log(Level.INFO, "Task is valid: {0}", task.getId());
        return true;
    }
}
