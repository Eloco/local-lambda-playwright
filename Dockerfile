FROM ghcr.io/eloco/lambda-playwright-python:latest

WORKDIR ${FUNCTION_DIR}

# Optional
ENV XVFB_WHD=1280x720x16

# copy the lambda function
COPY app/app.py ${FUNCTION_DIR}

# copy the requirements
COPY requirements.txt  ${FUNCTION_DIR}

RUN chmod -R +x ${FUNCTION_DIR}

# install the requirements
RUN . venv/bin/activate; pip install --no-cache-dir -r requirements.txt

CMD ["app.handler"]
