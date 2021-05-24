Platform
    Use AWS EKS for managing the app. Deploy the AWS EKS in a Private subnet. One Subnet per AZ. Its fully managed API/Control Pane Service by AWS.
    Use the Terraform Resource to create EKS (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)

DB Setup  (DB Tier)
    Use RDS for managing PostgreSQLs. The benefits are Managed Service,Highly Available and less Maintenance. This can be created using Terraform Resource (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance)
    Use Multi AZ for  High Availability. Can Leverage Read replicas for frequently read data. Can be promoted to Master as well but 
    not recommended.
    Separate out the database update part from the App itself as decoupling of functionality will help if there are issues reported 
    in one of the functions the rest of the app can run without issues (Loosely coupled Application).
    For Running create the database, tables, and seed with test data. Use Job resource in Kubernetes(https://kubernetes.io/docs/concepts/workloads/controllers/job/) which can be created and run through
    a pipe as and when the need arises. The sample code is given in the same repo. job.yaml.
    Separate out DB config from the code so that it can be independently managed using a config map. This will ease out the process of building 
    an whole app when only config/property is changed. Creation of config map can be piped separately and the config can be mounted as a volume 
    on deployment/job/etc. This helps us with Segregating the Environments easily 
    The code for DB needs to altered so that DB username and Password can be picked from Environment variable instead of a file as it brings issue with
    storing password in the file. With the Environment variable we can inject them as kubernetes secrets. For more secure way the same username and password
    can be stored in AWS Secret Manager and then can be fetched into the Cluster using Kubernetes external Secrets (https://github.com/external-secrets/kubernetes-external-secrets) this allows an easy and secure way of 
    managing critical data. The entire file can also be created as secret and then mounted as volume then there is no need for creating a Config Map.


App Setup (Deployed on Platform EKS in Private Tier)
    Use Deployment Spec for Creating and Deploying an Application onto Kubernetes Cluster. It will manage the state of the Application
    and will make sure the app is available 24*7.
    Sample Deployment Spec is given in the repo(deploy.yaml). Replication controller will make sure the set number of pod/workload of application 
    are available all the time. Scheduler will make sure that the pod is scheduled on the node and will also make sure that it is moved from one node to 
    another if there are any underlying issues.
    App should only host the API as mentioned in the above section. Set proper readiness and liveness probe so that the app is always available and API Server
    checks the status of the app.
    Segregate the Apps per namespaces and limit the resources per app and per namespaces.
    App can be externally access using a Ingress Resource or Gateway(Istio) which actually is an AWS ELB/ALB/NLB and then by Creating an entry in R53 Hosted Zone 
    to point to that LoadBalancer.


Deploy Files are present under Kubernetes Folder