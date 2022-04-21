FROM ghcr.io/eloco/lambda-playwright-python:latest

# Optional
ENV XVFB_WHD=1280x720x16

# copy the lambda function
COPY app/app.py ${FUNCTION_DIR}

# copy the requirements
COPY requirements.txt  ${FUNCTION_DIR}

RUN chmod +x ${FUNCTION_DIR}*

# install the requirements
RUN  pip install -r ${FUNCTION_DIR}requirements.txt --no-cache-dir --target "${FUNCTION_DIR}"

CMD ["app.handler"]
