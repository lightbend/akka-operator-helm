CHART_PATH = ./akka-operator
CHART_DESTINATION_PATH = ./charts

VERSION ?= "dev"

chart:
	mkdir -p $(CHART_DESTINATION_PATH)
	yq e -i ".image.tag = \"${VERSION}\"" akka-operator/values.yaml
	yq e -i ".version = \"${VERSION}\"" akka-operator/Chart.yaml
	yq e -i ".appVersion = \"${VERSION}\"" akka-operator/Chart.yaml
	helm package $(CHART_PATH) -d $(CHART_DESTINATION_PATH)
	helm repo index .
