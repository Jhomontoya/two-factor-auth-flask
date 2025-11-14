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
                    pkill -f "app.py" || true
                    # Iniciar la aplicación en segundo plano, escuchando en todas las interfaces
                    nohup python app.py --host=0.0.0.0 --port=5000 > app.log 2>&1 &
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
