# workspace scripts
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION}  as workspace-scripts

# COPY Sift Left Security
COPY    shift-left    /workspaces/shift-left

# COPY Automator & Tests
COPY    automator     /workspaces/automator
COPY    tests         /workspaces/tests

# COPY version.txt
COPY    version.txt   /workspaces

RUN find \
		"/workspaces/automator/"  \
		"/workspaces/shift-left/" \
		"/workspaces/tests" \
		"/workspaces/version.txt" \
		-type f -print0 \
	| sort -z | xargs -r0 sha256sum | sha256sum | awk '{print $1}' > /workspaces/signature.txt
