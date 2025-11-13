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
                    url: 'https://github.com/miguelgrinberg/two-factor-auth-flask.git'
            }
        }
        
        stage('Setup Virtual Environment') {
            steps {
                sh 'python3 -m venv venv'
                sh 'source venv/bin/activate && pip install --upgrade pip'
                sh 'source venv/bin/activate && pip install -r requirements.txt'
            }
        }
        
        stage('Run Tests') {
            steps {
                sh 'source venv/bin/activate && python -m pytest tests/ -v'
            }
        }
        
        stage('Deploy Application') {
            steps {
                sh '''
                    source venv/bin/activate
                    # Detener instancia anterior si existe
                    pkill -f "app.py" || true
                    # Iniciar la aplicación en segundo plano
                    nohup python app.py > app.log 2>&1 &
                    sleep 5
                    echo "Aplicación desplegada en http://localhost:5000"
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
