pipeline {
    agent any

    parameters {

        // stage
        booleanParam(name : 'BUILD_DOCKER_IMAGE', defaultValue : true)
        booleanParam(name : 'PUSH_DOCKER_IMAGE', defaultValue : true)
        booleanParam(name : 'DEPLOY_WORKLOAD', defaultValue : true)

        // CI
        string(name : 'AWS_ACCOUNT_ID', defaultValue : '250832144271')
        string(name : 'DOCKER_IMAGE_NAME', defaultValue : 'cicd-study')
        string(name : 'DOCKER_TAG', defaultValue : '1.0')

        // CD
        string(name : 'TG_SERVER_USER', defaultValue : 'ec2-user')
        string(name : 'TG_SERVER_PATH', defaultValue : '/home/ec2-user/')
        string(name : 'TG_SERVER', defaultValue : '172.31.3.32')
    }

    environment {
        REGION = "ap-northeast-2"
        ECR_REPOSITORY = "${params.AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"
        ECR_DOCKER_IMAGE = "${ECR_REPOSITORY}/${params.DOCKER_IMAGE_NAME}"
        ECR_DOCKER_TAG = "${params.DOCKER_TAG}"
    }

    stages {

        stage('Build Docker Image') {
            when {
                expression { return params.BUILD_DOCKER_IMAGE }
            }
            steps {
                dir("${env.WORKSPACE}") {
                    sh '''
                    aws s3 cp --region ap-northeast-2 --acl private s3://cicd-study-jar-bucket/cicd-jar.zip build/libs/
                    unzip cicd-jar.zip
                    docker build -t ${ECR_DOCKER_IMAGE}:${ECR_DOCKER_TAG} .
                    '''
                }
            }
            post {
                success {
                    echo "Docker Image Build Success"
                }

                failure {
                    echo "Docker Image Build Fail"
                }
            }
        }

        stage('Push Docker Image to ECR') {
            when {
                expression { return params.PUSH_DOCKER_IMAGE }
            }
            steps {
                sh '''
                    aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ECR_REPOSITORY}
                    docker push ${ECR_DOCKER_IMAGE}:${ECR_DOCKER_TAG}
                '''
            }
        }
    }
}