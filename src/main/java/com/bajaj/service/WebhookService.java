package com.bajaj.service;

import com.bajaj.dto.WebhookRequest;
import com.bajaj.dto.WebhookResponse;
import com.bajaj.dto.SolutionRequest;
import com.bajaj.entity.Solution;
import com.bajaj.repository.SolutionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import lombok.extern.slf4j.Slf4j;
import java.time.LocalDateTime;

@Service
@Slf4j
public class WebhookService {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private SolutionRepository solutionRepository;

    @Autowired
    private SqlProblemSolver sqlProblemSolver;

    private static final String WEBHOOK_GENERATION_URL = "https://bfhldevapigw.healthrx.co.in/hiring/generateWebhook/JAVA";
    private static final String SOLUTION_SUBMISSION_URL = "https://bfhldevapigw.healthrx.co.in/hiring/testWebhook/JAVA";

    public void executeWebhookFlow() {
        try {
            log.info("Starting webhook flow execution...");
            
            // Step 1: Generate webhook
            WebhookResponse webhookResponse = generateWebhook();
            if (webhookResponse == null) {
                log.error("Failed to generate webhook. Exiting flow.");
                return;
            }
            
            log.info("Webhook generated successfully. URL: {}", webhookResponse.getWebhook());
            
            // Step 2: Solve SQL problem based on regNo
            String regNo = "REG12347"; // From the example in requirements
            String questionType = determineQuestionType(regNo);
            log.info("Question type determined: {} for regNo: {}", questionType, regNo);
            
            String sqlSolution = sqlProblemSolver.solveProblem(questionType);
            log.info("SQL solution generated for question type: {}", questionType);
            
            // Step 3: Store solution in database
            Solution solution = new Solution();
            solution.setRegNo(regNo);
            solution.setQuestionType(questionType);
            solution.setSqlQuery(sqlSolution);
            solution.setSubmittedAt(LocalDateTime.now());
            solution.setWebhookUrl(webhookResponse.getWebhook());
            solution.setStatus("PENDING");
            
            solutionRepository.save(solution);
            log.info("Solution saved to database with ID: {}", solution.getId());
            
            // Step 4: Submit solution via webhook
            boolean submissionSuccess = submitSolution(webhookResponse.getAccessToken(), sqlSolution);
            
            if (submissionSuccess) {
                solution.setStatus("SUBMITTED");
                solutionRepository.save(solution);
                log.info("Solution submitted successfully via webhook");
            } else {
                solution.setStatus("FAILED");
                solutionRepository.save(solution);
                log.error("Failed to submit solution via webhook");
            }
            
        } catch (Exception e) {
            log.error("Error during webhook flow execution", e);
        }
    }

    private WebhookResponse generateWebhook() {
        try {
            WebhookRequest request = new WebhookRequest();
            request.setName("John Doe");
            request.setRegNo("REG12347");
            request.setEmail("john@example.com");

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            HttpEntity<WebhookRequest> entity = new HttpEntity<>(request, headers);

            ResponseEntity<WebhookResponse> response = restTemplate.postForEntity(
                WEBHOOK_GENERATION_URL, entity, WebhookResponse.class);

            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                return response.getBody();
            } else {
                log.error("Failed to generate webhook. Status: {}", response.getStatusCode());
                return null;
            }
        } catch (Exception e) {
            log.error("Exception while generating webhook", e);
            return null;
        }
    }

    private String determineQuestionType(String regNo) {
        // Extract last two digits
        String lastTwoDigits = regNo.substring(regNo.length() - 2);
        int lastTwoDigitsInt = Integer.parseInt(lastTwoDigits);
        
        if (lastTwoDigitsInt % 2 == 0) {
            return "EVEN"; // Question 2
        } else {
            return "ODD";  // Question 1
        }
    }

    private boolean submitSolution(String accessToken, String sqlQuery) {
        try {
            SolutionRequest request = new SolutionRequest();
            request.setFinalQuery(sqlQuery);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setBearerAuth(accessToken);

            HttpEntity<SolutionRequest> entity = new HttpEntity<>(request, headers);

            ResponseEntity<String> response = restTemplate.postForEntity(
                SOLUTION_SUBMISSION_URL, entity, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                log.info("Solution submitted successfully. Response: {}", response.getBody());
                return true;
            } else {
                log.error("Failed to submit solution. Status: {}", response.getStatusCode());
                return false;
            }
        } catch (Exception e) {
            log.error("Exception while submitting solution", e);
            return false;
        }
    }
}
