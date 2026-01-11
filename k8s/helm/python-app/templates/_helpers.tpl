{{- define "python-app.name" -}}
python-app
{{- end -}}

{{- define "python-app.fullname" -}}
{{ .Release.Name }}
{{- end -}}

{{- define "python-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{ default (include "python-app.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
default
{{- end -}}
{{- end -}}
