# Submission Write-up

### Analyze, choose, and justify the appropriate resource option for deploying the app.

The CMS app, which is a lightweight web application built with Flask, does not need a highly customized technology stack to run. It is also straightforward to deploy. Choosing a VM, therefore, would add unnecessary overhead, making the development team responsible for managing the network infrastructure, OS security updates, and so on. By contrast, choosing an app service would allow the development team to focus on maintaining or extending the application itself.

For the moment, the CMS app is designed to work with a single administrator. As such, its needs for scalability and high availability are minimal. Choosing a Linux app service running on the Basic tier with a single B1 instance would more than suffice to meet its current needs. If the app were extended to support different types of content contributors (the most likely reason for ever needing to scale up), the app service option could be scaled either vertically or horizontally. That said, choosing a Linux VM  running on the Basic tier with a single B1 instance could also work. Moreover, the VM option could, if needed, be scaled with either load balancers or virtual machine scale sets. The superior scalability of the VM option, however, would likely be overkill for the CMS app.

The tables below show the estimated breakdown of the costs for the app service option and a comparable VM option. Between the two, the app service option has the lower projected monthly cost.

Overall, because of its simplicity, the CMS app lends itself well to an app service.



#### App Service Option

| Azure Resource          | **Service Tier**                                             | Monthly Cost (USD) |
| ----------------------- | ------------------------------------------------------------ | ------------------ |
| *Azure SQL Database*    | Single Database, DTU Purchase Model, Basic Tier, B: 5 DTUs, 2 GB included storage per DB, 1 Database(s) x 730 Hours, 1 GB Retention | $4.90              |
| *Azure App Service*     | Basic Tier; 1 B1 (1 Core(s), 1.75 GB RAM, 10 GB Storage) x 730 Hours; Linux OS | $13.14             |
| *Azure Storage account* | Block Blob Storage, General Purpose V2, LRS Redundancy, Hot Access Tier, 100 GB Capacity - Pay as you go | $3.23              |
| *Total*                 | Basic and General Purpose                                    | $21.27             |



#### VM Option

| Azure Resource        |                       **Service Tier**                       | Monthly Cost (USD) |
| --------------------- | :----------------------------------------------------------: | ------------------ |
| *Azure SQL Database*  | Single Database, DTU Purchase Model, Basic Tier, B: 5 DTUs, 2 GB included storage per DB, 1 Database(s) x 730 Hours, 1 GB Retention | $4.90              |
| *Azure VM*            | 1 A1 (1 vCPU, 1.75 GB RAM) x 730 Hours (Pay as you go), Linux,  (Pay as you go); 0 managed disks – S4, 100 transaction units; | $22.68             |
| Azure Storage account | Block Blob Storage, General Purpose V2, LRS Redundancy, Hot Access Tier, 100 GB Capacity - Pay as you go | $3.23              |
| *Total*               |                  Basic and General Purpose                   | $30.81             |

### Assess app changes that would change your decision.

- If dedicated servers were needed for security or regulatory reasons, the VM option would likely be the only viable choice. 
- If demand for the content provided by the CMS increased so much that hundreds of new content creators needed to start using the CMS to upload content, the superior scalability of the VM option might justify the additional overhead of managing network infrastructure and so on. 