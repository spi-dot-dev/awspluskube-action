FROM debian:buster as awspluskube

# Install required system packages and dependencies
ADD ./install_packages /install_packages
RUN chmod +x /install_packages
RUN ./install_packages ca-certificates curl procps sudo unzip curl

# "Install" kubectl
RUN curl -L https://dl.k8s.io/release/v1.21.0/bin/linux/amd64/kubectl > /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

# install the awscli
RUN curl -L "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"  >   \
    /awscliv2.zip && unzip awscliv2.zip &&sudo ./aws/install && /usr/local/bin/aws --version

# install the aws-iam-authenticator
RUN curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x ./aws-iam-authenticator && mv ./aws-iam-authenticator /bin/

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV PATH="/kubectl/bin:$PATH"

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "--help" ]
