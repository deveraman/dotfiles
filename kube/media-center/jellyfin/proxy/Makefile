# Copyright (c) Tailscale Inc & AUTHORS
# SPDX-License-Identifier: BSD-3-Clause

SA_NAME ?= tailscale
TS_KUBE_SECRET ?= tailscale

rbac:
	@sed -e "s;{{TS_KUBE_SECRET}};$(TS_KUBE_SECRET);g" role.yaml
	@echo "---"
	@sed -e "s;{{SA_NAME}};$(SA_NAME);g" rolebinding.yaml
	@echo "---"
	@sed -e "s;{{SA_NAME}};$(SA_NAME);g" sa.yaml

proxy:
	@sed -e "s;{{TS_KUBE_SECRET}};$(TS_KUBE_SECRET);g" proxy.yaml | sed -e "s;{{SA_NAME}};$(SA_NAME);g" | sed -e "s;{{TS_DEST_IP}};$(TS_DEST_IP);g"
