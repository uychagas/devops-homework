{{/* vim: set filetype=mustache: */}}
{{/* Expand the name of the chart. */}}
{{- define "rails-app.name" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "rails-app.fullname" -}}
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
{{- define "rails-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Container port names.
*/}}
{{- define "ports.app.name" -}}
http
{{- end -}}

{{/*
Health check parameters.
*/}}
{{- define "rails-app.healthcheck" -}}
initialDelaySeconds: {{ .Values.healthCheck.initialDelaySeconds }}
periodSeconds: {{ .Values.healthCheck.periodSeconds }}
timeoutSeconds: {{ .Values.healthCheck.timeoutSeconds }}
successThreshold: {{ .Values.healthCheck.successThreshold }}
failureThreshold: {{ .Values.healthCheck.failureThreshold }}
{{- end -}}

{{/*
Common annotations.
*/}}
{{- define "rails-app.annotations" -}}
rails/application-name: {{ include "rails-app.name" . }}
rails/application-description: {{ required "Please provide a short description of this application" .Values.appDescription | abbrev 150 | quote }}
rails/deploy-timestamp: '{{ now | unixEpoch }}'
{{- end }}