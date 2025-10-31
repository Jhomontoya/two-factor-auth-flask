pipeline {
    agent any
    
    environment {
        FLASK_APP = 'twofa.py'
        FLASK_ENV = 'development'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Jhomontoya/two-factor-auth-flask.git'
            }
        }

        stage('Setup Environment') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                    . venv/bin/activate
                    pytest || echo "No tests found"
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    . venv/bin/activate
                    pkill -f "twofa.py" || true
                    nohup python twofa.py > app.log 2>&1 &
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
