FROM mcr.microsoft.com/playwright/python:latest as build-image
ENV FUNCTION_DIR="/app"

# Create function directory
RUN mkdir -p ${FUNCTION_DIR}

# Copy function code and requirements
COPY app/* ${FUNCTION_DIR}/

# Install the runtime interface client
RUN python -m pip install -r ${FUNCTION_DIR}/requirements.txt \
        --target ${FUNCTION_DIR} \
        --no-cache-dir 

# Install xvfb
RUN apt-get update && \
  apt-get install -y \
  xvfb && \
  apt-get clean && \
  apt-get autoremove

# Multi-stage build: grab a fresh copy of the base image
FROM mcr.microsoft.com/playwright/python:latest

# Copy in the build image dependencies
COPY --from=build-image ${FUNCTION_DIR} ${FUNCTION_DIR}

ADD  ./entry_script.sh              /
ADD  ./xvfb-lambda-entrypoint.sh    /
ADD  ./aws-lambda-rie               /usr/local/bin/aws-lambda-rie  

RUN chmod -R +x /entry_script.sh /xvfb-lambda-entrypoint.sh  /usr/local/bin/aws-lambda-rie ${FUNCTION_DIR}

ENTRYPOINT [ "/xvfb-lambda-entrypoint.sh" ]

CMD [ "app.handler" ]
