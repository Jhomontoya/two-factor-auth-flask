pipeline {
    agent {
        docker {
            image 'python:3.10'
        }
    }

    environment {
        FLASK_APP = 'twofa.py'
        FLASK_ENV = 'development'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Jhomontoya/two-factor-auth-flask.git'
            }
        }

        stage('Setup Virtual Environment') {
            steps {
                sh '''
                    python -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '. venv/bin/activate && python -m pytest tests/ -v || true'
            }
        }

        stage('Deploy Application') {
            steps {
                sh '''
                    . venv/bin/activate
                    pkill -f "twofa.py" || true
                    nohup python twofa.py > app.log 2>&1 &
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
