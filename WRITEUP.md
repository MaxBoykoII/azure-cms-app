# Submission Write-up

### Analyze, choose, and justify the appropriate resource option for deploying the app.

The CMS app, which is a lightweight web application built with Flask, does not need a highly customized technology stack to run. It is also straightforward to deploy. Choosing a VM, therefore, would add unnecessary overhead, making the development team responsible for managing the network infrastructure, OS security updates, and so on. By contrast, choosing an app service would allow the development team to focus on maintaining or extending the application itself.

For the moment, the CMS app is designed to work with a single administrator. As such, its needs for scalability and high availability are minimal. Choosing a Linux app service running on the Basic tier with a single B1 instance would more than suffice to meet the needs of a CMS app. If the app were extended to support different types of content contributors (the most likely reason for ever needing to scale up), the app service option could be scaled either vertically or horizontally. That said, choosing a Linux VM  running on the Basic tier with a single B1 instance could also work. Moreover, the VM option could, if needed, be scaled with either load balancers or virtual machine scale sets. The superior scalability of the VM option, however, would likely be overkill for the CMS app.

According to the Azure Pricing Calculator, the VM configuration given above is only slightly cheaper than the  proposed app service configuration. When the additional overhead of allocating developer time to manage the VM is accounted for, the app service is likely the cheaper option.

Overall, because of its simplicity, the CMS app lends itself well to an app service.



### Assess app changes that would change your decision.

- If dedicated servers were needed for security or regulatory reasons, the VM option would likely be the only viable choice. 
- If demand for the content provided by the CMS increased so much that hundreds of new content creators needed to start using the CMS to upload content, the superior scalability of the VM option might justify the additional overhead of managing network infrastructure and so on. 