FROM hashicorp/terraform:0.11.7

MAINTAINER Dan Sullivan

RUN apk update
RUN apk add libvirt libvirt-dev cdrkit
COPY terraform-provider-libvirt /root/.terraform.d/plugins/
