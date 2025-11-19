pipeline {
    agent any
    
    environment {
        FLASK_APP = 'app.py'
        FLASK_ENV = 'development' // Puedes cambiarlo a 'production' si lo deseas
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
        
        // Etapa de pruebas comentada, como la tenías
        /*
        stage('Run Tests') {
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
                    # Detener instancia anterior de gunicorn si existe
                    pkill -f "gunicorn" || true
                    sleep 3 # Espera un poco después de matar procesos anteriores
                    # Iniciar la aplicación en segundo plano usando gunicorn
                    # con nohup y setsid para mayor aislamiento
                    nohup setsid gunicorn --bind 0.0.0.0:8000 --workers 1 app:app \
                      --error-logfile gunicorn_error.log \
                      --access-logfile gunicorn_access.log &
                    # Espera un poco para que inicie
                    sleep 10
                    echo "Aplicación desplegada en http://localhost:8000"
                '''
            }
        }
    }
    
    post {
        always {
            // Archiva los archivos de log relevantes
            archiveArtifacts artifacts: 'app.log, gunicorn_error.log, gunicorn_access.log', allowEmptyArchive: true
        }
    }
}
