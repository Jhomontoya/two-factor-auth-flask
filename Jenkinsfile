pipeline {
    agent any
    
    environment {
        FLASK_APP = 'app.py'
        FLASK_ENV = 'development'
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/Jhomontoya/two-factor-auth-flask.git'
            }
        }
        
        stage('Setup Virtual Environment') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }
        
        /*stage('Run Tests') {
            steps {
                sh '''
                    . venv/bin/activate
                    python -m pytest tests/ -v
                '''
            }
        }
        */
        
        stage('Deploy Application') {
            steps {
                sh '''
                    . venv/bin/activate
                    # Detener instancia anterior si existe
                    pkill -f "gunicorn" || true
                    sleep 3 # Espera un poco después de matar procesos anteriores
                    # Iniciar la aplicación en segundo plano usando gunicorn con nohup y setsid
                    # setsid crea una nueva sesión, aislándolo aún más del proceso Jenkins
                    nohup setsid gunicorn --bind 0.0.0.0:8000 --workers 1 app:app --error-logfile gunicorn_error.log --access-logfile gunicorn_access.log &
                    # Espera un poco para que inicie
                    sleep 10
                    echo "Aplicación desplegada en http://localhost:8000"
                '''
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'app.log', allowEmptyArchive: true
        }
    }
}
