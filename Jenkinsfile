def containerName="springbootdocker"
def tag="latest"
def dockerHubUser="anujsharma1990"
def gitURL="https://github.com/anujdevopslearn/SpringBootDocker.git"

node {
	def sonarscanner = tool name: 'SonarQubeScanner', type: 'hudson.plugins.sonar.SonarRunnerInstallation'
    stage('Checkout') {
        checkout changelog: false, poll: false, scm: [$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: gitURL]]]
    }

    stage('Build'){
        sh "mvn clean install"
    }

    stage("Image Prune"){
         sh "docker image prune -f"
    }

    stage('Image Build'){
        sh "docker build -t $containerName:$tag --pull --no-cache ."
        echo "Image build complete"
    }

    stage('Push to Docker Registry'){
        withCredentials([usernamePassword(credentialsId: 'dockerHubAccount', usernameVariable: 'dockerUser', passwordVariable: 'dockerPassword')]) {
            sh "docker login -u $dockerUser -p $dockerPassword"
            sh "docker tag $containerName:$tag $dockerUser/$containerName:$tag"
            sh "docker push $dockerUser/$containerName:$tag"
            echo "Image push complete"
        }
    }
	
	stage("SonarQube Scan"){
        /*withSonarQubeEnv(credentialsId: 'SonarQubeToken') {
			sh "${sonarscanner}/bin/sonar-scanner"
		}*/
    }
	node("kubernetes"){
		stage("Kubernetes Deploy"){
	     	   sh """
	  		alias kubectl="minikube kubectl --"
			kubectl get pods
   			kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=$dockerHubUser/$containerName:$tag
   		"""
	    }
	}
}
