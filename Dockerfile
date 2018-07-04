FROM amazonlinux:2017.03.1.20170812

ARG NODE_VERSION
ARG SERVERLESS_VERSION

LABEL maintainer="oss@aproint.com"
LABEL node.version="${NODE_VERSION}"
LABEL serverless.version="${SERVERLESS_VERSION}"

RUN curl --silent --location https://rpm.nodesource.com/setup_$(echo ${NODE_VERSION} | awk -F. '{print $1}').x | bash && \
    curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo

RUN yum install -y nodejs-${NODE_VERSION}* yarn

RUN yarn global add serverless@${SERVERLESS_VERSION} && yarn cache clean

CMD []
