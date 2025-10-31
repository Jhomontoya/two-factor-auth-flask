pipeline {
    agent any

    environment {
        APP_NAME = 'twofa-flask'
        DOCKER_IMAGE = 'twofa-flask-image'
        CONTAINER_NAME = 'twofa-flask-container'
        FLASK_PORT = '5000'
    }

    stages {
        stage('Clonar Repositorio') {
            steps {
                git branch: 'main', url: 'https://github.com/Jhomontoya/two-factor-auth-flask.git'
            }
        }

        stage('Construir Imagen Docker') {
            steps {
                script {
                    sh '''
                        echo "Construyendo imagen Docker..."
                        docker build -t ${DOCKER_IMAGE} .
                    '''
                }
            }
        }

        stage('Desplegar Contenedor') {
            steps {
                script {
                    sh '''
                        echo "Eliminando contenedor previo (si existe)..."
                        docker rm -f ${CONTAINER_NAME} || true

                        echo "Ejecutando contenedor..."
                        docker run -d --name ${CONTAINER_NAME} -p ${FLASK_PORT}:5000 ${DOCKER_IMAGE}

                        sleep 5
                        echo "Verificando contenedor..."
                        docker ps | grep ${CONTAINER_NAME}
                    '''
                }
            }
        }

        stage('Verificar Aplicación') {
            steps {
                script {
                    sh '''
                        echo "Probando si el servicio responde..."
                        curl -I http://localhost:${FLASK_PORT} || true
                    '''
                }
            }
        }
    }

    post {
        success {
            echo "✅ Despliegue exitoso: aplicación Flask disponible en http://localhost:${FLASK_PORT}"
        }
        failure {
            echo "❌ Error en el pipeline. Revisa los logs."
        }
        always {
            script {
                sh '''
                    echo "Guardando logs del contenedor..."
                    docker logs ${CONTAINER_NAME} > app.log || true
                '''
            }
            archiveArtifacts artifacts: 'app.log', allowEmptyArchive: true
        }
    }
}
