FROM squidfunk/mkdocs-material

LABEL maintainer="adrian@ics.muni.cz"

COPY ./plugins/ /docs/plugins/
COPY ./requirements.txt .

RUN pip install -r requirements.txt ./plugins/mkdocs-monorepo-plugin


RUN git config --global --add safe.directory /docs
