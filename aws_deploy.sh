aws ecs update-service --cluster cluster --service frontend --force-new-deployment --no-verify-ssl
aws ecs update-service --cluster cluster --service producer --force-new-deployment --no-verify-ssl
aws ecs update-service --cluster cluster --service consumer --force-new-deployment --no-verify-ssl
aws ecs update-service --cluster cluster --service stock --force-new-deployment --no-verify-ssl