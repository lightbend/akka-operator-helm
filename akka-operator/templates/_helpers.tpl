{{/*
Expand the name of the chart.
*/}}
{{- define "akka-operator.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "akka-operator.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "akka-operator.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "akka-operator.labels" -}}
helm.sh/chart: {{ include "akka-operator.chart" . }}
{{ include "akka-operator.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "akka-operator.selectorLabels" -}}
app.kubernetes.io/name: {{ include "akka-operator.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "akka-operator.serviceAccountName" -}}

{{- if .Values.serviceAccount.name }}
{{- .Values.serviceAccount.name }}
{{- else }}
{{- default (include "akka-operator.fullname" .) .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
Create the configjson for a secret with the lightbend commercial credentials
*/}}
{{- define "imagePullSubscriptionSecret" }}
{{- if .Values.lightbendSubscription.username }}
{{- printf "{\"auths\": {\"%s\": {\"auth\": \"%s\"}}}" .Values.lightbendSubscription.registry (printf "%s:%s" .Values.lightbendSubscription.username .Values.lightbendSubscription.password | b64enc) | b64enc }}
{{- end }}
{{- end }}
