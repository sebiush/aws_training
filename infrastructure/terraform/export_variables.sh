ARTIFACTORY_USERNAME=mpetla@gmail.com
ARTIFACTORY_PASSWORD=$(cat ~/TOKEN.txt)

export TF_VAR_artifactory_secret="{\"username\": \"${ARTIFACTORY_USERNAME}\",\"password\":\"${ARTIFACTORY_PASSWORD}\"}"