package com.techflow;

import java.util.logging.Level;
import java.util.logging.Logger;

public class ValidationUtils {
    
    // The proper Logger
    private static final Logger LOGGER = Logger.getLogger(ValidationUtils.class.getName());

    // FIX: Private constructor to hide the implicit public one
    private ValidationUtils() {
        throw new IllegalStateException("Utility class");
    }

    public static boolean checkTaskPriority(Task task) {
        
        if (task == null) {
            return false;
        }

        if (task.getId() == null || task.getId().isEmpty()) {
            return false;
        }

        if (task.getAssignee() == null || task.getAssignee().length() <= 2) {
            return false;
        }

        LOGGER.log(Level.INFO, "Task is valid: {0}", task.getId());
        return true;
    } 
}