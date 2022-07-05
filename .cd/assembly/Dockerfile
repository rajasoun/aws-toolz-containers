# aws-toolz
ARG BASE_IMAGE
ARG VERSION
FROM ${BASE_IMAGE}:${VERSION} as aws-toolz

# #COPY tools
COPY --from=rajasoun/aws-toolz-aws-vault:1.0.0                  /usr/local/bin/aws-vault                /usr/local/bin/aws-vault
# COPY --from=aws-toolz-cloud-nuke:${VERSION}                 /usr/local/bin/cloud-nuke               /usr/local/bin/cloud-nuke
# COPY --from=aws-toolz-aws-nuke:${VERSION}                   /usr/local/bin/aws-nuke                 /usr/local/bin/aws-nuke
# COPY --from=aws-toolz-awless:${VERSION}                     /usr/local/bin/awless                   /usr/local/bin/awless
# COPY --from=aws-toolz-fetch:${VERSION}                      /usr/local/bin/fetch                    /usr/local/bin/fetch
# COPY --from=aws-toolz-syft:${VERSION}                       /usr/local/bin/syft                     /usr/local/bin/syft
# COPY --from=aws-toolz-grype:${VERSION}                      /usr/local/bin/grype                    /usr/local/bin/grype
# COPY --from=aws-toolz-kubectl:${VERSION}                    /usr/local/bin/kubectl                  /usr/local/bin/kubectl
# COPY --from=aws-toolz-eksctl:${VERSION}                     /usr/local/bin/eksctl                   /usr/local/bin/eksctl
# COPY --from=aws-toolz-helm:${VERSION}                       /usr/local/bin/helm                     /usr/local/bin/helm
# COPY --from=aws-toolz-aws-iam-authenticator:${VERSION}      /usr/local/bin/aws-iam-authenticator    /usr/local/bin/aws-iam-authenticator
# COPY --from=aws-toolz-sentry:${VERSION}                     /usr/local/bin/sentry                   /usr/local/bin/sentry
# COPY --from=aws-toolz-pulumi:${VERSION}                     /usr/local/bin/pulumi                   /usr/local/bin/pulumi