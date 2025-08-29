package com.bajaj.service;

import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SqlProblemSolver {

    public String solveProblem(String questionType) {
        log.info("Solving SQL problem for question type: {}", questionType);
        
        if ("ODD".equals(questionType)) {
            return solveQuestion1();
        } else if ("EVEN".equals(questionType)) {
            return solveQuestion2();
        } else {
            log.error("Unknown question type: {}", questionType);
            return "SELECT 'ERROR: Unknown question type' as result";
        }
    }

    private String solveQuestion1() {
        // Question 1: Based on the Google Drive link provided
        // This is a placeholder - you would need to implement the actual solution
        // based on the specific SQL problem in the document
        return """
            SELECT 
                e.employee_id,
                e.first_name,
                e.last_name,
                e.salary,
                d.department_name
            FROM employees e
            JOIN departments d ON e.department_id = d.department_id
            WHERE e.salary > (
                SELECT AVG(salary) 
                FROM employees 
                WHERE department_id = e.department_id
            )
            ORDER BY e.salary DESC;
            """;
    }

    private String solveQuestion2() {
        // Question 2: Based on the Google Drive link provided
        // This is a placeholder - you would need to implement the actual solution
        // based on the specific SQL problem in the document
        return """
            SELECT 
                c.customer_id,
                c.customer_name,
                COUNT(o.order_id) as total_orders,
                SUM(o.total_amount) as total_spent
            FROM customers c
            LEFT JOIN orders o ON c.customer_id = o.customer_id
            WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
            GROUP BY c.customer_id, c.customer_name
            HAVING total_orders > 0
            ORDER BY total_spent DESC;
            """;
    }
}
