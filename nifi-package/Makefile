PACKAGE_NAME=package.zip
S3_BUCKET=z0beat-nifi-packages

clean:
	rm -rf ${PACKAGE_NAME}

package: clean
	zip -r ${PACKAGE_NAME} conf Dockerrun.aws.json Dockerfile

deploy:
	aws --profile sandbox s3 cp package.zip s3://${S3_BUCKET}/package.zip

all: package deploy