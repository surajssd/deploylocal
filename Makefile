.PHONY: start-openshift
start-openshift:
	./start-openshift.sh

.PHONY: stop-openshift
stop-openshift:
	oc cluster down


.PHONY: wit-build-deploy
wit-build-deploy: login
	./wit-build.sh

.PHONY: wit-deploy-complete
wit-deploy-complete:
	./wit-deploy.sh

.PHONY: wit-undeploy
wit-undeploy: login
	oc delete project wit-dep

.PHONY: wit-create-spaces
wit-create-spaces:
	./wit-create-spaces.sh

.PHONY: sentry-deploy
sentry-deploy: login
	./sentry-deploy.sh

.PHONY: sentry-undeploy
sentry-undeploy: login
	oc delete project sentry

.PHONY: login
login:
	oc login -u developer -p developer

.PHONY: tenant-deploy
tenant-deploy: login
	./tenant-deploy.sh

.PHONY: tenant-undeploy
tenant-undeploy: login
	oc delete project tenant-dep

.PHONY: tenant-build-deploy
tenant-build-deploy: login
	./tenant-build.sh

.PHONY: prometheus-deploy
prometheus-deploy: login
	./prometheus-deploy.sh

.PHONY: prometheus-undeploy
prometheus-undeploy:
	kedge delete -f prometheus/prometheus.yml
