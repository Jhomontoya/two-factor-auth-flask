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
                    # Usamos pkill -f "gunicorn" en lugar de pkill -f "app.py" ahora
                    pkill -f "gunicorn" || true
                    sleep 3 # Espera un poco después de matar procesos anteriores
                    # Iniciar la aplicación en segundo plano usando gunicorn (sin nohup por ahora)
                    gunicorn --bind 0.0.0.0:5000 --workers 1 app:app --daemon --error-logfile gunicorn_error.log --access-logfile gunicorn_access.log
                    sleep 10  # Espera 10 segundos para que gunicorn inicie
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
