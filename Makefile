CHART_PATH = ./akka-operator
CHART_DESTINATION_PATH = ./charts
VERSION ?= "dev"

chart:
	yq e ".image.tag = \"${VERSION}\"" akka-operator/values.yaml
	yq e ".version = \"${VERSION}\"" akka-operator/Chart.yaml
	yq e ".appVersion = \"${VERSION}\"" akka-operator/Chart.yaml
	helm package $(CHART_PATH) -d $(CHART_DESTINATION_PATH)
