pipeline {
    agent any

    triggers {
        pollSCM('H/5 * * * *')   // Poll every 5 minutes
    }

    stages {
        stage('Checkout PR Branches') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: '**']],  // Fetch all branches
                    doGenerateSubmoduleConfigurations: false,
                    extensions: [
                        [$class: 'PruneStaleBranch'],
                        [$class: 'CleanCheckout']
                    ],
                    userRemoteConfigs: [[
                        url: 'https://github.com/ahmedfathi1928/master_1.git',
                        refspec: '+refs/pull/*:refs/remotes/origin/pr/*'
                    ]]
                ])
            }
        }

        stage('Setup Python Environment') {
            steps {
                sh '''
                python3 -m venv venv
                source venv/bin/activate
                pip install --upgrade pip
                pip install pytest   # ✅ just install pytest for tests
                '''
            }
        }

        stage('Run Tests') {
            steps {
                sh '''
                source venv/bin/activate
                pytest --maxfail=1 --disable-warnings -q
                '''
            }
        }
    }
}
