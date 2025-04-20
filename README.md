# Cloud Resume Challenge



### Overview  

Create a cloud-hosted resume as the frontend of the application. You can find my [resume](https://anupamadhir.com) here.
I used HTML and CSS to build a responsive web page and hosted it in an S3 bucket as a static website behind a CloudFront(CDN) distribution.
I bought the domain name from Namecheap and used Amazon Certificate Manager to generate an SSL certificate to enable https on my website.
I setup Amazon Route 53 as the DNS provider and setup the alias records to point to the CloudFront Distribution.I have setup CloudFront cache invalidation.  

## Features

Website Hosting: A resume website hosted in an S3 bucket and distributed globally through CloudFront with Origin Access Control (OAC).
Custom Domain: Route 53 manages domain name configurations.
Visitor Tracking: Tracks website visitors using a serverless backend with REST API Gateway, Lambda, and DynamoDB.
Infrastructure as Code: Utilizes Terraform to provision and manage AWS resources.  

## Project Architecture

![](.idea/images/Terraform-3.drawio.png)


## Project Structure:

    .
    ├── README.md
    ├── frontend
    │   ├── index2.html
    │   ├── index2.js
    │   └── style2.css
    ├── terraform
    │   ├── main.tf
    │   ├── modules
    │   │   ├── backend
    │   │   │   ├── apigateway.tf
    │   │   │   ├── dynamodb.tf
    │   │   │   ├── lambda
    │   │   │   │   ├── lambda_function.py
    │   │   │   │   ├── lambda_function.zip
    │   │   │   │   ├── update_count.py
    │   │   │   │   └── update_count.zip
    │   │   │   └── lambda.tf
    │   │   └── frontend
    │   │       ├── bucketpolicy.tf
    │   │       ├── cloudfront.tf
    │   │       ├── s3.tf
    │   │       └── variables.tf
 
    7 directories, 19 files




### Explanation of Directories and Files:

- **frontend/**: Contains the website files
  * index2.html: Main HTML file for the website  
  * script2.js: Javascript file for interacting with API  
  * style2.css: Stylesheet for website  
- **terraform/**: Contains Terraform configuration files for provisioning AWS resources.  
   * main.tf: Contains the main set of configuration for the modules. It also contains the AWS provider settings.
   * modules/:  
     * backend/: Provisions REST API Gateway, DynamoDB, and Lambda for visitor tracking. The Lambda function updates and fetches visitor counts from the DynamoDB table.
     * frontend/: Provisions S3, CloudFront and Cloudfront cloud invalidation
   
## Implementation Details:
1. **Website Hosting**  
    **Technology:** S3 and CloudFront  
    **Details:** The website is hosted in an S3 bucket and delivered globally using CloudFront(CDN) with Origin Access Control (OAC).  

2. **Visitor Tracking**
   **Technology:** REST API Gateway, Lambda, DynamoDB  
   **Details:**  
   * API Gateway triggers the Lambda function.  
   * The Lambda function updates the visitor count in a DynamoDB table and fetches the count for display.
   
3. **Infrastructure as Code (IaC)**
   **Technology:** Terraform  
   **Details:** All resources are managed as code, enabling version control and consistency across different environments.

<br>

## Future Improvements
1. Include a CI/CD pipeline using GitHub Actions to automate the deployment of website updates.

<br>
